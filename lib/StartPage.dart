// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'Joinus.dart';

class Startpage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: OnboardingScreen(),
      routes: {
        '/becomeWorker': (context) => Joinus(),
      },
    );
  }
}

class OnboardingScreen extends StatefulWidget {
  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  int currentScreen = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              currentScreen == 0
                  ? 'images/service_photo.png'
                  : 'images/quote_photo.png',
              height: 200,
            ),
            SizedBox(height: 20),
            Text(
              currentScreen == 0 ? 'Choose a service' : 'Get a quote',
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 11),
            Text(
              currentScreen == 0
                  ? 'Find the right service for your needs easily, with a variety of options available at your fingertips.'
                  : 'Request price estimates from professionals to help you make informed decisions with ease.',
              style: TextStyle(fontSize: 17, color: Colors.grey.shade600),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 4,
                  backgroundColor:
                      currentScreen == 0 ? Colors.black : Colors.grey,
                ),
                SizedBox(width: 8),
                CircleAvatar(
                  radius: 4,
                  backgroundColor:
                      currentScreen == 1 ? Colors.black : Colors.grey,
                ),
              ],
            ),
            SizedBox(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, '/becomeWorker');
                  },
                  child: Text(
                    'Skip',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 17,
                    ),
                  ),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                  ),
                  onPressed: () {
                    if (currentScreen == 1) {
                      Navigator.pushReplacementNamed(context, '/becomeWorker');
                    } else {
                      setState(() {
                        currentScreen++;
                      });
                    }
                  },
                  child: Text(
                    'Next',
                    style: TextStyle(
                      color: Colors.green.shade300,
                      fontSize: 17,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
