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
                  final response = await signUpUser(
                    nameController.text.trim(),
                    emailController.text.trim(),
                    passwordController.text.trim(),
                  );

                  // Clear input fileds if sign-up is successful
                  if(response.success) {
                    nameController.clear();
                    emailController.clear();
                    passwordController.clear();
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Sign-up successful!')),
                    );
                    Navigator.pushReplacementNamed(context, '/login');
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Sign-up failed: ${response.error?.message}')),
                    );
                  }
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

  Future<ParseResponse> signUpUser(String name, String email, String password) async {
    // ParseUser instance
    final user = ParseUser(email, password, email);

    user.set('name', name);

    return await user.signUp();
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
