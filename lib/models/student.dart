import 'package:flutter/foundation.dart';

class Student {
  String id;
  String name;
  String email;

  Student({required this.id, required this.name, required this.email});
}

class StudentModel with ChangeNotifier {
  List<Student> _student = [];

  List<Student> get students => _students;

  void addStudent(Student student) {
    _student.add(student);
    notifyListeners();
  }

  void updateStudent(String id, String name, String email) {
    var student = _students.firstWhere((s) => s.id == id);
    student.name = name;
    student.email = email;
    notifyListeners();
  }

  void deleteStudent(String id) {
    _students.removeWhere((s) => s.id == id);
    notifyListeners();
  }

}