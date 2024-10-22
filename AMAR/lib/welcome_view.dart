import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'login_signup_view.dart';  // Import the login/signup view

class WelcomeView extends StatefulWidget {
  const WelcomeView({super.key});

  @override
  _WelcomeViewState createState() => _WelcomeViewState();
}

class _WelcomeViewState extends State<WelcomeView> {
  @override
  void initState() {
    super.initState();
    // Navigate to login/signup page after 3 seconds
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const LoginSignupView()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.grey[200],  // Background color
      body: SafeArea(
        minimum: EdgeInsets.symmetric(vertical: 36.h, horizontal: 14.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,  // Center the content vertically
          children: [
            // Logo/Image Container
            Container(
              height: 120.h,
              width: double.infinity,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16.w),
                child: Image.asset(
                  'assets/images/amar_logo.png', // Ensure this image exists
                  fit: BoxFit.contain,
                ),
              ),
            ),
            SizedBox(height: 20.h), // Add space between the image and the text
            Column(
              children: [
                Text(
                  'AI Powered \n Medicine Reminder App',  // Example title
                  textAlign: TextAlign.center,
                  style: textTheme.titleLarge ?? TextStyle(fontSize: 30.sp, fontWeight: FontWeight.bold),  // Updated size
                ),
                SizedBox(height: 16.h),  // Adjusted height
              ],
            ),
          ],
        ),
      ),
    );
  }
}
