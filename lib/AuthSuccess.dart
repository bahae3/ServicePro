import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthSuccess extends StatefulWidget {
  @override
  _AuthSuccessState createState() => _AuthSuccessState();
}

class _AuthSuccessState extends State<AuthSuccess> {
  final _auth = FirebaseAuth.instance;

  User? loggedInUser;

  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }

  void getCurrentUser() async {
    try {
      final user = _auth.currentUser;
      if (user != null) {
        setState(() {
          loggedInUser = user;
        });
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    // Display user details or success message
    return Scaffold(
      appBar: AppBar(
        title: Text('Auth Success'),
      ),
      body: Center(
        child: loggedInUser == null
            ? CircularProgressIndicator() // Loading while checking user
            : Text('Welcome, ${loggedInUser!.email}'), // Show user info
      ),
    );
  }
}
