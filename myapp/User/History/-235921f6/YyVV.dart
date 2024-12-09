import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String selectedRole = "Student"; // Default role

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green[900], // Background color
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 50),
            // Logo and Title
            Column(
              children: [
                Icon(Icons.menu_book, size: 80, color: Colors.white),
                SizedBox(height: 10),
                Text(
                  "Kusoma",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  "Learn from highly experienced teachers, take tests and track your performance.",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white70, fontSize: 14),
                ),
              ],
            ),
            SizedBox(height: 30),
            // Login Card
            Container(
              padding: EdgeInsets.all(20),
              margin: EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 10,
                    offset: Offset(0, 5),
                  ),
                ],
              ),
              child: Column(
                children: [
                  // Role Tabs
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _buildRoleTab("Student"),
                      _buildRoleTab("Teacher"),
                      _buildRoleTab("Parent"),
                    ],
                  ),
                  SizedBox(height: 20),
                  // Input Field
                  TextField(
                    decoration: InputDecoration(
                      labelText: "Username or Phone number",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  // Forgot Username
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () {
                        // Handle forgot username
                      },
                      child: Text(
                        "Forgot Username?",
                        style: TextStyle(color: Colors.green[700]),
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  // Continue Button
                  ElevatedButton(
                    onPressed: () {
                      // Handle login
                    },
                    style: ElevatedButton.styleFrom(
                      iconColor: Colors.green[700],
                      padding: EdgeInsets.symmetric(vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: Center(
                      child: Text(
                        "Continue",
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  // Join for Free
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("New to our platform? "),
                      GestureDetector(
                        onTap: () {
                          // Navigate to signup screen
                        },
                        child: Text(
                          "Join for Free",
                          style: TextStyle(
                            color: Colors.green[700],
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  // Contact Options
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _buildContactOption(Icons.whatshot, "WhatsApp"),
                      _buildContactOption(Icons.call, "Call"),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Helper Widget for Role Tabs
  Widget _buildRoleTab(String role) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedRole = role;
        });
      },
      child: Column(
        children: [
          Text(
            role,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: selectedRole == role ? Colors.green[700] : Colors.black54,
            ),
          ),
          if (selectedRole == role)
            Container(
              margin: EdgeInsets.only(top: 5),
              height: 2,
              width: 50,
              color: Colors.green[700],
            ),
        ],
      ),
    );
  }

  // Helper Widget for Contact Options
  Widget _buildContactOption(IconData icon, String label) {
    return Column(
      children: [
        Icon(icon, color: Colors.green[700], size: 30),
        SizedBox(height: 5),
        Text(
          label,
          style: TextStyle(color: Colors.black54),
        ),
      ],
    );
  }
}
