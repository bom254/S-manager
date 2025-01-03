import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'models/student.dart';
import 'screens/home_screen.dart';

void main() {
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
        initialRoute: '/', // This will show the SplashScreen
        routes: {
          '/': (context) =>  Home(),
          '/home': (context) =>  Homescreen(),
        },
      ),
    );
  }
}

class Home extends StatelessWidget {
  const Home({Key? key});

  @override
  Widget build(BuildContext context) {
    // Automatically navigate to the LandingPage after 3 seconds
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.pushReplacementNamed(context, '/landing');
    });

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Display the logo image
            Image.asset(
              'data:image/png;base64,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',
              width: 150,
              height: 150,
            ),
            const SizedBox(height: 20),
            const Text(
              'Student Management App',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}