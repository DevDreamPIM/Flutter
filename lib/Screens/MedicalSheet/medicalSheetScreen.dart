import 'package:epilepto_guard/Screens/MedicalSheet/medicalSheetFormScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class MedicalSheetScreen extends StatefulWidget {
  const MedicalSheetScreen({super.key});

  @override
  State<MedicalSheetScreen> createState() => _MedicalSheetScreenState();
}

class _MedicalSheetScreenState extends State<MedicalSheetScreen> {

String? firstName;
String? lastName;
String? birthDate;
String? phoneNumber;
String? weight;
String? height;

@override
void initState() {
  super.initState();
  _loadUserData();
}

  _loadUserData() async {
  final storage = FlutterSecureStorage();
  
  // Use await to wait for the completion of each read operation
  firstName = await storage.read(key: "firstName");
  lastName = await storage.read(key: "lastName");
 // birthDate = await storage.read(key: "birthDate");
  phoneNumber = await storage.read(key: "phoneNumber");
 // weight = await storage.read(key: "weight");
 // height = await storage.read(key: "height");

  // Set state to reflect the changes
  setState(() {});
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Medical Sheet',
          style: TextStyle(color: Colors.white), // Set title color to white
        ),
        backgroundColor:
            const Color(0xFF8A4FE9), // Set background color to transparent
        elevation: 0, // Remove elevation shadow
        iconTheme:
            IconThemeData(color: Colors.white), // Set icon color to white
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Stack(
          fit: StackFit.expand,
          children: [
            // Background image
            Image.asset(
              'assets/images/background/send_code.png', // Replace 'background_image.jpg' with your actual image asset
              fit: BoxFit.cover,
            ),
            SingleChildScrollView(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildInfoRow('First Name', firstName ?? ''),
                  _buildInfoRow('Last Name', lastName ?? ''),
                  _buildInfoRow('Birth Date','2000-03-14'),
                  _buildInfoRow('Phone Number', phoneNumber ?? ''),
                  _buildInfoRow('Weight', '50 kg'),
                  _buildInfoRow('Height', '157 cm'),
                  Padding(
                    padding: EdgeInsets.all(16.0),
                    child: ElevatedButton.icon(
                      onPressed: () {
                        // Add your export functionality here
                      },
                      icon: Icon(
                        Icons.file_download,
                        color: Colors.white,
                      ), // Icon for export
                      label: Text(
                        'Export Sheet',
                        style: TextStyle(color: Colors.white),
                      ), // Text for the button
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          // Set button shape to circular
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        backgroundColor:
                            const Color(0xFF8A4FE9), // Background color
                        disabledBackgroundColor:
                            Colors.white, // Foreground color
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: Theme(
        data: ThemeData(
          floatingActionButtonTheme: FloatingActionButtonThemeData(
            backgroundColor: const Color(0xFF8A4FE9), // Background color
            foregroundColor: Colors.white, // Icon color
            shape: RoundedRectangleBorder(
              // Make button circular
              borderRadius: BorderRadius.circular(30.0),
            ),
          ),
        ),
        child: FloatingActionButton(
          onPressed: () {
            // Add your edit functionality here
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => MedicalSheetFormScreen()));
          },
          child: Icon(Icons.edit),
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            color: const Color(0xFF8A4FE9),
          ),
        ),
        SizedBox(height: 8.0),
        Text(
          value,
          style: TextStyle(fontSize: 16.0),
        ),
        SizedBox(height: 16.0),
      ],
    );
  }
}
