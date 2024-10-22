import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';

class OtpPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.white,
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
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "AMAR",
              style: TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(width: 10), // Space between text and logo
            Image.asset(
              'assets/images/amar_logo.png',
              height: 30, // Adjust height as necessary
            ),
          ],
        ),
        centerTitle: true,
        actions: [
          // This helps to center the title by adding empty space on the right
          SizedBox(width: 50),
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 40),
          height: MediaQuery.of(context).size.height - 50,
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Column(
                children: <Widget>[
                  FadeInUp(
                      duration: Duration(milliseconds: 1000),
                      child: Text(
                        "Enter OTP",
                        style: TextStyle(
                            fontSize: 30, fontWeight: FontWeight.bold),
                      )),
                  SizedBox(
                    height: 20,
                  ),
                  FadeInUp(
                      duration: Duration(milliseconds: 1200),
                      child: Text(
                        "Enter the 5-digit OTP sent to your mobile number",
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 15, color: Colors.grey[700]),
                      )),
                ],
              ),
              Column(
                children: <Widget>[
                  FadeInUp(
                      duration: Duration(milliseconds: 1200),
                      child: makeOtpInput(context)),
                ],
              ),
              Column(
                children: [
                  FadeInUp(
                      duration: Duration(milliseconds: 1400),
                      child: Container(
                        padding: EdgeInsets.only(top: 3, left: 3),
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
                          height: 60,
                          onPressed: () {
                            // Add OTP confirmation logic here
                          },
                          color: Colors.greenAccent,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50)),
                          child: Text(
                            "Confirm OTP",
                            style: TextStyle(
                                fontWeight: FontWeight.w600, fontSize: 18),
                          ),
                        ),
                      )),
                  SizedBox(height: 20),
                  FadeInUp(
                    duration: Duration(milliseconds: 1500),
                    child: GestureDetector(
                      onTap: () {
                        // Add logic to resend OTP here
                      },
                      child: Text(
                        "Resend OTP",
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                            color: Colors.blue),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget makeOtpInput(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _otpTextField(context, first: true, last: false),
        _otpTextField(context, first: false, last: false),
        _otpTextField(context, first: false, last: false),
        _otpTextField(context, first: false, last: false),
        _otpTextField(context, first: false, last: true),
      ],
    );
  }

  Widget _otpTextField(BuildContext context,
      {required bool first, required bool last}) {
    return Container(
      height: 55,
      width: 50,
      child: TextField(
        autofocus: first,
        obscureText: true,
        keyboardType: TextInputType.number,
        textAlign: TextAlign.center,
        maxLength: 1,
        decoration: InputDecoration(
          counterText: "",
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(width: 2, color: Colors.black12),
              borderRadius: BorderRadius.circular(12)),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(width: 2, color: Colors.greenAccent),
              borderRadius: BorderRadius.circular(12)),
        ),
        onChanged: (value) {
          if (value.length == 1 && !last) {
            FocusScope.of(context).nextFocus();
          }
          if (value.isEmpty && !first) {
            FocusScope.of(context).previousFocus();
          }
        },
      ),
    );
  }
}
