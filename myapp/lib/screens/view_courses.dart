import 'package:flutter/material.dart';
import 'enroll.dart';

class ViewCoursesScreen extends StatelessWidget {
  final List<String> courses = [
    'Mathematics 101',
    'Physics 201',
    'Chemistry 301',
    'Biology 401',
    'Computer Science 501',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Courses'),
        backgroundColor: Colors.blue,
      ),
      body: ListView.builder(
        itemCount: courses.length,
        itemBuilder: (context, index) {
          return Card(
            margin: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
            child: ListTile(
              title: Text(courses[index]),
              subtitle: Text('Click to enroll in this course'),
              trailing: Icon(Icons.arrow_forward),
              onTap: () {
                // Navigate to the enrollment screen for the selected course
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => EnrollScreen(courseName: courses[index]),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
