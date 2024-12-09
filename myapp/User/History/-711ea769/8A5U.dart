import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';

class SignUpScreen extends StatelessWidget {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  Future<void> signUpUser (String name, String email, String password) async {
    final response = await http.post(
      Uri.parse('http://localhost:3000/api/signup'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic> {
        'name': name,
        'email': email,
        'password': password,
      }),
    );

    if(response.statusCode==201) {
      print('Signup successful');
      Navigator.pop(context);
      return print('Signup failed: ${response.body}');
    }
  }

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
                onPressed: () {
                  signUpUser(
                    nameController.text, 
                    emailController.text,
                    passwordController.text
                  );
                  
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
