
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/student.dart';
import '../screens/update_student_screen.dart';

class StudentCard extends StatelessWidget {
  final Student student;

  const StudentCard({Key? key, required this.student}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(student.name),
        subtitle: Text(student.email),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: Icon(Icons.edit),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => UpdateStudentScreen(student: student),
                  ),
                );
              },
            ),
            IconButton(
              icon: Icon(Icons.delete),
              onPressed: () {
                Provider.of<StudentModel>(context, listen: false).deleteStudent(student.id);
              },
            ),
          ],
        ),
      ),
    );
  }
}