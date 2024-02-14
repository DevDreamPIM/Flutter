import 'package:flutter/material.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  bool _passwordVisible = false;
  bool _confirmpasswordVisible = false;

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
                      const SizedBox(height: 10),
                      // First Name text field
                      TextField(
                        decoration: InputDecoration(
                          hintText: 'First Name',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(50.0),
                          ),
                          filled: true,
                          fillColor: Colors.white.withOpacity(0.7),
                        ),
                      ),
                      const SizedBox(height: 20),
                      // Last Name text field
                      TextField(
                        decoration: InputDecoration(
                          hintText: 'Last Name',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(50.0),
                          ),
                          filled: true,
                          fillColor: Colors.white.withOpacity(0.7),
                        ),
                      ),
                      const SizedBox(height: 20),

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
                      const SizedBox(height: 20),

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
                      const SizedBox(height: 20),
                      // Password text field
                      TextField(
                        obscureText: !_confirmpasswordVisible,
                        decoration: InputDecoration(
                          hintText: 'Confirm Password',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(50.0),
                          ),
                          filled: true,
                          fillColor: Colors.white.withOpacity(0.7),
                          suffixIcon: IconButton(
                            icon: Icon(_confirmpasswordVisible
                                ? Icons.visibility
                                : Icons.visibility_off),
                            onPressed: () {
                              setState(() {
                                _confirmpasswordVisible = !_confirmpasswordVisible;
                              });
                            },
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      // Create Account button

                      Container(
                        width: double.infinity, // Extends to both sides
                        child: ElevatedButton(
                          onPressed: () {
                            // Add login functionality
                          },
                          style: ElevatedButton.styleFrom(
                            primary: const Color(
                                0xFF8A4FE9), // Set background color here
                          ),
                          child: const Padding(
                            padding: EdgeInsets.symmetric(
                                vertical:
                                    16.0), // Adjust button height as needed
                            child: Text('Create Account',
                                style: TextStyle(
                                    fontSize: 18.0, color: Colors.white)),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),

                      // Sign In text link
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            "Already have an account? ",
                            style:
                                TextStyle(fontSize: 13.0, color: Colors.black),
                          ),
                          TextButton(
                            onPressed: () {
                              // Add sign In functionality
                              Navigator.of(context).pop(context);
                            },
                            child: const Text('Sign In',
                                style: TextStyle(
                                  fontSize: 13.0,
                                  color: Color(0xFF8A4FE9),
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
