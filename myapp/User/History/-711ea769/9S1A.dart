import 'package:flutter/material.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';

class SignUpScreen extends StatelessWidget {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Create Account',
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.blueAccent,
                ),
              ),
              SizedBox(height: 20),
              Text(
                'Fill in the details below',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.grey[600],
                ),
              ),
              SizedBox(height: 40),
              TextField(
                controller: nameController,
                decoration: InputDecoration(
                  labelText: 'Name',
                  labelStyle: TextStyle(color: Colors.blueAccent),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Colors.blueAccent),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Colors.blue),
                  ),
                ),
              ),
              SizedBox(height: 20),
              TextField(
                controller: emailController,
                decoration: InputDecoration(
                  labelText: 'Email',
                  labelStyle: TextStyle(color: Colors.blueAccent),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Colors.blueAccent),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Colors.blue),
                  ),
                ),
              ),
              SizedBox(height: 20),
              TextField(
                controller: passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Password',
                  labelStyle: TextStyle(color: Colors.blueAccent),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Colors.blueAccent),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Colors.blue),
                  ),
                ),
              ),
              SizedBox(height: 30),
              ElevatedButton(
                onPressed: () async {
                  await signUp(context);
                },
                child:
                    Text('Sign Up'),
                style:
                    ElevatedButton.styleFrom(
                      backgroundColor:
                          Colors.blue,
                      padding:
                          EdgeInsets.symmetric(horizontal:
                              50, vertical:
                              15),
                      textStyle:
                          TextStyle(fontSize:
                              18),
                      shape:
                          RoundedRectangleBorder(borderRadius:
                              BorderRadius.circular(10)),
                    ),
              ),
              SizedBox(height:
                  20),
              TextButton(
                onPressed:
                    () {
                      // Navigate to login
                      Navigator.pop(context); // Go back to login screen
                    },
                child:
                    Text('Already have an account? Login',
                        style:
                            TextStyle(color:
                                Colors.blueAccent)),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> signUp(BuildContext context) async {
    final String name = nameController.text.trim();
    final String email = emailController.text.trim();
    final String password = passwordController.text.trim();

    // Validate input
    if(name.isEmpty || email.isEmpty || password.isEmpty) {
      _showErrorDialog(context, "All fields are required.");
      return;
    }

    // Validate email format
    if(!isValidEmail(email)) {
      _showErrorDialog(context, "Please enter a valid email address.");
      return;
    }

    // A new ParseUSer
    final user = ParseUser(email, email, email);
    user.set('name', name);

    var response = await user.signUp();

    if(response.success) {
      print("USer signed up");
      Navigator.pushReplacementNamed(context, '/login');
    } else {
      _showErrorDialog(context, "Error signing up user:\n${response.error}");
    }
  }

  bool isValidEmail(String email) {
    // Regular expression for validating an Email
    String pattern = r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$';
    RegExp regex = RegExp(pattern);
    return regex.hasMatch(email);
  }

  void _showErrorDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder:(BuildContext context) {
        return AlertDialog(
          title:
              const Text('Error'),
          content:
              Text(message),
          actions:<Widget>[
            ElevatedButton(
              onPressed:
                  () => Navigator.of(context).pop(),
              child:
                  const Text('OK'),
            )
          ],
        );
      },
    );
  }
}
