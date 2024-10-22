import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'home.dart'; // Import the home.dart file
import 'register.dart'; // Import the Register page file
import 'login.dart'; // Import the Login page file

class LoginSignupView extends StatelessWidget {
  const LoginSignupView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.grey[200], // Example background color
      body: SafeArea(
        minimum: EdgeInsets.symmetric(vertical: 36.h, horizontal: 14.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start, // Change to start
          children: [
            // Placeholder for logo image
            Container(
              height: 120.h,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16.w),
              ),
              child: Image.asset(
                'assets/images/amar_logo.png', // Ensure this image exists
                fit: BoxFit.contain,
              ),
            ),
            SizedBox(height: 20.h), // Space between the image and the text
          
            Spacer(), // Pushes the buttons to the bottom
            _authButtonRaw(context), // Pass context to the button method
            SizedBox(height: 10.h),
            // Home button
            TextButton(
              onPressed: () {
                // Navigate directly to Home without logging in
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => Home()),
                );
              },
              child: Text('Go to Home Without Login'), // Example text for home button
            ),
          ],
        ),
      ),
    );
  }

  Widget _authButtonRaw(BuildContext context) { // Accept context as a parameter
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.white),
        borderRadius: BorderRadius.all(Radius.circular(11)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Flexible(
            child: TextButton(
              style: TextButton.styleFrom(
                backgroundColor: Colors.blue, // Example button color
                padding: EdgeInsets.symmetric(vertical: 12.h),
                foregroundColor: Colors.white, // Text color
              ),
              onPressed: () {
                // Navigate to Register page
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Register()), // Navigate to the Register page
                );
              },
              child: Text('Register'), // Example button text
            ),
          ),
          Flexible(
            child: TextButton(
              style: TextButton.styleFrom(
                backgroundColor: Colors.white,
                padding: EdgeInsets.symmetric(vertical: 12.h),
                foregroundColor: Colors.black, // Text color
              ),
              onPressed: () {
                // Navigate to the Login page
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Login()), // Navigate to the Login page
                );
              },
              child: Text('Login'), // Example button text
            ),
          ),
        ],
      ),
    );
  }
}
