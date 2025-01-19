// ignore_for_file: prefer_const_constructors

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:service_pro/LoginForm.dart';
import 'package:service_pro/ServicesAndOthersAfterLogin/Profile.dart';
import 'Contact_us.dart';

class MenuScreen extends StatelessWidget {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  void logout(BuildContext context) async {
    try {
      await _auth.signOut();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('You\'ve been logged out!')),
      );
      // Navigate to the login screen after logout
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginForm()),
      );
    } catch (e) {
      print('Error during logout: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error during logout!')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lime,
        title: Text('Menu'),
      ),
      body: ListView(
        children: [
          Container(
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(color: Colors.grey, width: 1.0),
              ),
            ),
            child: ListTile(
              leading: Icon(Icons.person),
              title: Text('My Profile'),
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ProfileScreen(),
                  ),
                );
              },
            ),
          ),
          Container(
            decoration: BoxDecoration(
              border: Border(
                bottom:
                    BorderSide(color: Colors.grey, width: 1.0), // Bottom border
              ),
            ),
            child: ListTile(
              leading: Icon(Icons.mail),
              title: Text('Contact Us'),
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ContactUsScreen(),
                  ),
                );
              },
            ),
          ),
          Container(
            decoration: BoxDecoration(
              border: Border(
                bottom:
                    BorderSide(color: Colors.grey, width: 1.0), // Bottom border
              ),
            ),
            child: ListTile(
              leading: Icon(Icons.work),
              title: Text('Become a Worker'),
              onTap: () {
                // Navigate to worker registration screen
              },
            ),
          ),
          Container(
            decoration: BoxDecoration(
              border: Border(
                bottom:
                    BorderSide(color: Colors.grey, width: 1.0), // Bottom border
              ),
            ),
            child: ListTile(
              leading: Icon(Icons.logout),
              title: Text('Logout'),
              onTap: () {
                logout(context);
              },
            ),
          ),
        ],
      ),
    );
  }
}
