import 'package:flutter/material.dart';

class Register extends StatelessWidget {
  const Register({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Register'), // Title of the register page
        backgroundColor: Colors.blue,
      ),
      body: Center(
        child: Text('Register Page Content Goes Here'), // Replace with actual registration form
      ),
    );
  }
}
