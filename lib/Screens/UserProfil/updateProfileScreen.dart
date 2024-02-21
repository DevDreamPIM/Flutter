import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:permission_handler/permission_handler.dart';

class UpdateProfileScreen extends StatefulWidget {
  const UpdateProfileScreen({Key? key}) : super(key: key);

  @override
  State<UpdateProfileScreen> createState() => _UpdateProfileScreenState();
}

class _UpdateProfileScreenState extends State<UpdateProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  List<String> emergencyContacts = [];

  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  File? imageFile; // Variable to hold the selected image file
  String? firstName;
  String? lastName;
  String? email;
  String? phoneNumber;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  void _loadUserData() async {
    final storage = FlutterSecureStorage();

    // Asynchronously load data
    String? loadedFirstName = await storage.read(key: "firstName");
    String? loadedLastName = await storage.read(key: "lastName");

    String? loadedPhoneNumber = await storage.read(key: "phoneNumber");

    // Use setState to update your UI and set the controller's text safely
    if (mounted) {
      setState(() {
        firstName = loadedFirstName;
        lastName = loadedLastName;

        phoneNumber = loadedPhoneNumber;

        // Safely assign the loaded values to the controllers
        _firstNameController.text = loadedFirstName ?? '';
        _lastNameController.text = loadedLastName ?? '';
        _phoneController.text = loadedPhoneNumber ?? '';
        // Assign other values similarly
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final double defaultSize = 16.0;
    final Color primaryColor = Color(0xFF8A4FE9);
    final String editProfile = 'Edit Profile'; // Placeholder text

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
            padding: EdgeInsets.all(defaultSize),
            child: Column(
              children: [
                Stack(
                  children: [
                    SizedBox(
                      width: 120,
                      height: 120,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: imageFile == null
                            ? Image.asset(
                                'assets/images/user/youssef.jpg', // Default image if no image is selected
                                fit: BoxFit.cover,
                              )
                            : Image.file(
                                imageFile!, // Display the selected/cropped image
                                fit: BoxFit.cover,
                              ),
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: GestureDetector(
                        onTap: () => showImagePicker(context),
                        child: Container(
                          width: 35,
                          height: 35,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(18),
                            color: primaryColor,
                          ),
                          child: const Icon(
                            LineAwesomeIcons.camera,
                            color: Colors.white,
                            size: 20,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        const SizedBox(height: 20),
                        TextFormField(
                          controller: _firstNameController,
                          decoration: InputDecoration(
                            labelText: "First Name",
                            prefixIcon: Icon(LineAwesomeIcons.user),
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20)),
                            ),
                            hoverColor: Color(0xFF8A4FE9),
                            iconColor: Color(0xFF8A4FE9),
                            prefixIconColor: Color(0xFF8A4FE9),
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
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'This input is required';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 20),
                        TextFormField(
                          controller: _lastNameController,
                          decoration: InputDecoration(
                            label: Text(
                              "Last Name",
                              selectionColor: Color(0xFF8A4FE9),
                            ),

                            hoverColor: Color(0xFF8A4FE9),
                            iconColor: Color(0xFF8A4FE9),
                            prefixIconColor: Color(0xFF8A4FE9),

                            prefixIcon: Icon(LineAwesomeIcons.user_check),
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
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'This input is required';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 20),
                        TextFormField(
                          controller: _phoneController,
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
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'This input is required';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 20),
                        ...List.generate(emergencyContacts.length, (index) {
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 20),
                            child: Row(
                              children: [
                                const SizedBox(height: 20),
                                Expanded(
                                  child: TextFormField(
                                    initialValue: emergencyContacts[index],
                                    onChanged: (value) => setState(() {
                                      emergencyContacts[index] = value;
                                    }),
                                    decoration: InputDecoration(
                                      labelText:
                                          "Emergency Contact ${index + 1}",
                                      hoverColor: Color(0xFF8A4FE9),
                                      iconColor: Color(0xFF8A4FE9),
                                      prefixIconColor: Color(0xFF8A4FE9),
                                      prefixIcon: Icon(
                                          LineAwesomeIcons.alternate_phone),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(20)),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(20)),
                                        borderSide:
                                            BorderSide(color: primaryColor),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(20)),
                                        borderSide:
                                            BorderSide(color: primaryColor),
                                      ),
                                    ),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'This input is required';
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                                IconButton(
                                  icon: Icon(Icons.remove_circle_outline,
                                      color: Colors.red),
                                  onPressed: () =>
                                      _removeEmergencyContact(index),
                                ),
                              ],
                            ),
                          );
                        }),
                        ElevatedButton(
                          onPressed: _addEmergencyContact,
                          child: Text('Add Emergency Contact'),
                        ),
                        const SizedBox(height: 20),
                        Container(
                          width: double.infinity, // Extends to both sides
                          child: ElevatedButton(
                            onPressed: _submitForm,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Color(
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
              ],
            ),
          ),
        ],
      ),
    );
  }

  final picker = ImagePicker();
  void showImagePicker(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (builder) {
          return Card(
            child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height / 5.2,
                margin: const EdgeInsets.only(top: 8.0),
                padding: const EdgeInsets.all(12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                        child: InkWell(
                      child: Column(
                        children: const [
                          Icon(
                            Icons.image,
                            size: 60.0,
                          ),
                          SizedBox(height: 12.0),
                          Text(
                            "Gallery",
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 16, color: Colors.black),
                          )
                        ],
                      ),
                      onTap: () {
                        _imgFromGallery();
                        Navigator.pop(context);
                      },
                    )),
                    Expanded(
                        child: InkWell(
                      child: SizedBox(
                        child: Column(
                          children: const [
                            Icon(
                              Icons.camera_alt,
                              size: 60.0,
                            ),
                            SizedBox(height: 12.0),
                            Text(
                              "Camera",
                              textAlign: TextAlign.center,
                              style:
                                  TextStyle(fontSize: 16, color: Colors.black),
                            )
                          ],
                        ),
                      ),
                      onTap: () {
                        _imgFromCamera();
                        Navigator.pop(context);
                      },
                    ))
                  ],
                )),
          );
        });
  }

  void _addEmergencyContact() {
    setState(() {
      emergencyContacts
          .add(''); // Add an empty string to represent a new contact
    });
  }

  void _removeEmergencyContact(int index) {
    setState(() {
      emergencyContacts
          .removeAt(index); // Remove the contact at the given index
    });
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Row(
            children: [
              Icon(Icons.error, color: Colors.white),
              SizedBox(width: 2),
              Text('Profile Updated with succes!',
                  style: TextStyle(color: Colors.white)),
            ],
          ),
          backgroundColor: Colors.green,
        ),
      );
    } else {}
  }

  _imgFromGallery() async {
    await picker
        .pickImage(source: ImageSource.gallery, imageQuality: 50)
        .then((value) {
      if (value != null) {
        _cropImage(File(value.path));
      }
    });
  }

  _imgFromCamera() async {
    await picker
        .pickImage(source: ImageSource.camera, imageQuality: 50)
        .then((value) {
      if (value != null) {
        _cropImage(File(value.path));
      }
    });
  }

  _cropImage(File imgFile) async {
    final croppedFile = await ImageCropper().cropImage(
        sourcePath: imgFile.path,
        aspectRatioPresets: Platform.isAndroid
            ? [
                CropAspectRatioPreset.square,
                CropAspectRatioPreset.ratio3x2,
                CropAspectRatioPreset.original,
                CropAspectRatioPreset.ratio4x3,
                CropAspectRatioPreset.ratio16x9
              ]
            : [
                CropAspectRatioPreset.original,
                CropAspectRatioPreset.square,
                CropAspectRatioPreset.ratio3x2,
                CropAspectRatioPreset.ratio4x3,
                CropAspectRatioPreset.ratio5x3,
                CropAspectRatioPreset.ratio5x4,
                CropAspectRatioPreset.ratio7x5,
                CropAspectRatioPreset.ratio16x9
              ],
        uiSettings: [
          AndroidUiSettings(
              toolbarTitle: "Image Cropper",
              toolbarColor: Colors.deepOrange,
              toolbarWidgetColor: Colors.white,
              initAspectRatio: CropAspectRatioPreset.original,
              lockAspectRatio: false),
          IOSUiSettings(
            title: "Image Cropper",
          )
        ]);
    if (croppedFile != null) {
      imageCache.clear();
      setState(() {
        imageFile = File(croppedFile.path);
      });
      // reload();
    }
  }
}
