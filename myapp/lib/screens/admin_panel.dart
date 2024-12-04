import 'package:flutter/material.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';

class AdminPanel extends StatelessWidget {
  final TextEditingController schoolNameController = TextEditingController();
  final TextEditingController studentIdController = TextEditingController();
  final TextEditingController subjectController = TextEditingController();
  final TextEditingController gradeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin Panel'),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Add School Section
            TextField(
              controller: schoolNameController,
              decoration: InputDecoration(labelText: 'School Name'),
            ),
            ElevatedButton(
              onPressed: () async {
                // Add school logic
                await addSchool(schoolNameController.text);
                schoolNameController.clear();
              },
              child: Text('Add School'),
            ),
            SizedBox(height: 20),
            // Add student Result Section
            TextField(
              controller: studentIdController,
              decoration: InputDecoration(labelText: 'Student ID'),
            ),
            TextField(
              controller: subjectController,
              decoration: InputDecoration(labelText: 'Subject'),
            ),
            TextField(
              controller: gradeController,
              decoration: InputDecoration(labelText: 'Grade'),
            ),
            ElevatedButton(
              onPressed: () async {
                // Add result logic here
                await addResult(studentIdController.text, subjectController.text, gradeController.text);
                studentIdController.clear();
                subjectController.clear();
                gradeController.clear();              
              },
              child: Text('Add Result')
            ),
          ],
        ),
      ),
    );
  }
}

Future<void> addSchool(String name) async {
  var school = ParseObject('School')..set('name', name);
  await school.save();
}

Future<void> addResult(String studentId, String subject, String grade) async {
  var result = ParseObject('Results')
  ..set('studentId', studentId)
  ..set('subject', subject)
  ..set('grade', grade);
  await result.save();
}