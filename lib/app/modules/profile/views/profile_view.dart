import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../controllers/profile_controller.dart';

class ProfileView extends GetView<ProfileController> {
  const ProfileView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'การเรียนรู้ของท่าน',
          style: TextStyle(
              color: Colors.white,
              fontSize: 25.0,
              fontWeight: FontWeight.bold,
              fontFamily: 'Kanit'),
        ),
        //set text to center
        centerTitle: true,
        // Replace with your text
        backgroundColor: Color(0xFF551E68), // Purple color

        actions: [
          IconButton(
            icon: Icon(
              Icons.menu,
              color: Colors.white,
            ),
            onPressed: () {
              // Handle menu action
            },
          ),
        ],
      ),
      body: Container(
        color: Color(0xFFEDE4FF),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Spacer(),
              Image.asset('images/not_login.png',
                  height: 200), // Replace with your asset
              Text(
                'ท่านยังไม่ได้เข้าสู่ระบบ', // Replace with your text
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 16),
              Text(
                'สร้างโปรไฟล์เพื่อบันทึกข้อมูลการเรียนรู้ของท่าน', // Replace with your text
                style: TextStyle(fontSize: 25),
                textAlign: TextAlign.center,
              ),
              Spacer(),
              Container(
                width: MediaQuery.of(context).size.width *
                    0.8, // 80% of screen width
                child: ElevatedButton.icon(
                  icon: Icon(
                    Icons.person_2_outlined,
                    color: Color(0xFF190482),
                  ), // Icon with purple color
                  label: Text('เข้าสู่ระบบ',
                      style: TextStyle(
                          color: Color(0xFF190482),
                          fontFamily: 'kanit')), // Text with purple color
                  onPressed: () {
                    // Handle login action
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Colors.white, // Background color is white
                    onPrimary: Color(0xFF190482), // Foreground color is purple
                    side: BorderSide(
                        color: Color(0xFF190482),
                        width: 2.0), // Border color is purple
                    elevation: 4.0, // Elevation for shadow
                    shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(25)), // Rounded corners
                    padding: EdgeInsets.symmetric(vertical: 12), // Add padding
                  ),
                ),
              ),
              SizedBox(height: 15), // Spacing between buttons
              Container(
                width: MediaQuery.of(context).size.width *
                    0.8, // 80% of screen width
                child: ElevatedButton.icon(
                  icon: Icon(
                    Icons.person_add_outlined,
                    color: Color(0xFF190482),
                  ), // Icon with purple color
                  label: Text('ลงทะเบียน',
                      style: TextStyle(
                          fontFamily: 'kanit',
                          color: Color(0xFF190482))), // Text with purple color
                  onPressed: () {
                    // Handle sign up action
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Colors.white, // Background color is white
                    onPrimary: Color(0xFF190482), // Foreground color is purple
                    side: BorderSide(
                        color: Color(0xFF190482),
                        width: 2.0), // Border color is purple
                    elevation: 4.0, // Elevation for shadow
                    shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(25)), // Rounded corners
                    padding: EdgeInsets.symmetric(vertical: 12), // Add padding
                  ),
                ),
              ),

              Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
