import 'package:flutter/material.dart';

import '../Services/helper.dart';

class ActivityCard extends StatelessWidget {
  final String title;
  final String duration;
  final String certPoints;
  final String cost;
  final String status;

  const ActivityCard({super.key,
    required this.title,
    required this.duration,
    required this.certPoints,
    required this.cost,
    required this.status,
  });

  @override
  Widget build(BuildContext context) {
    final List<String> stages = ['APPLIED', 'AWAITING INTERVIEW', 'INTERVIEW PASSED', 'REGISTERED'];
    return Card(
      color: Colors.green,
      elevation: 3,
      margin: EdgeInsets.symmetric(vertical: 6.0, horizontal: 6.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Container(
        padding: EdgeInsets.only(left: 6, right: 6, top: 10, bottom: 6),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                color: Colors.white,
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Duration: $duration',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14.0,
                  ),
                ),
                Icon(Icons.play_circle_fill_rounded,
                size: 35,
                  color: Colors.white,
                ),
              ],
            ),
            SizedBox(height: 8.0),
            Container(
              height: 25,
              width: getDeviceHeight(context),
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: stages.length,
                itemBuilder: (context, index) {
                  final stage = stages[index];
                  return buildStageText(stage, status);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildStageText(String stage, String status) {
    return Container(
      margin: EdgeInsets.only(left: 8, right: 8),
      padding: const EdgeInsets.all(2.0),
      decoration: BoxDecoration(
        color: status == stage ? Colors.grey[200] : Colors.green[200],
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Center(
        child: Text(
          stage,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: status == stage ? Colors.green[800] : Colors.white54,
            fontSize: 12.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

}
