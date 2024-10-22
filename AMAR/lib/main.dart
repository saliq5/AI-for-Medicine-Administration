import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'welcome_view.dart';  // Import your WelcomeView file

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(375, 812), // Adjust the design size according to your needs
      builder: (context, child) {
        return MaterialApp(
          title: 'AMAR',
          theme: ThemeData(
            primarySwatch: Colors.blue,
            textTheme: TextTheme(
              titleLarge: TextStyle(fontSize: 24.sp, fontWeight: FontWeight.bold),
              bodyLarge: TextStyle(fontSize: 16.sp),
            ),
          ),
          home: WelcomeView(),  // Set WelcomeView as the home screen
        );
      },
    );
  }
}
