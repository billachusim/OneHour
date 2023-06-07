import 'package:booking_calendar/booking_calendar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

import '../Models/bookingModel.dart';
import '../Services/firebaseServices.dart';

class BookingPage extends StatefulWidget {
  const BookingPage({Key? key}) : super(key: key);

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
        print('Error sending question: $e');
      }
    }

    prefs = await SharedPreferences.getInstance();
    prefs!.setString('booking', bookingId);
  }


  @override
  Widget build(BuildContext context) {
    return Material(
      child: Scaffold(
            appBar: AppBar(
              title: const Text('Book An Hour'),
            ),
            body: Center(
              child: BookingCalendar(
                bookingService: mockBookingService,
                convertStreamResultToDateTimeRanges: convertStreamResultFirebase,
                getBookingStream: getBookingStreamFirebase,
                uploadBooking: saveAndUploadBooking,
                pauseSlots: generatePauseSlots(),
                pauseSlotText: 'Break',
                hideBreakTime: false,
                loadingWidget: const Text('Fetching data...'),
                uploadingWidget: const CircularProgressIndicator(),
                //locale: 'hu_HU',
                startingDayOfWeek: StartingDayOfWeek.sunday,
                wholeDayIsBookedWidget:
                const Text('Sorry, for this day everything is booked'),
                //disabledDates: [DateTime(2023, 1, 20)],
                //disabledDays: [6, 7],
              ),
            ),
          ),
    );
  }
}