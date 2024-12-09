import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String selectedRole = "Student"; // Default selected role
  final TextEditingController _inputController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green[900],
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 80),
            // Logo and title
            Column(
              children: [
                Icon(Icons.menu_book, size: 80, color: Colors.white),
                SizedBox(height: 10),
                Text(
                  "ZERAKI LEARNING",
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
            SizedBox(height: 40),
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
                crossAxisAlignment: CrossAxisAlignment.start,
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
                  // Input fields and messages
                  Text(
                    _getInstructionText(),
                    style: TextStyle(color: Colors.blue[700], fontSize: 14),
                  ),
                  SizedBox(height: 10),
                  TextField(
                    controller: _inputController,
                    keyboardType: selectedRole == "Parent"
                        ? TextInputType.phone
                        : TextInputType.text,
                    decoration: InputDecoration(
                      labelText: _getInputLabel(),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  Align(
                    alignment: Alignment.centerRight,
                    child: selectedRole == "Student"
                        ? TextButton(
                            onPressed: () {
                              // Forgot Username logic
                            },
                            child: Text(
                              "Forgot Username?",
                              style: TextStyle(color: Colors.green[700]),
                            ),
                          )
                        : SizedBox(),
                  ),
                  SizedBox(height: 10),
                  // Continue Button
                  ElevatedButton(
                    onPressed: () {
                      // Handle login
                      _validateAndLogin();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green[700],
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
                          // Navigate to signup
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

  // Helper for Role Tabs
  Widget _buildRoleTab(String role) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedRole = role;
          _inputController.clear();
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

  // Contact Option Widget
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

  // Input label based on the role
  String _getInputLabel() {
    switch (selectedRole) {
      case "Teacher":
        return "Username";
      case "Parent":
        return "Phone Number";
      default:
        return "Username or Phone number";
    }
  }

  // Instruction text based on the role
  String _getInstructionText() {
    switch (selectedRole) {
      case "Teacher":
        return "Use your Zeraki Analytics Username to log in to your account.";
      case "Parent":
        return "";
      default:
        return "";
    }
  }

  // Validate input and login
  void _validateAndLogin() {
    final input = _inputController.text;
    if (input.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Please enter your ${_getInputLabel().toLowerCase()}.")),
      );
    } else {
      // Handle successful validation
      print("Logging in as $selectedRole with input: $input");
    }
  }
}
