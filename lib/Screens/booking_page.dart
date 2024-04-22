import 'package:add_2_calendar/add_2_calendar.dart';
import 'package:booking_calendar/booking_calendar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:oneHour/Screens/profile_page.dart';
import 'package:oneHour/Screens/splash_screen.dart';
import 'package:oneHour/Widgets/home_greeting_slides.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

import '../Models/bookingModel.dart';
import '../Services/firebaseServices.dart';

class BookingPage extends StatefulWidget {
  BookingPage({Key? key}) : super(key: key);
  final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey =
  GlobalKey<ScaffoldMessengerState>();

  @override
  State<BookingPage> createState() => _BookingPageState();
}

class _BookingPageState extends State<BookingPage> {
  FirebaseServices firebaseServices = FirebaseServices();
  final now = DateTime.now();
  DateTime? bookingStart;
  DateTime? bookingEnd;
  late BookingService mockBookingService;
  var uuid = Uuid();

  @override
  void initState() {
    super.initState();
    // DateTime.now().startOfDay
    // DateTime.now().endOfDay
    mockBookingService = BookingService(
        serviceName: 'Book Hour',
        serviceDuration: 60,
        bookingEnd: DateTime(now.year, now.month, now.day, 23, 0),
        bookingStart: DateTime(now.year, now.month, now.day, 6, 0));
  }


  Event addToCalendar(String userEmail) {
    return Event(
      title: 'One Hour Call',
      description: 'You will talk with an understanding man for one hour',
      location: 'One Hour App',
      startDate: mockBookingService.bookingStart,
      endDate: mockBookingService.bookingEnd,
      allDay: false,
      iosParams: const IOSParams(
        reminder: Duration(minutes: 40),
        url: "http://nnewitech.com",
      ),
      androidParams: AndroidParams(
        emailInvites: [userEmail, "thesocialfaculty@gmail.com"],
      ),
    );
  }


  List<DateTimeRange> converted = [];
  CollectionReference bookings = FirebaseFirestore.instance.collection('bookings');

  List<DateTimeRange> generatePauseSlots() {
    return [
      DateTimeRange(
          start: DateTime(now.year, now.month, now.day, 13, 0),
          end: DateTime(now.year, now.month, now.day, 16, 0))
    ];
  }

  ///How you actually get the stream of data from Firestore with the help of the previous function
  ///note that this query filters are for my data structure, you need to adjust it to your solution.
  Stream<dynamic>? getBookingStreamFirebase(
      {required DateTime end, required DateTime start}) {
    return bookings
        .where('bookingStart', isGreaterThanOrEqualTo: start)
        .where('bookingStart', isLessThanOrEqualTo: end)
    .snapshots();
  }

  ///After you fetched the data from firestore, we only need to have a list of datetimes from the bookings:
  List<DateTimeRange> convertStreamResultFirebase(
      {required dynamic streamResult}) {
    ///here you can parse the streamresult and convert to [List<BookingModel>]
    List<BookingModel> converted = [];
    for (var i = 0; i < streamResult.size; i++) {
      final item = streamResult.docs[i].data();
      converted.add(BookingModel.fromJson(item));
    }
    return converted.map((item) => DateTimeRange(
        start: item.bookingStart!,
        end: item.bookingEnd!)).toList();
  }




  Future<dynamic> saveAndUploadBooking({required BookingService newBooking}) async {
    final user = await firebaseServices.getUserInfo();
    final nickname = user.nickname;
    final userEmail = user.email.toString();
    final city = user.city;
    final age = user.age;
    final gender = user.gender;
    final phoneNumber = user.phoneNumber;
    final bookingId = uuid.v1();
    final theBookingStart = newBooking.bookingStart;
    final theBookingEnd = newBooking.bookingEnd;

    try {
      await FirebaseFirestore.instance.collection('bookings').doc(bookingId).set({
        'userId': user.userId,
        'nickname': nickname,
        'city': city,
        'age': age,
        'gender': gender,
        'bookingId': bookingId,
        'isTrial': false,
        'phoneNumber': phoneNumber,
        'bookingStart': theBookingStart,
        'bookingEnd': theBookingEnd,
        'timeOfBooking': FieldValue.serverTimestamp(),
      },SetOptions(merge: true));
    } catch (e) {
      if (kDebugMode) {
        print('Error saving booking: $e');
      }
    }
    Add2Calendar.addEvent2Cal(
      addToCalendar(userEmail),
    );

    prefs = await SharedPreferences.getInstance();
    prefs!.setString('booking', bookingId);
  }


  @override
  Widget build(BuildContext context) {
    return Material(
      child: Scaffold(
            appBar: AppBar(
              elevation: 2,
              leading: GestureDetector(
                  onDoubleTap: () async {
                    final user = await firebaseServices.getUserInfo();
                    if (user.userType == 'ADMIN') {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ProfilePage()),
                      );
                    }
                  },
                  child: Image.asset("assets/images/aiclop.png")
              ),
              title: const Text("Book An Hour"),
            ),
            body: ListView(
              physics: const BouncingScrollPhysics(),
              shrinkWrap: true,
              children: [
                HomeGreetingSlides(),
                Container(
                  height: 700,
                  child: BookingCalendar(
                    bookingService: mockBookingService,
                    convertStreamResultToDateTimeRanges: convertStreamResultFirebase,
                    getBookingStream: getBookingStreamFirebase,
                    uploadBooking: saveAndUploadBooking,
                    pauseSlots: generatePauseSlots(),
                    pauseSlotText: 'Break',
                    hideBreakTime: false,
                    loadingWidget: const Text('Fetching data...'),
                    uploadingWidget: const SplashPage(),
                    //locale: 'hu_HU',
                    startingDayOfWeek: StartingDayOfWeek.sunday,
                    bookingButtonColor: Colors.deepPurple,
                    availableSlotColor: Colors.green,
                    selectedSlotColor: Colors.blue,
                    wholeDayIsBookedWidget:
                    const Text('Sorry, for this day everything is booked'),
                    //disabledDates: [DateTime(2023, 1, 20)],
                    //disabledDays: [6, 7],
                  ),
                ),
              ],
            ),
          ),
    );
  }
}