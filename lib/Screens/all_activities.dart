import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:oneHour/Models/bookingModel.dart';
import 'package:oneHour/Screens/question_details.dart';
import '../bottom_nav.dart';
import '../models/questionModel.dart';
import '../services/firebaseServices.dart';

class AllActivitiesScreen extends StatefulWidget {

  const AllActivitiesScreen({Key? key,}) : super(key: key);

  @override
  _AllActivitiesScreenState createState() => _AllActivitiesScreenState();
}

class _AllActivitiesScreenState extends State<AllActivitiesScreen> {
  var currentUser = FirebaseAuth.instance.currentUser;
  bool? isFeatured;
  DateTime now = DateTime.now();



  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: (){
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => BottomNavBar()),
        );
        return Future.value(false);
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text('All Bookings'),
          automaticallyImplyLeading: true,
        ),
        body: Column(
          children: [
            StreamBuilder<List<BookingModel>>(
              stream: getAllBookings(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }

                if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return Center(
                    child: Text('No bookings yet'),
                  );
                }

                return Flexible(
                  child: ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      final booking = snapshot.data![index];
                      return GestureDetector(
                        onTap: () async {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => QuestionDetails(booking: booking),
                            ),
                          );

                        },
                        child: Container(
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black12.withOpacity(0.9),
                                spreadRadius: 2,
                                blurRadius: 3,
                                offset: Offset(0, 3), // changes position of shadow
                              ),
                            ],
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white70,
                          ),
                          margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                          padding: EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Start: ${booking.bookingStart}',
                                style: TextStyle(
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 8.0),
                              Text(
                                'End: ${booking.bookingEnd}',
                                maxLines: 3,
                                style: TextStyle(
                                  fontSize: 14.0,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              SizedBox(height: 5.0),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Icon(
                                    booking.bookingStart! == now ? Icons.lightbulb : Icons.lightbulb_outline,
                                    color: Colors.green,
                                    size: 26,
                                  ),

                                  GestureDetector(
                                    onTap: () {},
                                    child: Container(
                                      margin: EdgeInsets.only(bottom: 6),
                                      padding: EdgeInsets.all(5),
                                      width: 115,
                                      height: 30,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20.0),
                                        gradient: LinearGradient(
                                          begin: Alignment(-0.37857140550652835, -1.9473685559777252),
                                          end: Alignment(1.2428571464417884, 2.526316110739735),
                                          stops: const [0.0, 0.856177031993866, 1.0],
                                          colors: const [
                                            Colors.white54,
                                            Colors.green,
                                            Colors.lightGreenAccent,
                                          ],
                                        ),
                                      ),
                                      child: Center(
                                        child: Text('CALL',
                                          style: TextStyle(
                                              fontSize: 15.0,
                                              color: Colors.green,
                                              fontWeight: FontWeight.w700),
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Stream<List<BookingModel>> getAllBookings() {
    return FirebaseFirestore.instance
        .collection('bookings')
        .orderBy('timeOfBooking', descending: true)
        .limit(100)
        .snapshots()
        .map((querySnapshot) => querySnapshot.docs
        .map((doc) => BookingModel.fromJson(doc.data()))
        .toList());
  }


  /// Edit feature

  Future<bool?> setToFeatured(Question question) async {
    final String questionId = question.questionId;
    final value = true;
    FirebaseFirestore.instance
        .collection('bookings')
        .doc(questionId)
        .update({
      "isFeatured": value,
    },
    );
    logger.d('Successfully changed feature');
    print('Is Featured?: $value');
    isFeatured = value;
    return value;
  }


  Future<bool?> removeFromFeatured(Question question) async {
    final String questionId = question.questionId;
    final value = false;
    FirebaseFirestore.instance
        .collection('bookings')
        .doc(questionId)
        .update({
      "isFeatured": value,
    },
    );
    logger.d('Successfully changed feature');
    print('Is Featured?: $value');
    isFeatured = value;
    return value;
  }



}
