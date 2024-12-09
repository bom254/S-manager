import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Student Management',
      home: StudentListScreen(),
    );
  }
}

class StudentListScreen extends StatefulWidget {
  @override
  _StudentListScreenState createState() => _StudentListScreenState();
}

class _StudentListScreenState extends State<StudentListScreen> {
  List students = [];

  @override
  void initState() {
    super.initState();
    fetchStudents();
  }

  Future<void> fetchStudents() async {
    final response = await http.get(Uri.parse('http://localhost:3000/api/students'));
    if (response.statusCode == 200) {
      setState(() {
        students = json.decode(response.body);
      });
    } else {
      throw Exception('Failed to load students');
    }
  }

  Future<void> addStudent(String name, String email, int age, String course) async {
    final response = await http.post(
      Uri.parse('http://localhost:3000/api/students'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'name': name,
        'email': email,
        'age': age,
        'course': course,
      }),
    );

    if (response.statusCode == 201) {
      fetchStudents(); // Refresh the list
    } else {
      throw Exception('Failed to add student');
    }
  }

  Future<void> deleteStudent(int id) async {
    final response = await http.delete(Uri.parse('http://localhost:3000/api/students/$id'));
    if (response.statusCode == 200) {
      fetchStudents(); // Refresh the list
    } else {
      throw Exception('Failed to delete student');
    }
  }

  void showAddStudentDialog() {
    final nameController = TextEditingController();
    final emailController = TextEditingController();
    final ageController = TextEditingController();
    final courseController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Add Student'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(controller: nameController, decoration: InputDecoration(labelText: 'Name')),
              TextField(controller: emailController, decoration: InputDecoration(labelText: 'Email')),
              TextField(controller: ageController, decoration: InputDecoration(labelText: 'Age'), keyboardType: TextInputType.number),
              TextField(controller: courseController, decoration: InputDecoration(labelText: 'Course')),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                addStudent(
                  nameController.text,
                  emailController.text,
                  int.parse(ageController.text),
                  courseController.text,
                );
                Navigator.of(context).pop();
              },
              child: Text('Add'),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('Cancel'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Student Management'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: showAddStudentDialog,
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: students.length,
        itemBuilder: (context, index) {
          final student = students[index];
          return ListTile(
            title: Text(student['name']),
            subtitle: Text('Email: ${student['email']} | Age: ${student['age']} | Course: ${student['course']}'),
            trailing: IconButton(
              icon: Icon(Icons.delete),
              onPressed: () => deleteStudent(student['id']),
            ),
          );
        },
      ),
    );
  }
}