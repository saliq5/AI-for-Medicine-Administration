import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart'; // Import Firestore
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:AMAR/more.dart'; // Import the MorePage
import 'package:AMAR/edit_profile.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late String welcomeMessage = 'Welcome Back'; // Default message
  late String userEmail = '';
  late String firstName = '';
  late String lastName = '';
  bool isLoading = true; // Loading state

  @override
  void initState() {
    super.initState();
    _fetchUserData();
  }

  Future<void> _fetchUserData() async {
    setState(() {
      isLoading = true; // Set loading state to true
    });

    try {
      User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        DocumentSnapshot userDoc = await FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .get();

        if (userDoc.exists) {
          // Get user data
          var userData = userDoc.data() as Map<String, dynamic>;
          firstName = userData['firstName'] ?? '';
          lastName = userData['lastName'] ?? '';
          userEmail = user.email ?? 'User'; // Store user email

          // Create welcome message based on available data
          if (firstName.isNotEmpty || lastName.isNotEmpty) {
            welcomeMessage =
                'Welcome Back, \n${firstName.isNotEmpty ? firstName : ''} ${lastName.isNotEmpty ? lastName : ''}'
                    .trim();
          } else {
            welcomeMessage = 'Welcome Back, $userEmail';
          }
        } else {
          userEmail =
              user.email ?? 'User'; // Fallback if user document doesn't exist
          welcomeMessage = 'Welcome Back, $userEmail';
        }
      } else {
        welcomeMessage =
            'Welcome Back, User'; // Fallback if no user is logged in
      }
    } catch (e) {
      print('Failed to fetch user data: $e');
      welcomeMessage = 'Welcome Back, User'; // Fallback in case of error
    }

    setState(() {
      isLoading = false; // Set loading state to false after fetching data
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('AMAR'),
        centerTitle: true,
        backgroundColor: Colors.grey[200],
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 16.w),
            child: Image.asset(
              'assets/images/amar_logo.png',
              height: 30.h,
            ),
          ),
        ],
        leading: IconButton(
          icon: Icon(Icons.menu),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => MorePage()),
            );
          },
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(16.h),
          child: isLoading
              ? Center(child: CircularProgressIndicator())
              : Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      welcomeMessage,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 24.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: 8.h),
                    Text(
                      userEmail,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 28.sp,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(height: 20.h),
                    // Add an Edit Profile button to navigate to EditProfileScreen
                    ElevatedButton(
                      onPressed: () async {
                        // Navigate to EditProfileScreen and wait for result
                        final result = await Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => EditProfileScreen()),
                        );
                        if (result == true) {
                          // Refresh data if the profile was updated
                          await _fetchUserData();
                        }
                      },
                      child: Text('Edit Profile'),
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}
