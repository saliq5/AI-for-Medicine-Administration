import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:AMAR/more.dart';
import 'package:AMAR/edit_profile.dart';
import 'package:AMAR/profile.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late String welcomeMessage = 'Welcome Back';
  late String userEmail = '';
  late String firstName = '';
  late String lastName = '';
  bool isLoading = true;
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _fetchUserData();
  }

  Future<void> _fetchUserData() async {
    setState(() {
      isLoading = true;
    });

    try {
      User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        DocumentSnapshot userDoc = await FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .get();

        if (userDoc.exists) {
          var userData = userDoc.data() as Map<String, dynamic>;
          firstName = userData['firstName'] ?? '';
          lastName = userData['lastName'] ?? '';
          userEmail = user.email ?? 'User';

          if (firstName.isNotEmpty || lastName.isNotEmpty) {
            welcomeMessage =
                'Welcome Back, \n${firstName.isNotEmpty ? firstName : ''} ${lastName.isNotEmpty ? lastName : ''}'
                    .trim();
          } else {
            welcomeMessage = 'Welcome Back, $userEmail';
          }
        } else {
          userEmail = user.email ?? 'User';
          welcomeMessage = 'Welcome Back, $userEmail';
        }
      } else {
        welcomeMessage = 'Welcome Back, User';
      }
    } catch (e) {
      print('Failed to fetch user data: $e');
      welcomeMessage = 'Welcome Back, User';
    }

    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'AMAR',
          style: TextStyle(
            color: Theme.of(context).colorScheme.primary,
            fontSize: 20.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
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
          icon: Icon(Icons.person, color: Theme.of(context).colorScheme.primary),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ProfilePage()),
            );
          },
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Theme.of(context).colorScheme.background, Theme.of(context).colorScheme.surface],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(16.h),
            child: isLoading
                ? Center(child: CircularProgressIndicator())
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        welcomeMessage,
                        style: TextStyle(
                          fontSize: 24.sp,
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: 8.h),
                      Text(
                        userEmail,
                        style: TextStyle(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w400,
                          color: Colors.grey[300],
                        ),
                      ),
                      SizedBox(height: 20.h),
                      ElevatedButton.icon(
                        onPressed: () async {
                          final result = await Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => EditProfileScreen()),
                          );
                          if (result == true) {
                            await _fetchUserData();
                          }
                        },
                        icon: Icon(Icons.edit),
                        label: Text('Edit Profile'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Theme.of(context).colorScheme.primary, // Replaces 'primary'
                          foregroundColor: Colors.white, // Replaces 'onPrimary'
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ),
                      SizedBox(height: 20.h),
                      _buildMedicationReminders(),
                    ],
                  ),
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
          if (index == 1) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => MorePage()),
            );
          }
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.more_horiz),
            label: 'More',
          ),
        ],
        selectedItemColor: Theme.of(context).colorScheme.primary,
        unselectedItemColor: Colors.grey,
        backgroundColor: Theme.of(context).colorScheme.surface,
      ),
    );
  }

  Widget _buildMedicationReminders() {
    return Expanded(
      child: ListView(
        children: [
          _buildReminderCard('Morning Medication', '8:00 AM', Icons.wb_sunny),
          _buildReminderCard('Afternoon Medication', '2:00 PM', Icons.wb_cloudy),
          _buildReminderCard('Evening Medication', '8:00 PM', Icons.nights_stay),
        ],
      ),
    );
  }

  Widget _buildReminderCard(String title, String time, IconData icon) {
    return Card(
      margin: EdgeInsets.only(bottom: 16.h),
      color: Theme.of(context).colorScheme.surface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        leading: Icon(icon, color: Theme.of(context).colorScheme.primary, size: 30.sp),
        title: Text(
          title,
          style: TextStyle(
            color: Colors.white,
            fontSize: 18.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
        subtitle: Text(
          time,
          style: TextStyle(
            color: Colors.grey[300],
            fontSize: 14.sp,
          ),
        ),
        trailing: Icon(Icons.arrow_forward_ios, color: Theme.of(context).colorScheme.primary),
        onTap: () {
          // TODO: Implement reminder details or actions
        },
      ),
    );
  }
}