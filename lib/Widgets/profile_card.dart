import 'package:flutter/material.dart';

import '../Models/userModel.dart';

class ProfileCard extends StatelessWidget {
  final UserModel user;

  const ProfileCard({super.key,
    required this.user,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      margin: EdgeInsets.all(16.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Container(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              radius: 40,
              // Replace with user's profile photo
              backgroundImage: AssetImage('assets/images/standing.jpeg'),
            ),
            SizedBox(height: 12.0),
            Text(
              user.nickname.toString(),
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8.0),
            Text(user.email.toString()),
            SizedBox(height: 6.0),
            Text(user.phoneNumber.toString()),
            // Display last login time or other user information
          ],
        ),
      ),
    );
  }
}
