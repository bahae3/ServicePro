// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:service_pro/LoginForm.dart';
import 'package:service_pro/AuthSuccess.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SignupForm extends StatefulWidget {
  const SignupForm({super.key});

  @override
  State<SignupForm> createState() => _SignupFormState();
}

class _SignupFormState extends State<SignupForm> {
  final _auth = FirebaseAuth.instance;
  String firstName = '';
  String lastName = '';
  String email = '';
  String password = '';
  String phoneNumber = '';

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
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
                    obscureText: true,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Enter your password',
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
                    onPressed: () async {
                      try {
                        final newUser =
                            await _auth.createUserWithEmailAndPassword(
                          email: email,
                          password: password,
                        );

                        await FirebaseFirestore.instance
                            .collection('users')
                            .doc(newUser.user?.uid)
                            .set({
                          'firstName': firstName,
                          'lastName': lastName,
                          'phoneNumber': phoneNumber,
                          'email': email,
                          'createdAt': FieldValue.serverTimestamp(),
                        });

                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => AuthSuccess()),
                        );
                      } catch (e) {
                        print(e);
                      }
                    },
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
                      style:
                          TextStyle(color: Colors.grey.shade600, fontSize: 16),
                    ),
                  ),
                ),
              ],
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
