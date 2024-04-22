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
  DateTime now = DateTime.now();



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
            SizedBox(height: 8.0),
            Text(
              'Age: ${booking.age}',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8.0),
            Text(
              'City: ${booking.city}',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Icon(
                  booking.bookingStart! == now ? Icons.lightbulb : Icons.lightbulb_outline,
                  color: Colors.purple,
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
                          Colors.deepPurpleAccent,
                          Colors.purple,
                          Colors.deepPurple,
                        ],
                      ),
                    ),
                    child: Center(
                      child: Text('Take Notes',
                        style: TextStyle(
                            fontSize: 15.0,
                            color: Colors.white,
                            fontWeight: FontWeight.w700),
                      ),
                    ),
                  ),
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
                          Colors.deepPurpleAccent,
                          Colors.purple,
                          Colors.deepPurple,
                        ],
                      ),
                    ),
                    child: Center(
                      child: Text('See Profile',
                        style: TextStyle(
                            fontSize: 15.0,
                            color: Colors.white,
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
  }
}
