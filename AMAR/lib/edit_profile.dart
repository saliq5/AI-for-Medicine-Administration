import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';

class EditProfileApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: EditProfileScreen(),
    );
  }
}

class EditProfileScreen extends StatefulWidget {
  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  // Profile fields
  String firstName = '';
  String lastName = '';
  String age = '';
  String address = '';
  String mobileNumber = '';
  String gender = 'Male'; // Default gender selection

  // Meal times
  TimeOfDay breakfastTime = TimeOfDay.now();
  TimeOfDay lunchTime = TimeOfDay.now();
  TimeOfDay dinnerTime = TimeOfDay.now();

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

  void _submit() {
    // Handle the submission of the profile data
    print('Profile Saved:');
    print('First Name: $firstName');
    print('Last Name: $lastName');
    print('Age: $age');
    print('Address: $address');
    print('Mobile Number: $mobileNumber');
    print('Gender: $gender');
    print('Breakfast: ${breakfastTime.format(context)}');
    print('Lunch: ${lunchTime.format(context)}');
    print('Dinner: ${dinnerTime.format(context)}');
    // Implement saving logic here
  }

  Widget makeInput(
      {required String label,
      TextInputType keyboardType = TextInputType.text,
      Function(String)? onChanged}) {
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
          onChanged: onChanged,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey.shade400)),
            border: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey.shade400)),
          ),
        ),
        SizedBox(height: 30),
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
              // Set the background color to match the input fields
              dropdownColor: Colors.white,
            ),
          ),
        ),
        SizedBox(height: 30),
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
          icon: Icon(Icons.arrow_back_ios, size: 20, color: Colors.black),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            children: <Widget>[
              FadeInUp(
                duration: Duration(milliseconds: 1000),
                child: Text(
                  "Edit Profile",
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(height: 20),
              FadeInUp(
                duration: Duration(milliseconds: 1200),
                child: Text(
                  "Update your information",
                  style: TextStyle(fontSize: 15, color: Colors.grey[700]),
                ),
              ),
              SizedBox(height: 20),
              FadeInUp(
                duration: Duration(milliseconds: 1300),
                child: makeInput(
                  label: "First Name",
                  onChanged: (value) => firstName = value,
                ),
              ),
              FadeInUp(
                duration: Duration(milliseconds: 1400),
                child: makeInput(
                  label: "Last Name",
                  onChanged: (value) => lastName = value,
                ),
              ),
              FadeInUp(
                duration: Duration(milliseconds: 1500),
                child: makeInput(
                  label: "Age",
                  keyboardType: TextInputType.number,
                  onChanged: (value) => age = value,
                ),
              ),
              FadeInUp(
                duration: Duration(milliseconds: 1600),
                child: makeGenderDropdown(), // Gender Dropdown right after Age
              ),
              FadeInUp(
                duration: Duration(milliseconds: 1700),
                child: makeInput(
                  label: "Address",
                  onChanged: (value) => address = value,
                ),
              ),
              FadeInUp(
                duration: Duration(milliseconds: 1800),
                child: makeInput(
                  label: "Mobile Number",
                  keyboardType: TextInputType.phone,
                  onChanged: (value) => mobileNumber = value,
                ),
              ),
              SizedBox(height: 20),
              FadeInUp(
                duration: Duration(milliseconds: 1900),
                child: ListTile(
                  title:
                      Text('Breakfast Time: ${breakfastTime.format(context)}'),
                  trailing: Icon(Icons.access_time),
                  onTap: () => _selectTime(context, 'Breakfast'),
                ),
              ),
              FadeInUp(
                duration: Duration(milliseconds: 2000),
                child: ListTile(
                  title: Text('Lunch Time: ${lunchTime.format(context)}'),
                  trailing: Icon(Icons.access_time),
                  onTap: () => _selectTime(context, 'Lunch'),
                ),
              ),
              FadeInUp(
                duration: Duration(milliseconds: 2100),
                child: ListTile(
                  title: Text('Dinner Time: ${dinnerTime.format(context)}'),
                  trailing: Icon(Icons.access_time),
                  onTap: () => _selectTime(context, 'Dinner'),
                ),
              ),
              SizedBox(height: 20),
              FadeInUp(
                duration: Duration(milliseconds: 2200),
                child: Container(
                  width: double.infinity,
                  child: MaterialButton(
                    onPressed: _submit,
                    height: 60,
                    color: Colors.greenAccent, // Button color
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: Text(
                      'Save Changes',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 18,
                        color: Colors
                            .white, // Optional: to ensure the text stands out
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
