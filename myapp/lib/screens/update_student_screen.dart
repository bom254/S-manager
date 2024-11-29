import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/student.dart';

class UpdateStudentScreen extends StatelessWidget {
  final Student student;
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();

  UpdateStudentScreen({Key? key, required this.student}) : super(key: key) {
    nameController.text = student.name;
    emailController.text = student.email;
  }

  @override
  Widget build(BuildContext context)  {
    return Scaffold(
      appBar: AppBar(
        title: Text('Update Student'),
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
                Provider.of<StudentModel>(context, listen: false).updateStudent(
                  student.id,
                  nameController.text,
                  emailController.text,
                );
                Navigator.pop(context);
              },
              child: Text('Update Student'),
            ),
          ],
        ),
      ),
    );
  }
}