import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class schoolSignupPage extends StatefulWidget {
  schoolSignupPage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _schoolSignupPageState createState() => _schoolSignupPageState();
}

class _schoolSignupPageState extends State<schoolSignupPage> {
  final _formKey = GlobalKey<FormState>();
  final _fullNameController = 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                // Full Name
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Full Name',
                  ),
                  validator: (value) {
                    if(value == null || value.isEmpty) {
                      return 'Please enter your full name';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16.0),

                // Phone Number
                TextFormField(
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                    labelText: 'Phone Number',
                  ),
                  validator: (value) {
                    if(value == null || value.isEmpty) {
                      return 'Please enter your phone number';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16.0),

                // County
                DropdownButtonFormField<String>(
                  decoration: InputDecoration(
                    labelText: 'County',
                  ),
                  value: 'Select County',
                  items: <String>[],
                )
              ],
            ),
          ),
        ),
      ),
    )
  }
}