// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'provider_details.dart';

class ProvidersPage extends StatefulWidget {
  final String categoryName;

  const ProvidersPage({super.key, required this.categoryName});

  @override
  _ProvidersPageState createState() => _ProvidersPageState();
}

class _ProvidersPageState extends State<ProvidersPage> {
  List<Map<String, String>> providers = [];

  @override
  void initState() {
    super.initState();
    fetchProviders();
  }

  Future<void> fetchProviders() async {
    try {
      // Get the users collection where job_name matches the category
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('users')
          .where('job_name', isEqualTo: widget.categoryName)
          .get();

      List<Map<String, String>> fetchedProviders = [];
      for (var doc in querySnapshot.docs) {
        String firstName = doc['first_name'];
        String lastName = doc['last_name'];
        String phoneNumber = doc['phone_number'];
        String email = doc['email'];
        String jobName = doc['job_name'];

        fetchedProviders.add({
          'first_name': firstName,
          'last_name': lastName,
          'phone_number': phoneNumber,
          'email': email,
          'job_name': jobName
        });
      }

      print('list of providers: $fetchedProviders');

      setState(() {
        providers = fetchedProviders;
      });
    } catch (e) {
      print('Error fetching providers: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '${widget.categoryName} Providers',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.lime,
        centerTitle: true,
      ),
      body: providers.isEmpty
          ? Center(child: Text('No workers at the moment. Try again later.'))
          : ListView.builder(
              itemCount: providers.length,
              itemBuilder: (context, index) {
                return _buildProviderCard(context,
                    first_name: providers[index]['first_name']!,
                    last_name: providers[index]['last_name']!,
                    phone_number: providers[index]['phone_number']!,
                    email: providers[index]['email']!,
                    job_name: providers[index]['job_name']!);
              },
            ),
    );
  }

  Widget _buildProviderCard(BuildContext context,
      {required String first_name,
      required String last_name,
      required String phone_number,
      required String email,
      required String job_name}) {
    return SingleChildScrollView(
      child: Card(
        margin: const EdgeInsets.all(6),
        color: Colors.grey[200],
        child: ListTile(
          title: Text('$first_name $last_name',
              style: const TextStyle(fontWeight: FontWeight.bold)),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Job: $job_name'),
              const SizedBox(height: 8),
              Text('Phone number: $phone_number'),
              Text('Email: $email'),
            ],
          ),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ProviderDetailsScreen(
                  firstName: first_name,
                  lastName: last_name,
                  email: email,
                  phoneNumber: phone_number,
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
