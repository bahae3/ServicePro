// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'Services.dart';
import 'Profile.dart';
import 'Notification.dart';
import 'Menu.dart';

class Messages extends StatefulWidget {
  const Messages({super.key});

  @override
  State<Messages> createState() => _MessagesState();
}

class _MessagesState extends State<Messages> {
  int _selectedIndex = 3;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    if (index == 0) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => ProfileScreen()),
      );
    } else if (index == 1) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => ServicesPage()),
      );
    } else if (index == 2) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => NotificationPage()),
      );
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => Messages()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.lime,
          automaticallyImplyLeading: false,
          elevation: 0,
          title: Text('Messages'),
          actions: [
            IconButton(
              icon: Icon(Icons.menu, color: Colors.black),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MenuScreen()),
                );
              },
            ),
          ],
        ),
        body: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            _buildMessageTile(
                sender: 'Elon',
                message:
                    "Can you confirm the repair service tomorrow at 10 am?",
                function: () {
                  print('Hello');
                }),
            _buildMessageTile(
                sender: 'Ali',
                message:
                    "Your reservation is confirmed. I'll arrive at the address on time.",
                function: () {
                  print('Hello');
                }),
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Profile',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.search),
              label: 'Services',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.notifications),
              label: 'Notifications',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.mail),
              label: 'Messages',
            ),
          ],
          selectedItemColor: Colors.black,
          unselectedItemColor: Colors.grey,
          type: BottomNavigationBarType.fixed,
        ), // Messages tab
      ),
    );
  }

  Widget _buildMessageTile(
      {required String sender,
      required String message,
      required VoidCallback function}) {
    return Card(
      margin: EdgeInsets.only(bottom: 10),
      child: ListTile(
        title: Text(
          sender,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(message),
        leading: Icon(Icons.person),
        onTap: function,
      ),
    );
  }
}
