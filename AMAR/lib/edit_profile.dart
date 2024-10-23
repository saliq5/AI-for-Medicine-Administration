import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class EditProfileApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return EditProfileScreen();
  }
}

class EditProfileScreen extends StatefulWidget {
  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  // Profile fields
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController mobileNumberController = TextEditingController();

  String gender = 'Male'; // Default gender selection

  // Meal times
  TimeOfDay breakfastTime = TimeOfDay.now();
  TimeOfDay lunchTime = TimeOfDay.now();
  TimeOfDay dinnerTime = TimeOfDay.now();

  @override
  void initState() {
    super.initState();
    _fetchUserData(); // Fetch user data when the screen initializes
  }

  Future<void> _fetchUserData() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      DocumentSnapshot doc = await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .get();
      if (doc.exists) {
        setState(() {
          firstNameController.text = doc['firstName'] ?? '';
          lastNameController.text = doc['lastName'] ?? '';
          ageController.text =
              doc['age']?.toString() ?? ''; // Convert to string
          addressController.text = doc['address'] ?? '';
          mobileNumberController.text = doc['mobileNumber'] ?? '';
          gender = doc['gender'] ?? 'Male'; // Default gender if null

          // Convert stored time strings back to TimeOfDay
          breakfastTime = _timeFromString(doc['breakfastTime']);
          lunchTime = _timeFromString(doc['lunchTime']);
          dinnerTime = _timeFromString(doc['dinnerTime']);
        });
      }
    }
  }

  // Helper function to convert "HH:mm" string to TimeOfDay
  TimeOfDay _timeFromString(String? time) {
    if (time == null || time.isEmpty) return TimeOfDay.now();
    final parts =
        time.split(':'); // Assumes the time is stored in "HH:mm" format
    return TimeOfDay(hour: int.parse(parts[0]), minute: int.parse(parts[1]));
  }

  Future<void> _selectTime(BuildContext context, String meal) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: meal == 'Breakfast'
          ? breakfastTime
          : meal == 'Lunch'
              ? lunchTime
              : dinnerTime,
    );
    if (picked != null) {
      setState(() {
        if (meal == 'Breakfast') {
          breakfastTime = picked;
        } else if (meal == 'Lunch') {
          lunchTime = picked;
        } else {
          dinnerTime = picked;
        }
      });
    }
  }

  void _submit() async {
    if (firstNameController.text.isEmpty ||
        lastNameController.text.isEmpty ||
        ageController.text.isEmpty ||
        addressController.text.isEmpty ||
        mobileNumberController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please fill in all fields!')),
      );
      return; // Exit early if validation fails
    }

    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      DocumentReference userDoc =
          FirebaseFirestore.instance.collection('users').doc(user.uid);

      // Profile data to save
      Map<String, dynamic> profileData = {
        'firstName': firstNameController.text,
        'lastName': lastNameController.text,
        'age': ageController.text.isNotEmpty
            ? int.parse(ageController.text)
            : null, // Save age as int if not empty
        'address': addressController.text,
        'mobileNumber': mobileNumberController.text,
        'gender': gender,
        'breakfastTime':
            '${breakfastTime.hour}:${breakfastTime.minute.toString().padLeft(2, '0')}', // Save as "HH:mm"
        'lunchTime':
            '${lunchTime.hour}:${lunchTime.minute.toString().padLeft(2, '0')}',
        'dinnerTime':
            '${dinnerTime.hour}:${dinnerTime.minute.toString().padLeft(2, '0')}',
      };

      try {
        // Check if user document exists
        DocumentSnapshot doc = await userDoc.get();
        if (doc.exists) {
          await userDoc.update(profileData);
        } else {
          await userDoc.set(profileData);
        }

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Profile saved successfully!')),
        );
        Navigator.pop(
            context, true); // Notify that the profile has been updated
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error saving profile: $e')),
        );
      }
    }
  }

  Widget makeInput({
    required String label,
    TextInputType keyboardType = TextInputType.text,
    TextEditingController? controller,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          label,
          style: TextStyle(
              fontSize: 15, fontWeight: FontWeight.w400, color: Colors.black87),
        ),
        SizedBox(height: 5),
        TextField(
          keyboardType: keyboardType,
          controller: controller,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey.shade400)),
            border: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey.shade400)),
          ),
        ),
        SizedBox(height: 20),
      ],
    );
  }

  Widget makeGenderDropdown() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          "Gender",
          style: TextStyle(
              fontSize: 15, fontWeight: FontWeight.w400, color: Colors.black87),
        ),
        SizedBox(height: 5),
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade400),
            borderRadius: BorderRadius.circular(4),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: gender,
              onChanged: (String? newValue) {
                setState(() {
                  gender = newValue!;
                });
              },
              items: <String>['Male', 'Female', 'Others']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: Text(value),
                  ),
                );
              }).toList(),
              isExpanded: true,
              dropdownColor: Colors.white,
            ),
          ),
        ),
        SizedBox(height: 20),
      ],
    );
  }

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
        title: Text(
          "AMAR",
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 16.0),
            child: Image.asset(
              'assets/images/amar_logo.png',
              height: 30,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            children: <Widget>[
              FadeInUp(
                duration: Duration(milliseconds: 300),
                child: Text(
                  "Edit Profile",
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(height: 20),
              FadeInUp(
                duration: Duration(milliseconds: 400),
                child: Text(
                  "Update your information",
                  style: TextStyle(fontSize: 15, color: Colors.grey[700]),
                ),
              ),
              SizedBox(height: 20),
              FadeInUp(
                duration: Duration(milliseconds: 500),
                child: makeInput(
                  label: "First Name",
                  controller: firstNameController,
                ),
              ),
              FadeInUp(
                duration: Duration(milliseconds: 600),
                child: makeInput(
                  label: "Last Name",
                  controller: lastNameController,
                ),
              ),
              FadeInUp(
                duration: Duration(milliseconds: 700),
                child: makeInput(
                  label: "Age",
                  keyboardType: TextInputType.number,
                  controller: ageController,
                ),
              ),
              FadeInUp(
                duration: Duration(milliseconds: 800),
                child: makeGenderDropdown(),
              ),
              FadeInUp(
                duration: Duration(milliseconds: 900),
                child: makeInput(
                  label: "Address",
                  controller: addressController,
                ),
              ),
              FadeInUp(
                duration: Duration(milliseconds: 1000),
                child: makeInput(
                  label: "Mobile Number",
                  keyboardType: TextInputType.phone,
                  controller: mobileNumberController,
                ),
              ),
              SizedBox(height: 20),
              FadeInUp(
                duration: Duration(milliseconds: 1100),
                child: ListTile(
                  title:
                      Text('Breakfast Time: ${breakfastTime.format(context)}'),
                  trailing: Icon(Icons.access_time),
                  onTap: () => _selectTime(context, 'Breakfast'),
                ),
              ),
              FadeInUp(
                duration: Duration(milliseconds: 1200),
                child: ListTile(
                  title: Text('Lunch Time: ${lunchTime.format(context)}'),
                  trailing: Icon(Icons.access_time),
                  onTap: () => _selectTime(context, 'Lunch'),
                ),
              ),
              FadeInUp(
                duration: Duration(milliseconds: 1300),
                child: ListTile(
                  title: Text('Dinner Time: ${dinnerTime.format(context)}'),
                  trailing: Icon(Icons.access_time),
                  onTap: () => _selectTime(context, 'Dinner'),
                ),
              ),
              SizedBox(height: 20),
              FadeInUp(
                duration: Duration(milliseconds: 1400),
                child: Container(
                  width: double.infinity,
                  child: MaterialButton(
                    onPressed: _submit,
                    height: 60,
                    color: Colors.greenAccent,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: Text(
                      'Save Changes',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 18,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
