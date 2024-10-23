import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:AMAR/login.dart';
import 'package:AMAR/signup.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'home.dart';
import 'package:firebase_auth/firebase_auth.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          home: AuthWrapper(),
        );
      },
    ),
  );
}

class AuthWrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasData) {
          return Home(); // Navigate to Home if user is logged in
        }
        return HomePage(); // Navigate to Login/Signup if user is not logged in
      },
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: double.infinity,
          height: MediaQuery.of(context).size.height,
          padding: EdgeInsets.symmetric(
              horizontal: 30.w, vertical: 50.h), // Use ScreenUtil here
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Column(
                children: <Widget>[
                  FadeInUp(
                      duration: Duration(milliseconds: 1000),
                      child: Text(
                        "AMAR",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 30.sp), // Use ScreenUtil here
                      )),
                  SizedBox(
                    height: 20.h, // Use ScreenUtil here
                  ),
                  FadeInUp(
                      duration: Duration(milliseconds: 1200),
                      child: Text(
                        "Harness the power of AI for effective medicine administration",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.grey[700],
                            fontSize: 15.sp), // Use ScreenUtil here
                      )),
                ],
              ),
              FadeInUp(
                  duration: Duration(milliseconds: 1400),
                  child: Container(
                    height: MediaQuery.of(context).size.height / 3,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage('assets/images/amar_logo.png'))),
                  )),
              Column(
                children: <Widget>[
                  FadeInUp(
                      duration: Duration(milliseconds: 1500),
                      child: MaterialButton(
                        minWidth: double.infinity,
                        height: 60.h, // Use ScreenUtil here
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => LoginPage()));
                        },
                        shape: RoundedRectangleBorder(
                            side: BorderSide(color: Colors.black),
                            borderRadius: BorderRadius.circular(50)),
                        child: Text(
                          "Login",
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 18.sp), // Use ScreenUtil here
                        ),
                      )),
                  SizedBox(
                    height: 20.h, // Use ScreenUtil here
                  ),
                  FadeInUp(
                      duration: Duration(milliseconds: 1600),
                      child: Container(
                        padding: EdgeInsets.only(
                            top: 3.h, left: 3.w), // Use ScreenUtil here
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            border: Border(
                              bottom: BorderSide(color: Colors.black),
                              top: BorderSide(color: Colors.black),
                              left: BorderSide(color: Colors.black),
                              right: BorderSide(color: Colors.black),
                            )),
                        child: MaterialButton(
                          minWidth: double.infinity,
                          height: 60.h, // Use ScreenUtil here
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SignupPage()));
                          },
                          color: Colors.yellow,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50)),
                          child: Text(
                            "Sign up",
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 18.sp), // Use ScreenUtil here
                          ),
                        ),
                      ))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
