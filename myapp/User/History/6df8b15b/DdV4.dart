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
              'https://marketplace.canva.com/EAFZrd-xKuc/1/0/1600w/canva-blue-modern-free-academy-logo-IZPGP0F2HBg.jpg'
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