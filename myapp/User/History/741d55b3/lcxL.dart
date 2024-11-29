import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/student.dart';
import 'add_student_screen.dart';
import '../widgets/student_card.dart';

class Homescreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Student Management'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AddStudentScreen()),
              );
            },
          ),
        ],
      ),
      body: Consumer<StudentModel>(
        builder: (context, studentModel, child) {
          return Listiew.builder(
            itemCount: studentModel.students.length,
            itemBuilder: (context, index) {
              return StudentCard(studentModel.students[index]);
            },
          );
        },
      ),
    );
  }
}