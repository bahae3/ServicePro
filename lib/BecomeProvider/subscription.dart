// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:service_pro/BecomeProvider/providerSignUp.dart';

class Subscription extends StatefulWidget {
  const Subscription({super.key});

  @override
  _SubscriptionState createState() => _SubscriptionState();
}

class _SubscriptionState extends State<Subscription> {
  String selectedPlan = 'Yearly'; // Default selected plan

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lime,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => WorkerForm()),
            );
          },
          icon: Icon(
            Icons.close,
            color: Colors.black,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
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
              SizedBox(height: 24),

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

              // Optional Subscribe button if needed

              ElevatedButton(
                onPressed: () {
                  // Navigator.of(context).push(MaterialPageRoute(
                  //     builder: (BuildContext context) => Membership()));
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black87,
                  minimumSize: Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Text('Subscribe',
                    style: TextStyle(fontSize: 18, color: Colors.white)),
              ),
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
