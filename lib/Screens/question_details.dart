import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../Models/questionModel.dart';
import '../Services/firebaseServices.dart';


class QuestionDetails extends StatefulWidget {
  final Question question;

  const QuestionDetails({Key? key, required this.question}) : super(key: key);

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
    final question = widget.question;

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
              question.question,
              style: TextStyle(
                fontSize: 22.0,
                fontWeight: FontWeight.bold,
                color: Colors.white70,
              ),
            ),

            SizedBox(height: 20.0),
            Text(
              'Nickname: ${question.nickname}',
              style: TextStyle(
                fontSize: 15.0,
                color: Colors.white70,
              ),
            ),
            SizedBox(height: 4.0),
            Text(
              'From: ${question.nameOfSchool}',
              style: TextStyle(
                fontSize: 14.0,
                color: Colors.white70,
              ),
            ),
            SizedBox(height: 4.0),
            Text(
              'Time: ${question.timestamp}',
              style: TextStyle(
                fontSize: 14.0,
                color: Colors.white70,
              ),
            ),
            SizedBox(height: 4.0),
            Text(
              'Is Featured = ${question.isFeatured}',
              style: TextStyle(
                fontSize: 14.0,
                color: Colors.white70,
              ),
            ),
            SizedBox(height: 20.0),

          ],
        ),
      ),
    );
  }
}
