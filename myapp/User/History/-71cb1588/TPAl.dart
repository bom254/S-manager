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
  final TextEditingController attendanceDateController = TextEditingController();

  // Dummy data for performance graphs
  List<double> subjectPerformance = [75, 85, 90];
  List<double> formPerformance = [80, 70, 85, 90];

  double averageMaths = 0;
  double averageEnglish = 0;
  double averageKiswahili = 0;

  String? selectedFilter; // For storing selected filter option
  List<Map<String, dynamic>> filteredStudents = []; // To store filtered student data

  @override 
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Teacher Panel'),
        backgroundColor: Colors.blue,
      ),
      body: Row(
        children: [
          // Input Marks Section
          Expanded(
            flex: 1,
            child: Padding(
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
                    decoration: InputDecoration(labelText: 'Maths Marks'),
                    keyboardType: TextInputType.number,
                  ),
                  TextField(
                    controller: englishMarksController,
                    decoration: InputDecoration(labelText: 'English Marks'),
                    keyboardType: TextInputType.number,
                  ),
                  TextField(
                    controller: kiswahiliMarksController,
                    decoration: InputDecoration(labelText: 'Kiswahili Marks'),
                    keyboardType: TextInputType.number,
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      await addMarks(studentIdController.text);
                      calculateAverages();
                      setState(() {}); // Refresh the UI to show averages
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

                  // Dropdown for Performance Filter
                  DropdownButton<String>(
                    hint: const Text("Select Performance Filter"),
                    value: selectedFilter,
                    items: <String>[
                      'All Students',
                      'Above Average',
                      'Below Average',
                    ].map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        selectedFilter = newValue;
                        filterStudents(); // Call filter function when selection changes
                      });
                    },
                  ),

                  // Display Filtered Results
                  Expanded(
                    child: ListView.builder(
                      itemCount: filteredStudents.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text('Student ID: ${filteredStudents[index]['studentId']}'),
                          subtitle:
                              Text('Maths:${filteredStudents[index]['maths']}, English:${filteredStudents[index]['english']}, Kiswahili:${filteredStudents[index]['kiswahili']}'),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Graphs Section
          Expanded(
            flex: 1,
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                children: [
                  ElevatedButton(
                    onPressed: () {
                      setState(() {}); // Refresh the UI to show updated graphs if needed
                    },
                    child: const Text('Show Graphs'),
                  ),
                  SizedBox(height: 20),
                  
                  // Subject Performance Graph
                  Expanded(
                    child: BarChart(BarChartData(
                      barGroups:
                          [BarChartGroupData(x :0 , barRods:[BarChartRodData(toY : subjectPerformance[0], color : Colors.blue)]) ,
                          BarChartGroupData(x :1 , barRods:[BarChartRodData(toY : subjectPerformance[1], color : Colors.green)]) ,
                          BarChartGroupData(x :2 , barRods:[BarChartRodData(toY : subjectPerformance[2], color : Colors.red)])],
                      //titlesData : FlTitlesData(showTitles:true), // Customize titles as needed
                    )),
                  ),

                  SizedBox(height :20),

                  // Form Performance Graph
                  Expanded(
                    child : BarChart(BarChartData(
                      barGroups:
                          List.generate(formPerformance.length, (index) => BarChartGroupData(x:index , barRods:[BarChartRodData(toY : formPerformance[index], color : Colors.orange)]))),
                     // titlesData : FlTitlesData(showTitles:true), // Customize titles as needed
                    )),
                ],
              ),
            ),
          ),
        ],
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
      ..set('english', englishMarks)
      ..set('kiswahili', kiswahiliMarks);
    
    await markEntry.save();
    
    print("Marks saved for student $studentId");
  }

  void calculateAverages() {
    // Calculate averages based on entered marks
    averageMaths = (averageMaths + int.tryParse(mathsMarksController.text)!) / (averageMaths == 0 ? 1 : averageMaths + 1);
    averageEnglish = (averageEnglish + int.tryParse(englishMarksController.text)!) / (averageEnglish == 0 ? 1 : averageEnglish + 1);
    averageKiswahili = (averageKiswahili + int.tryParse(kiswahiliMarksController.text)!) / (averageKiswahili == 0 ? 1 : averageKiswahili + 1);

    print("Averages calculated - Maths:$averageMaths, English:$averageEnglish, Kiswahili:$averageKiswahili");
  }

  Future<void> markAttendance(String studentId, String date) async {
    var attendanceEntry = ParseObject('Attendance')
      ..set('studentId', studentId)
      ..set('date', date)
      ..set('status', true);
    
    await attendanceEntry.save();
    
    print("Attendance marked for student $studentId on $date");
  }

  void filterStudents() async {
    double minAverage = selectedFilter == 'Above Average' ? averageMaths : selectedFilter == 'Below Average' ? averageMaths - (averageMaths * .5) : double.negativeInfinity;

    QueryBuilder<ParseObject> query = QueryBuilder<ParseObject>(ParseObject('Marks'));
    
    var response = await query.query();

    if (response.success && response.results != null) {
      filteredStudents = response.results!.map((mark) {
        double averageMarks = (mark['maths'] + mark['english'] + mark['kiswahili']) / 3; // Calculate average marks
        
        if ((selectedFilter == 'Above Average' && averageMarks >= minAverage) || 
            (selectedFilter == 'Below Average' && averageMarks < minAverage)) {
          return {
            'studentId': mark['studentId'],
            'maths': mark['maths'],
            'english': mark['english'],
            'kiswahili': mark['kiswahili'],
          };
        }
        return null; // Return null for non-matching entries
      }).where((student) => student != null).cast<Map<String, dynamic>>().toList(); // Remove null entries

      setState(() {}); // Refresh the UI to show filtered results
    } else {
      print("Error fetching students by performance");
      filteredStudents.clear(); // Clear list if there's an error
    }
  }
}
