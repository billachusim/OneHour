import 'package:flutter/material.dart';
import 'package:oneHour/Models/bookingModel.dart';
import '../Services/firebaseServices.dart';


class QuestionDetails extends StatefulWidget {
  final BookingModel booking;

  const QuestionDetails({Key? key, required this.booking}) : super(key: key);

  @override
  _QuestionDetailsState createState() => _QuestionDetailsState();
}

const int maxFailedLoadAttempts = 3;

class _QuestionDetailsState extends State<QuestionDetails> {
  final FirebaseServices firebaseServices = FirebaseServices();


  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }





  @override
  Widget build(BuildContext context) {
    final booking = widget.booking;

    return Scaffold(
      appBar: AppBar(
        title: Text('Question Details'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 4.0),

            SelectableText(
              booking.bookingId.toString(),
              style: TextStyle(
                fontSize: 22.0,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),

            SizedBox(height: 20.0),
            Text(
              'Nickname: ${booking.nickname}',
              style: TextStyle(
                fontSize: 15.0,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 4.0),
            Text(
              'From: ${booking.city}',
              style: TextStyle(
                fontSize: 14.0,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 4.0),
            Text(
              'Time: ${booking.bookingStart}',
              style: TextStyle(
                fontSize: 14.0,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 4.0),
            Text(
              'Time: ${booking.bookingEnd}',
              style: TextStyle(
                fontSize: 14.0,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 4.0),
            Text(
              'Is Featured = ${booking.isTrial}',
              style: TextStyle(
                fontSize: 14.0,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 20.0),

          ],
        ),
      ),
    );
  }
}
