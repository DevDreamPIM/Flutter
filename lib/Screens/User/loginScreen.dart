import 'package:epilepto_guard/Screens/User/registerScreen.dart';
import 'package:epilepto_guard/Screens/User/verifEmailScreen.dart';
import 'package:flutter/material.dart';

import '../Calendar/CalendarScreen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _passwordVisible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false, // Prevent keyboard resizing issues
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Stack(
          fit: StackFit.expand,
          children: [
            // Background image
            Image.asset(
              'assets/images/background/login.png', // Replace 'background_image.jpg' with your actual image asset
              fit: BoxFit.cover,
            ),
            // Centered logo
            SingleChildScrollView(
              child: Center(
                child: Padding(
                  padding:
                      EdgeInsets.all(MediaQuery.of(context).size.width * 0.1),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/images/logo/epilepto_guard.png', // Replace 'logo.png' with your actual logo asset
                        width: MediaQuery.of(context).size.width * 0.6,
                        height: MediaQuery.of(context).size.width * 0.6,
                      ),
                      SizedBox(height: 10),
                      // Email text field
                      TextField(
                        decoration: InputDecoration(
                          hintText: 'Email',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(50.0),
                          ),
                          filled: true,
                          fillColor: Colors.white.withOpacity(0.7),
                        ),
                      ),
                      SizedBox(height: 20),
                      // Password text field
                      TextField(
                        obscureText: !_passwordVisible,
                        decoration: InputDecoration(
                          hintText: 'Password',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(50.0),
                          ),
                          filled: true,
                          fillColor: Colors.white.withOpacity(0.7),
                          suffixIcon: IconButton(
                            icon: Icon(_passwordVisible
                                ? Icons.visibility
                                : Icons.visibility_off),
                            onPressed: () {
                              setState(() {
                                _passwordVisible = !_passwordVisible;
                              });
                            },
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      // Login button

                      Container(
                        width: double.infinity, // Extends to both sides
                        child: ElevatedButton(
                          onPressed: () {
                            // Add login functionality
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => CalendarScreen()),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            primary: const Color(
                                0xFF8A4FE9), // Set background color here
                          ),
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                vertical:
                                    16.0), // Adjust button height as needed
                            child: Text('Log in',
                                style: TextStyle(
                                    fontSize: 18.0, color: Colors.white)),
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                      // Forgot password text link
                      TextButton(
                        onPressed: () {
                          // Add forgot password functionality
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => VerifEmailScreen()));
                        },
                        child: Text('Forgot password?',
                            style: TextStyle(
                              color: const Color(0xFF8A4FE9),
                            )),
                      ),
                      SizedBox(height: 10),
                      Text(
                        "-Or sign in with-",
                        style: TextStyle(fontSize: 12.0, color: Colors.black),
                      ),
                      SizedBox(height: 15),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // Google sign in button
                          InkWell(
                            onTap: () {
                              // Add Google sign in functionality
                            },
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical:
                                      16.0), // Adjust button height as needed
                              child: Image.asset(
                                  'assets/images/logo/Google.png',
                                  width: 30.0,
                                  height: 30.0),
                            ),
                          ),
                          SizedBox(width: 40),
                          // Facebook sign in button
                          InkWell(
                            onTap: () {
                              // Add Facebook sign in functionality
                            },
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical:
                                      16.0), // Adjust button height as needed
                              child: Image.asset(
                                  'assets/images/logo/Facebook.png',
                                  width: 30.0,
                                  height: 30.0),
                            ),
                          ),
                          SizedBox(width: 40),
                          // Apple sign in button
                          InkWell(
                            onTap: () {
                              // Add Apple sign in functionality
                            },
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical:
                                      16.0), // Adjust button height as needed
                              child: Image.asset('assets/images/logo/Apple.png',
                                  width: 30.0, height: 30.0),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      // Sign up text link
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Don't have an account? ",
                            style:
                                TextStyle(fontSize: 13.0, color: Colors.black),
                          ),
                          TextButton(
                            onPressed: () {
                              // Add sign up functionality
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => RegisterScreen()));
                            },
                            child: Text('Sign up',
                                style: TextStyle(
                                  fontSize: 13.0,
                                  color: const Color(0xFF8A4FE9),
                                )),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
