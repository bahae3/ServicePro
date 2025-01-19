// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:service_pro/BecomeProvider/subscription.dart';
import 'package:service_pro/ServicesAndOthersAfterLogin/Menu.dart';

class WorkerForm extends StatefulWidget {
  @override
  WorkerFormState createState() => WorkerFormState();
}

class WorkerFormState extends State<WorkerForm> {
  String selectedPlan = 'Yearly';

  // Liste des types de travail
  final List<Map<String, dynamic>> workTypes = [
    {'title': 'Plumber', 'icon': Icons.build},
    {'title': 'Cleaning', 'icon': Icons.cleaning_services},
    {'title': 'Carpenter', 'icon': Icons.construction},
    {'title': 'Electrician', 'icon': Icons.electrical_services},
  ];

  // Valeur sélectionnée
  String? _selectedWorkType;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lime,
        title: Text('Become a Worker'),
        leading: IconButton(
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => MenuScreen()),
            );
          },
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title and description
                  Text(
                    'Choose your\nsubscription plan',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'And get a 7-day free trial',
                    style: TextStyle(color: Colors.grey, fontSize: 16),
                  ),
                  SizedBox(height: 24),

                  // Subscription plans
                  _buildPlanOption(
                    title: 'Yearly',
                    price: '450.80 DH',
                    subtitle: '-68% discount',
                    detail: 'every year',
                    isSelected: selectedPlan == 'Yearly',
                    onTap: () {
                      setState(() {
                        selectedPlan = 'Yearly';
                      });
                    },
                  ),
                  _buildPlanOption(
                    title: 'Monthly',
                    price: '50.99 DH',
                    subtitle: '-53% discount',
                    detail: 'every month',
                    isSelected: selectedPlan == 'Monthly',
                    onTap: () {
                      setState(() {
                        selectedPlan = 'Monthly';
                      });
                    },
                  ),
                  _buildPlanOption(
                    title: 'Weekly',
                    price: '10.90 DH',
                    subtitle: '',
                    detail: 'every week',
                    isSelected: selectedPlan == 'Weekly',
                    onTap: () {
                      setState(() {
                        selectedPlan = 'Weekly';
                      });
                    },
                  ),
                ],
              ),

              SizedBox(height: 16),

              Text(
                'Choose your work type',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),

              SizedBox(height: 16),

              // Liste déroulante pour Work Type
              DropdownButtonFormField<String>(
                value: _selectedWorkType,
                hint: Text('Select Work Type'),
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 10, vertical: 12),
                ),
                items: workTypes.map((workType) {
                  return DropdownMenuItem<String>(
                    value: workType['title'],
                    child: Row(
                      children: [
                        Icon(workType['icon'], color: Colors.blue),
                        SizedBox(width: 10),
                        Text(workType['title']),
                      ],
                    ),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    _selectedWorkType =
                        newValue; // Met à jour la valeur sélectionnée
                  });
                },
              ),

              SizedBox(height: 16),

              // Benefits section
              Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.blue.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Why Subscribe?',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 8),
                    _buildBenefitItem('Grow your business'),
                    _buildBenefitItem('Be Part of a Trusted Network'),
                    _buildBenefitItem('Reach over 500+ clients near you'),
                  ],
                ),
              ),

              SizedBox(height: 16),

              Center(
                child: ElevatedButton(
                  onPressed: () {
                    // Action pour soumettre le formulaire
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(builder: (context) => Subscription()),
                    // );
                  },
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  ),
                  child: Text('Submit'),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPlanOption({
    required String title,
    required String price,
    required String subtitle,
    required String detail,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 8),
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isSelected ? Colors.blue.withOpacity(0.1) : Colors.white,
          border: Border.all(
              color: isSelected ? Colors.blue : Colors.grey.shade300, width: 2),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                if (subtitle.isNotEmpty)
                  Text(
                    subtitle,
                    style: TextStyle(color: Colors.blue, fontSize: 14),
                  ),
                Text(
                  detail,
                  style: TextStyle(color: Colors.grey, fontSize: 14),
                ),
              ],
            ),
            Text(
              price,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBenefitItem(String benefit) {
    return Row(
      children: [
        Icon(Icons.star, color: Colors.blue, size: 20),
        SizedBox(width: 8),
        Text(
          benefit,
          style: TextStyle(fontSize: 14),
        ),
      ],
    );
  }
}
