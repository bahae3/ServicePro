// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'Messages.dart';
import 'Profile.dart';
import 'Menu.dart';
import 'Notification.dart';
import 'package:service_pro/providers_category.dart';

class ServicesPage extends StatefulWidget {
  const ServicesPage({super.key});

  @override
  State<ServicesPage> createState() => _ServicesPageState();
}

class _ServicesPageState extends State<ServicesPage> {
  final _auth = FirebaseAuth.instance;
  User? loggedInUser;

  @override
  void initState() {
    super.initState();
    getCurrentUser();
    fetchJobs(); // Fetch jobs when the page is loaded
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

  List<Map<String, String>> services = [];

  // Fetch jobs from Firebase Firestore
  Future<void> fetchJobs() async {
    try {
      // Get the jobs collection
      QuerySnapshot querySnapshot =
          await FirebaseFirestore.instance.collection('jobs').get();

      // Loop through the documents and build the services list
      List<Map<String, String>> fetchedServices = [];
      for (var doc in querySnapshot.docs) {
        String jobName = doc['job_name'];

        // Map the job_name to the corresponding icon (e.g., 'job_name.png')
        String iconPath =
            'images/${jobName.toLowerCase().replaceAll(' ', '_')}_icon.png';

        fetchedServices.add({
          'title': jobName,
          'icon': iconPath,
        });
      }

      setState(() {
        services = fetchedServices; // Update the list with fetched data
      });
    } catch (e) {
      print('Error fetching jobs: $e');
    }
  }

  int _selectedIndex = 1;

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
      child: MaterialApp(
        home: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.lime,
            elevation: 0,
            title: Row(
              children: [
                Image.asset(
                  'images/servicepro_logo.png',
                  width: 35,
                  height: 35,
                ),
                SizedBox(width: 8),
                Text(
                  'Service Pro',
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.w500),
                ),
              ],
            ),
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
          body: Column(
            children: [
              // Services Section
              Expanded(
                child: Container(
                  color: Colors.grey[100],
                  padding: EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Services:',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 16),
                      Expanded(
                        child: services.isEmpty
                            ? Center(child: CircularProgressIndicator())
                            : GridView.builder(
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 3,
                                  crossAxisSpacing: 16,
                                  mainAxisSpacing: 16,
                                ),
                                itemCount: services.length,
                                itemBuilder: (context, index) {
                                  return GestureDetector(
                                    onTap: () {
                                      // Perform the desired action when an item is clicked
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => ProvidersPage(
                                            categoryName: services[index]
                                                ['title']!,
                                          ),
                                        ),
                                      );
                                    },
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Container(
                                          height: 65,
                                          width: 65,
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.black12,
                                                blurRadius: 4,
                                              ),
                                            ],
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.all(8),
                                            child: Image.asset(
                                              services[index]['icon']!,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                        SizedBox(height: 8),
                                        Text(
                                          services[index]['title']!,
                                          style: TextStyle(fontSize: 14),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              ),
                      ),
                    ],
                  ),
                ),
              ),
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
          ),
        ),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
