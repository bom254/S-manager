import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';
import 'package:student_management_app/screens/teacher_panel.dart';
import 'models/student.dart';
import 'screens/enroll.dart';
import 'screens/view_courses.dart';
import 'screens/home_screen.dart';
import 'screens/admin_panel.dart';
import 'screens/profile.dart';
import 'screens/loginscreen.dart';
import 'screens/signupscreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Parse SDK
  final keyApplicationId = '8XipTN8S4A0hBPdb5LOJTJMOFGIkFvISp6IGMNPS'; // Replace with your Application ID
  final keyClientKey = '9isWy7zGq8huDlXd9qqY94L0h5KlGGsso6pzIuPC'; // Replace with your Client Key
  final keyParseServerUrl = 'https://parseapi.back4app.com'; // Replace with your Parse Server URL

  await Parse().initialize(
    keyApplicationId,
    keyParseServerUrl,
    clientKey: keyClientKey,
    debug: true,
  );

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => StudentModel(),
      child: MaterialApp(
        title: 'Student Management App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        debugShowCheckedModeBanner: false,
        initialRoute: '/login', // Change this based on your initial screen
        routes: {
          '/': (context) => const Home(),
          '/home': (context) => const Home(),
          '/login': (context) => LoginScreen(),
          '/signup': (context) => SignUpScreen(),
          '/courses': (context) => ViewCoursesScreen(),
          '/profile': (context) => ProfileScreen(),
          '/teacher': (context) => TeacherPanel(),
          '/admin': (context) => AdminPanel(),
        },
      ),
    );
  }
}

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
        backgroundColor: Colors.blue,
        actions: [
          IconButton(
            icon: Icon(Icons.book),
            tooltip: 'View Courses',
            onPressed: () {
              Navigator.pushNamed(context, '/courses');
            },
          ),
          IconButton(
            icon: Icon(Icons.add),
            tooltip: 'Enroll',
            onPressed: () {
              Navigator.pushNamed(context, '/enroll');
            },
          ),
          IconButton(
            icon: Icon(Icons.person),
            tooltip: 'View Profile',
            onPressed: () {
              Navigator.pushNamed(context, '/profile');
            },
          ),
        ],
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Welcome to the Student Management System',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.blueAccent),
              ),
              SizedBox(height: 20),
              Text('Here are some features you can explore:', style: TextStyle(fontSize: 18, color: Colors.grey[600])),
              SizedBox(height: 20),
              // Feature Cards...
            ],
          ),
        ),
      ),
    );
  }
}

// User Authentication Functions
// Future<void> signUp(String email, String password) async {
//   final user = ParseUser(email, password, null);
//   var response = await user.signUp();
  
//   if (response.success) {
//     print("User signed up");
//   } else {
//     print("Error signing up user: ${response.error}");
//   }
// }

// Future<void> login(String email, String password) async {
//   final user = ParseUser(email, password, null);
//   var response = await user.login();
  
//   if (response.success) {
//     print("User logged in");
//     await getUserRole(user.objectId!); // Corrected function name
//   } else {
//     print("Error logging in user: ${response.error}");
//   }
// }

// Future<void> getUserRole(String userId) async {
//   QueryBuilder<ParseObject> query = QueryBuilder<ParseObject>(ParseObject('UserRoles'));
//   query.whereEqualTo('userId', userId);
  
//   var response = await query.query();
  
//   if (response.success && response.results != null && response.results!.isNotEmpty) {
//     String role = response.results![0]['role'];
//     print("User Role: $role");
//     navigateBasedOnRole(role);
//   }
// }

// void navigateBasedOnRole(String role) {
//   if (role == 'admin') {
//     Navigator.pushReplacementNamed(context, '/admin');
//   } else if (role == 'teacher') {
//     Navigator.pushReplacementNamed(context, '/teacher');
//   } else if (role == 'student') {
//     Navigator.pushReplacementNamed(context, '/student'); // Ensure this route exists
//   }
//}

// Role-Based Widget
// class RoleBasedWidget extends StatelessWidget {
//   final String allowedRole;
//   final Widget child;

//   const RoleBasedWidget({required this.allowedRole, required this.child});

//   @override
//   Widget build(BuildContext context) {
//    // String currentUserRole = Provider.of<UserProvider>(context).userRole; // Ensure UserProvider is implemented correctly

//    // return currentUserRole == allowedRole ? child : Container(); // Render nothing if not allowed
//   }
// }
