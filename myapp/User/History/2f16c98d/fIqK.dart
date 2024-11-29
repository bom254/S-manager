import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/student.dart';

class AddStudentScreen extends StatelessWidget {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Student'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: nameController,
              decoration: InputDecoration(labelText: 'Name'),
            ),
            TextField(
              controller: emailController,
              decoration: InputDecoration(labelText: 'Email'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                final student = Student(
                  id: DateTime.now().toString(),
                  name: nameController.text,
                  email: emailController.text,
                );
                Provider.of<StudentModel>(context, listen: false).addStudent(student);
                Navigator.pop(context);
              },
              child: Text('Add Student'),
            ),
          ],
        ),
      ),
    );
  }
}