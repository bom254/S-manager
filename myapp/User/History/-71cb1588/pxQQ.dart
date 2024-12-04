import 'package:flutter/material.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';
import 'package:fl_chart/fl_chart.dart';

class TeacherPanel extends StatefulWidget {
  @override
  _TeacherPanelState createState() => _TeacherPanelState();
}

class _TeacherPanelState extends State<TeacherPanel> {
  final TextEditingController studentIdController = TextEditingController();
  final TextEditingController mathsMarksController = TextEditingController();
  final TextEditingController englishMarksController = TextEditingController();
  final TextEditingController kiswahiliMarksController = TextEditingController();
  final TextEditingController filterAverageController = TextEditingController();
  final TextEditingController attendanceDateController = TextEditingController();

  List<Map<String, dynamic>> filteredStudents = []; // To store filtered student data

  // Dummy data for performance graphs
  List<double> subjectPerformance = [75, 85, 90];
  List<double> formPerformance = [80, 70, 85, 90];

  @override 
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Teacher Panel'),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Input Marks section
            TextField(
              controller: studentIdController,
              decoration: InputDecoration(labelText: 'Student Id'),
            ),
            TextField(
              controller: mathsMarksController,
              decoration: InputDecoration(labelText: 'Maths'),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: englishMarksController,
              decoration: InputDecoration(labelText: 'English'),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: kiswahiliMarksController,
              decoration: InputDecoration(labelText: 'Kiswahili'),
              keyboardType: TextInputType.number,
            ),
            ElevatedButton(
              onPressed: () async {
                await addMarks(studentIdController.text);
                studentIdController.clear();
                mathsMarksController.clear();
                englishMarksController.clear();
                kiswahiliMarksController.clear();
              },
              child: const Text('Submit Marks'),
            ),
            SizedBox(height: 20),

            // Attendance Section
            TextField(
              controller: attendanceDateController,
              decoration: InputDecoration(labelText: 'Attendance Date (YYYY-MM-DD)'),
            ),
            ElevatedButton(
              onPressed: () async {
                await markAttendance(studentIdController.text, attendanceDateController.text);
                attendanceDateController.clear();
              },
              child: const Text('Mark Attendance'),
            ),

            SizedBox(height: 20),

            // Filtered Students Section
            TextField(
              controller: filterAverageController,
              decoration: InputDecoration(labelText: 'Minimum Average Marks'),
              keyboardType: TextInputType.number,
            ),
            ElevatedButton(
              onPressed: () async {
                double minAverage = double.tryParse(filterAverageController.text) ?? 0;
                filteredStudents = await filteredStudentsByPerformance(minAverage);
                setState(() {}); // Refresh the UI to show filtered results
                filterAverageController.clear();
              },
              child: const Text('Filter Studnets'),
            ),

            // Display Filtered Results
            Expanded(
              child: ListView.builder(
                itemCount: filteredStudents.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text('Student ID: ${filteredStudents[index]['studentId']}'),
                    subtitle: Text('Maths: ${filteredStudents[index]['maths']}, English: ${filteredStudents[index]['english']}, Ksiwahili: ${filteredStudents[index]['kiswahili']}}'),
                  );
                },
              ),
            ),
            SizedBox(height: 20),
            // Performance Graphs Section
            Expanded(
              child: Column(
                children: [
                  Text('Subject Permance', style: TextStyle(fontSize: 18)),
                  Container(
                    height: 200,
                    child: BarChart(BarChartData(
                      barGroups: [
                        BarChartGroupData(x: 0, barRods: [BarChartRodData(toY: subjectPerformance[0], color: Colors.blue)]),
                        BarChartGroupData(x: 1, barRods: [BarChartRodData(toY: subjectPerformance[1], color: Colors.green)]),
                        BarChartGroupData(x: 2, barRods: [BarChartRodData(toY: subjectPerformance[2], color: Colors.red)]),
                        titleData: FlTitlesData(showTitles: true),
                      ],
                    )),
                  ),
                  SizedBox(height: 20),
                  Text('Form Performance', style: TextStyle(fontSize: 18)),
                  Flexible(
                    child: Container(
                      height: 200,
                      child: BarChart(BarChartData(
                        barGroups: 
                        List.generate(formPerformance.length, (index) => BarChartGroupData(x: index, barRods: [BarChartRodData(toY: formPerformance[index], color: Colors.orange)])),
                        titlesData: FlTitlesData(showTitles: true),
                      )),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> addMarks(String studentId) async {
    int mathsMarks = int.tryParse(mathsMarksController.text) ?? 0;
    int englishMarks = int.tryParse(englishMarksController.text) ?? 0;
    int kiswahiliMarks = int.tryParse(kiswahiliMarksController.text) ?? 0;

    var markEntry = ParseObject('Marks')
    ..set('studentId', studentId)
    ..set('maths', mathsMarks)
    ..set('kiswahili', englishMarks)
    ..set('kiswahili', kiswahiliMarks);
    await markEntry.save();
  }

  Future<void> markAttendance(String studentId, String date) async {
    var attendanceEntry = ParseObject('Attendance')
    ..set('studentId', studentId)
    ..set('date', date)
    ..set('status', true);
    await attendanceEntry.save();
  }

  Future<List<Map<String, dynamic>>> filteredStudentsByPerformance(double minAverage) async {
    QueryBuilder<ParseObject> query = QueryBuilder<ParseObject>(ParseObject('Marks'));

    var response = await query.query();

    if(response.success && response.results != null) {
      return response.results!.map((mark) {
        double averageMarks = (mark['maths'] + mark['english'] + mark['kiswahili']) / 3;  // Calcualte average marks

        if(averageMarks >= minAverage) {
          // Filter by average marks
          return {
            'studentId': mark['studentId'],
            'maths': mark['maths'],
            'english': mark['english'],
            'kiswahili': mark['kiswahili'],
          };
        }
        return null; // Return null for non-matching entries
      }).where((student) => student != null).cast<Map<String, dynamic>>().toList();
    } else {
      print("Error fetching students by performance");
      return[];
    }
  }
}