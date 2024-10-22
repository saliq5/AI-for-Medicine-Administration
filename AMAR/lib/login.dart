import 'package:flutter/material.dart';

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'), // Title of the Login page
        backgroundColor: Colors.blue,
      ),
      body: Center(
        child: Text('Login Page Content Goes Here'), // Replace with actual login form
      ),
    );
  }
}
