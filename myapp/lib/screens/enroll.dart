import 'package:flutter/material.dart';

class EnrollScreen extends StatelessWidget {
  final String courseName;

  EnrollScreen({required this.courseName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Enroll in $courseName'),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'You are about to enroll in:',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              courseName,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.blueAccent),
            ),
            SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                // Handle enrollment logic here
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Successfully enrolled in $courseName!')),
                );
                Navigator.pop(context); // Go back to the courses list
              },
              child: Text('Enroll Now'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                textStyle: TextStyle(fontSize: 18),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
