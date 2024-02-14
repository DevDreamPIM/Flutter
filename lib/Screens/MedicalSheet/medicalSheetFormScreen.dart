import 'package:flutter/material.dart';

class MedicalSheetFormScreen extends StatefulWidget {
  const MedicalSheetFormScreen({super.key});

  @override
  State<MedicalSheetFormScreen> createState() => _MedicalSheetFormScreenState();
}

class _MedicalSheetFormScreenState extends State<MedicalSheetFormScreen> {
  DateTime? selectedDate; // Define a variable to store the selected date

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Medical Sheet Form',
          style: TextStyle(color: Colors.white), // Set title color to white
        ),
        backgroundColor:
            const Color(0xFF8A4FE9), // Set background color to transparent
        elevation: 0, // Remove elevation shadow
        iconTheme:
            IconThemeData(color: Colors.white), // Set icon color to white
      ),
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
                       TextField(
                        decoration: InputDecoration(
                          hintText: 'Phone Number',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(50.0),
                          ),
                          filled: true,
                          fillColor: Colors.white.withOpacity(0.7),
                          
                        ),
                      ),
                      const SizedBox(height: 20),

                      // Email text field
                      TextFormField(
                        onTap: () async {
                          final DateTime? pickedDate = await showDatePicker(
                            context: context,
                            initialDate:
                                DateTime.now(), // Set the initial date to today
                            firstDate:
                                DateTime(1900), // Set the first selectable date
                            lastDate: DateTime
                                .now(), // Set the last selectable date (today)
                            builder: (BuildContext context, Widget? child) {
                              return Theme(
                                data: ThemeData.light().copyWith(
                                  // Customize the calendar theme
                                  primaryColor: const Color(
                                      0xFF8A4FE9), // Set primary color
                                  ///accentColor: const Color(0xFF8A4FE9), // Set accent color
                                  colorScheme: ColorScheme.light(
                                      primary: const Color(
                                          0xFF8A4FE9)), // Set color scheme
                                  buttonTheme: ButtonThemeData(
                                    textTheme: ButtonTextTheme
                                        .primary, // Set button text theme
                                  ),
                                ),
                                child: child!,
                              );
                            },
                          );

                          if (pickedDate != null &&
                              pickedDate != selectedDate) {
                            setState(() {
                              selectedDate =
                                  pickedDate; // Set the selected date to the picked date
                            });
                          }
                        },
                        decoration: InputDecoration(
                          hintText: 'Birth Date',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(50.0),
                          ),
                          filled: true,
                          fillColor: Colors.white.withOpacity(0.7),
                          suffixIcon: Icon(Icons
                              .calendar_today), // Add calendar icon as suffix
                        ),
                        readOnly: true, // Make the text field read-only
                        controller: TextEditingController(
                          text: selectedDate != null
                              ? '${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year}'
                              : '', // Set the text field value to the selected date
                        ),
                      ),
                      const SizedBox(height: 20),
                      TextField(
                        decoration: InputDecoration(
                          hintText: 'Weight',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(50.0),
                          ),
                          filled: true,
                          fillColor: Colors.white.withOpacity(0.7),
                          suffixText: 'kg',
                        ),
                      ),
                      // Password text field

                      const SizedBox(height: 20),
                       TextField(
                        decoration: InputDecoration(
                          hintText: 'Height',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(50.0),
                          ),
                          filled: true,
                          fillColor: Colors.white.withOpacity(0.7),
                          suffixText: 'cm',
                        ),
                      ),
                       const SizedBox(height: 20),
                      // Create Account button

                      Container(
                        width: double.infinity, // Extends to both sides
                        child: ElevatedButton(
                          onPressed: () {
                            // Add login functionality
                            Navigator.of(context).pop(context);
                          },
                          style: ElevatedButton.styleFrom(
                            primary: const Color(
                                0xFF8A4FE9), // Set background color here
                          ),
                          child: const Padding(
                            padding: EdgeInsets.symmetric(
                                vertical:
                                    16.0), // Adjust button height as needed
                            child: Text('Update Sheet',
                                style: TextStyle(
                                    fontSize: 18.0, color: Colors.white)),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),

                      // Sign In text link
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
