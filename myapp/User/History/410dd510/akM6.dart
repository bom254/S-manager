import 'package:flutter/material.dart';

class kusomaLogin extends StatefulWidget {
  @override
  _kusomaLoginState createState() => _kusomaLoginState();
}

class _kusomaLoginState extends State<kusomaLogin> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Kusoma'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Create your account',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Text(
              'Select your role below to continue',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 30),
            RoleCard(
              icon: Icons.person,
              title: 'Student',
              description: 'Access comprehensive course materials and tests created by expert educators.',
            ),
            SizedBox(height: 15),
            RoleCard(
              icon: Icons.people,
              title: 'Parent',
              description: 'Access your child\'s progress for lessons, quiz results, and performance metrics.',
            ),
            SizedBox(height: 15),
            RoleCard(
              icon: Icons.school,
              title: 'School',
              description: 'Allows teachers to share learning materials with students from a centralized platform.',
            ),
            SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                // TODO: Handle button press
              },
              style: ElevatedButton.styleFrom(
                iconColor: Colors.green,
                padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                textStyle: TextStyle(fontSize: 18),
              ),
              child: Text('Next'),
            ),
          ],
        ),
      ),
    );
  }
}

class RoleCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;

  RoleCard({required this.icon, required this.title, required this.description});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: <Widget>[
            Icon(icon, size: 40),
            SizedBox(width: 20),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    title,
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 5),
                  Text(description),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}