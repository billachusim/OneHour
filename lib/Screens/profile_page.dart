import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../Models/bookingModel.dart';
import '../Services/firebaseServices.dart';
import '../Services/helper.dart';
import '../Widgets/activity_card.dart';
import '../bottom_nav.dart';
import '../models/userModel.dart';


class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  var currentUser = FirebaseAuth.instance.currentUser;
  FirebaseServices firebaseServices = FirebaseServices();
  UserModel? user;

  @override
  void initState() {
    super.initState();
    _getUserInfo();
  }

  Future<void> _getUserInfo() async {
    final fetchedUser = await firebaseServices.getUserInfo();
    setState(() {
      user = fetchedUser as UserModel?;
    });
  }


  Stream<List<BookingModel>> getBookings(String userId) {
    return FirebaseFirestore.instance
        .collection('bookings')
    //.where('userId', isEqualTo: userId)
        .orderBy('bookingStart', descending: true)
        .snapshots()
        .map((querySnapshot) => querySnapshot.docs
        .map((doc) => BookingModel.fromJson(doc.data()))
        .toList());
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) async {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => BottomNavBar()),
        );
        return Future.value(false);
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text('Records'),
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [

              /*if (user != null)
                ProfileCard(user: user!),*/

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Text(
                        'Certifications',
                        style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      // Navigate to see all departments page
                    },
                    child: Text(
                      'Internships',
                      style: TextStyle(
                        fontSize: 15.0,
                        color: Colors.green,
                      ),
                    ),
                  ),
                ],
              ),
              // Display Activity Cards with applied careers fetched from Firestore
              Container(
                height: 500,
                width: getDeviceWidth(context),
                child: StreamBuilder<List<BookingModel>>(
                  stream: getBookings(currentUser!.uid),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }

                    if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return Center(
                        child: Text('No careers yet'),
                      );
                    }

                    return ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        final session = snapshot.data![index];
                        return ActivityCard(
                            title: session.nickname!,
                            duration: session.phoneNumber!,
                            certPoints: session.age!,
                            cost: session.callDuration!,
                            status: session.city!
                        );
                      },
                    );
                  },
                ),
              ),
              // Add more ActivityCard widgets for other applied careers here...
            ],
          ),
        ),
      ),
    );
  }
}
