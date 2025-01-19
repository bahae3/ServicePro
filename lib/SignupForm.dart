// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:service_pro/LoginForm.dart';
import 'package:service_pro/ServicesAndOthersAfterLogin/Services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SignupForm extends StatefulWidget {
  const SignupForm({super.key});

  @override
  State<SignupForm> createState() => _SignupFormState();
}

class _SignupFormState extends State<SignupForm> {
  String firstName = '';
  String lastName = '';
  String email = '';
  String password = '';
  String phoneNumber = '';

  bool _isPasswordVisible = false;

  final _auth = FirebaseAuth.instance;

  Future<void> _signUp() async {
    try {
      // Create user with Firebase Authentication
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // After successful signup, add user data to Firestore
      CollectionReference collRef =
          FirebaseFirestore.instance.collection('users');
      collRef.doc(userCredential.user?.uid).set({
        'first_name': firstName,
        'last_name': lastName,
        'email': email,
        'phone_number': phoneNumber,
        'password': password,
        'is_provider': false,
        'is_admin': false,
        'id_job': 0
      });

      // Navigate to the next screen (e.g., Services or Home)
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => ServicesPage()),
      );
    } on FirebaseAuthException catch (e) {
      // Show error message if any
      String errorMessage = e.message ?? 'An error occurred';
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Signup Failed'),
          content: Text(errorMessage),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.lime,
            centerTitle: true,
            automaticallyImplyLeading: false,
            title: Text(
              'Sign Up',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 45,
                vertical: 20,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Center(
                    child: Image.asset(
                      'images/servicepro_logo.png',
                      height: 100,
                      width: 100,
                    ),
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  // First name
                  Text(
                    'First name:',
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 6, vertical: 10),
                    child: TextField(
                      onChanged: (value) {
                        firstName = value;
                      },
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'e.g.: John',
                      ),
                    ),
                  ),

                  SizedBox(
                    height: 8,
                  ),

                  // Last Name
                  Text(
                    'Last name:',
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 6, vertical: 10),
                    child: TextField(
                      onChanged: (value) {
                        lastName = value;
                      },
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'e.g.: Doe',
                      ),
                    ),
                  ),

                  SizedBox(
                    height: 8,
                  ),

                  // Email
                  Text(
                    'Email:',
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 6, vertical: 10),
                    child: TextField(
                      onChanged: (value) {
                        email = value;
                      },
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'e.g.: bahae@example.com',
                      ),
                    ),
                  ),

                  SizedBox(
                    height: 8,
                  ),

                  // Password
                  Text(
                    'Password:',
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 6, vertical: 10),
                    child: TextField(
                      onChanged: (value) {
                        password = value;
                      },
                      keyboardType: TextInputType.visiblePassword,
                      obscureText: !_isPasswordVisible,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Enter your password',
                        suffixIcon: IconButton(
                          icon: Icon(
                            // Change the icon based on whether the password is visible
                            _isPasswordVisible
                                ? Icons.visibility
                                : Icons.visibility_off,
                          ),
                          onPressed: () {
                            // Toggle the password visibility state
                            setState(() {
                              _isPasswordVisible = !_isPasswordVisible;
                            });
                          },
                        ),
                      ),
                    ),
                  ),

                  SizedBox(
                    height: 8,
                  ),

                  // Phone number
                  Text(
                    'Phone Number (with country code):',
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 6, vertical: 10),
                    child: TextField(
                      onChanged: (value) {
                        phoneNumber = value;
                      },
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'e.g.: +212 6 12 34 56 78',
                      ),
                    ),
                  ),

                  SizedBox(
                    height: 14,
                  ),

                  SizedBox(
                    width: double.infinity,
                    height: 45,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                      onPressed: _signUp,
                      child: Text(
                        'Sign Up',
                        style: TextStyle(
                          fontSize: 17,
                        ),
                      ),
                    ),
                  ),
                  Center(
                    child: TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => LoginForm()),
                        );
                      },
                      child: Text(
                        'Log In',
                        style: TextStyle(
                            color: Colors.grey.shade600, fontSize: 16),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// Become worker things

// List<String> workType = [
//   'Plumber',
//   'Joiner',
//   'Blacksmith',
//   'Dyer',
//   'Mechanical'
// ];

// String dropdownValueWorkType = workType.first;

// Text(
//   'Work type',
//   style: TextStyle(
//     fontSize: 17,
//     fontWeight: FontWeight.w500,
//   ),
// ),
// Padding(
//   padding: EdgeInsets.symmetric(horizontal: 6, vertical: 10),
//   child: DropdownMenu<String>(
//     width: double.infinity,
//     initialSelection: workType.first,
//     onSelected: (String? value) {
//       setState(() {
//         dropdownValueWorkType = value!;
//       });
//     },
//     dropdownMenuEntries:
//         workType.map<DropdownMenuEntry<String>>((String value) {
//       return DropdownMenuEntry<String>(
//           value: value, label: value);
//     }).toList(),
//   ),
// ),

// ...InputForm(
//     'Years of experience', 'e.g.: 5', TextInputType.number),
