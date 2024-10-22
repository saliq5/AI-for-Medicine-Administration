import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('AMAR'), // Title of the app bar
        centerTitle: true,
        backgroundColor: Colors.grey[200], // App bar color
        actions: [
          // Logo on the right side of the app bar
          Padding(
            padding: EdgeInsets.only(right: 16.w), // Right padding for the logo
            child: Image.asset(
              'assets/images/amar_logo.png', // Replace with your logo path
              height: 30.h, // Height of the logo
            ),
          ),
        ],
        leading: IconButton(
          icon: Icon(Icons.menu), // Hamburger menu icon
          onPressed: () {
            // Open the menu
            _showMenu(context);
          },
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(16.h), // Padding for the content
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              // Welcome message
              Text(
                'Welcome Back,', // Welcome message
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 24.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),

              Text(
                'Satyam', // Welcome message
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 48.sp,
                  fontWeight: FontWeight.w700,
                ),
              ),
              // Profile button
            ],
          ),
        ),
      ),

      
      
    );
  }

  // Function to show the menu options
  void _showMenu(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: EdgeInsets.all(16.h),
          height: 200.h, // Height of the bottom sheet
          child: Column(
            children: [
              ListTile(
                leading: Icon(Icons.person), // Profile icon
                title: Text('View Profile'),
                onTap: () {
                  Navigator.pop(context);
                  // Navigate to profile page
                  // Navigator.push(context, MaterialPageRoute(builder: (context) => ProfilePage()));
                },
              ),
              ListTile(
                leading: Icon(Icons.logout), // Logout icon
                title: Text('Logout'),
                onTap: () {
                  Navigator.pop(context);
                  // Handle logout action
                  // For example, navigate back to the login screen
                  // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginSignupView()));
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
