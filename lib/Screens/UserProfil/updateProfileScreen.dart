import 'package:flutter/material.dart'; // Ensure you have GetX package if you're using Get.back()
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

class UpdateProfileScreen extends StatelessWidget {
  const UpdateProfileScreen({Key? key})
      : super(key: key); // Fixed super.key to Key? key
  @override
  Widget build(BuildContext context) {
    // Removed const from variables that are not compile-time constants
    final double defaultSize = 16.0;
    final String profileImage = 'assets/images/user/youssef.jpg';
    final Color primaryColor = Color(0xFF8A4FE9);
    final String editProfile = 'Edit Profile';

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(LineAwesomeIcons.angle_left),
        ),
        title: Text(editProfile, style: Theme.of(context).textTheme.headline4),
        backgroundColor:
            Colors.transparent, // Make AppBar background transparent
        elevation: 0,
      ),
      body: Stack(
        children: [
          // Background image
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                    "assets/images/background/login.png"), // Specify your background image path
                fit: BoxFit.cover,
              ),
            ),
          ),
          // Main content
          SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.all(defaultSize),
              child: Column(
                children: [
                  SingleChildScrollView(
                    // Moved SingleChildScrollView to the body property
                    child: Container(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          Stack(
                            children: [
                              SizedBox(
                                width: 120,
                                height: 120,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(100),
                                  child: const Image(
                                    image: AssetImage(
                                        'assets/images/user/youssef.jpg'), // Corrected variable usage
                                  ), // Removed extra comments
                                ),
                              ),
                              Positioned(
                                bottom: 0,
                                right: 0,
                                child: Container(
                                  width: 35,
                                  height: 35,
                                  decoration: BoxDecoration(
                                    // Corrected typo BuxDecoration to BoxDecoration
                                    borderRadius: BorderRadius.circular(
                                        18), // Adjusted borderRadius value
                                    color:
                                        primaryColor, // Corrected color usage
                                  ),
                                  child: const Icon(
                                    LineAwesomeIcons
                                        .camera, // Corrected icon name and removed typos
                                    color: Colors.white,
                                    size: 20,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 50),
                          Form(
                              child: Column(
                            children: [
                              const SizedBox(height: 20),
                              TextField(
                                decoration: InputDecoration(
                                  label: Text(
                                    "Full Name",
                                    selectionColor: Color(0xFF8A4FE9),
                                  ),
                                  hoverColor: Color(0xFF8A4FE9),
                                  iconColor: Color(0xFF8A4FE9),
                                  prefixIconColor: Color(0xFF8A4FE9),

                                  prefixIcon: Icon(LineAwesomeIcons.user),
                                  border: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20)),
                                  ),
                                  // Use Theme.of(context) to access the primary color
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20)),
                                    borderSide: BorderSide(color: primaryColor),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20)),
                                    borderSide: BorderSide(color: primaryColor),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 20),
                              TextField(
                                decoration: InputDecoration(
                                  label: Text(
                                    "Email",
                                    selectionColor: Color(0xFF8A4FE9),
                                  ),
                                  hoverColor: Color(0xFF8A4FE9),
                                  iconColor: Color(0xFF8A4FE9),
                                  prefixIconColor: Color(0xFF8A4FE9),

                                  prefixIcon: Icon(LineAwesomeIcons.envelope),
                                  border: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20)),
                                  ),
                                  // Use Theme.of(context) to access the primary color
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20)),
                                    borderSide: BorderSide(color: primaryColor),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20)),
                                    borderSide: BorderSide(color: primaryColor),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 20),
                              TextField(
                                decoration: InputDecoration(
                                  label: Text(
                                    "Phone",
                                    selectionColor: Color(0xFF8A4FE9),
                                  ),
                                  hoverColor: Color(0xFF8A4FE9),
                                  iconColor: Color(0xFF8A4FE9),
                                  prefixIconColor: Color(0xFF8A4FE9),

                                  prefixIcon: Icon(LineAwesomeIcons.phone),
                                  border: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20)),
                                  ),
                                  // Use Theme.of(context) to access the primary color
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20)),
                                    borderSide: BorderSide(color: primaryColor),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20)),
                                    borderSide: BorderSide(color: primaryColor),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 20),
                              TextField(
                                decoration: InputDecoration(
                                  label: Text(
                                    "Password",
                                    selectionColor: Color(0xFF8A4FE9),
                                  ),
                                  hoverColor: Color(0xFF8A4FE9),
                                  iconColor: Color(0xFF8A4FE9),
                                  prefixIconColor: Color(0xFF8A4FE9),

                                  prefixIcon:
                                      Icon(LineAwesomeIcons.fingerprint),
                                  border: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20)),
                                  ),
                                  // Use Theme.of(context) to access the primary color
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20)),
                                    borderSide: BorderSide(color: primaryColor),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20)),
                                    borderSide: BorderSide(color: primaryColor),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 20),
                              Container(
                                width: double.infinity, // Extends to both sides
                                child: ElevatedButton(
                                  onPressed: () {},
                                  style: ElevatedButton.styleFrom(
                                    primary: Color(
                                        0xFF8A4FE9), // Set background color here
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(
                                        vertical:
                                            16.0), // Adjust button height as needed
                                    child: const Text(
                                      'Submit',
                                      style: TextStyle(
                                          fontSize: 18.0, color: Colors.white),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ))

                          // Add your other widgets here
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
