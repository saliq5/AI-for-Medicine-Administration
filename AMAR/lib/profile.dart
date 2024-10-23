import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    User? user = FirebaseAuth.instance.currentUser;

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios,
            size: 20,
            color: Colors.black,
          ),
        ),
        title: Text(
          "AMAR",
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 16.0),
            child: Image.asset(
              'assets/images/amar_logo.png',
              height: 30,
            ),
          ),
        ],
      ),
      body: user != null
          ? FutureBuilder<DocumentSnapshot>(
              future: FirebaseFirestore.instance
                  .collection('users')
                  .doc(user.uid)
                  .get(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }
                if (snapshot.hasError) {
                  return Center(child: Text('Error loading profile.'));
                }
                if (!snapshot.hasData || !snapshot.data!.exists) {
                  return Center(child: Text('No profile found.'));
                }

                // Extract user data
                var userData = snapshot.data!.data() as Map<String, dynamic>;
                return SingleChildScrollView(
                  // Add SingleChildScrollView here
                  child: Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // User Email
                        _buildProfileField(
                          icon: Icons.email,
                          title: 'Email',
                          value: user.email!,
                        ),
                        // User First Name
                        _buildProfileField(
                          icon: Icons.person,
                          title: 'First Name',
                          value: userData['firstName'] ?? 'N/A',
                        ),
                        // User Last Name
                        _buildProfileField(
                          icon: Icons.person,
                          title: 'Last Name',
                          value: userData['lastName'] ?? 'N/A',
                        ),
                        // User Age
                        _buildProfileField(
                          icon: Icons.calendar_today,
                          title: 'Age',
                          value: userData['age']?.toString() ?? 'N/A',
                        ),
                        // User Address
                        _buildProfileField(
                          icon: Icons.location_on,
                          title: 'Address',
                          value: userData['address'] ?? 'N/A',
                        ),
                        // User Mobile Number
                        _buildProfileField(
                          icon: Icons.phone,
                          title: 'Mobile Number',
                          value: userData['mobileNumber'] ?? 'N/A',
                        ),
                        // User Gender
                        _buildProfileField(
                          icon: Icons.transgender,
                          title: 'Gender',
                          value: userData['gender'] ?? 'N/A',
                        ),
                        // User Meal Times
                        _buildProfileField(
                          icon: Icons.access_time,
                          title: 'Breakfast Time',
                          value: userData['breakfastTime'] ?? 'N/A',
                        ),
                        _buildProfileField(
                          icon: Icons.access_time,
                          title: 'Lunch Time',
                          value: userData['lunchTime'] ?? 'N/A',
                        ),
                        _buildProfileField(
                          icon: Icons.access_time,
                          title: 'Dinner Time',
                          value: userData['dinnerTime'] ?? 'N/A',
                        ),
                      ],
                    ),
                  ),
                );
              },
            )
          : Center(
              child: Text(
                'No user is logged in.',
                style: TextStyle(fontSize: 24),
              ),
            ),
    );
  }

  Widget _buildProfileField({
    required IconData icon,
    required String title,
    required String value,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Card(
        elevation: 2,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              Icon(
                icon,
                size: 30,
                color: Colors.greenAccent,
              ),
              SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      value,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[700],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
