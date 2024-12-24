// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'HomePage.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(ServicePro());
}

class ServicePro extends StatefulWidget {
  const ServicePro({super.key});

  @override
  State<ServicePro> createState() => _ServiceProState();
}

class _ServiceProState extends State<ServicePro> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

// HomePage()
