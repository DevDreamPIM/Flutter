import 'package:epilepto_guard/Screens/Calendar/CalendarScreen.dart';
import 'package:epilepto_guard/Screens/Crise/historiqueCrise.dart';
import 'package:epilepto_guard/Screens/Drugs/ListDrug.dart';
import 'package:epilepto_guard/Screens/MedicalSheet/medicalSheetScreen.dart';
import 'package:epilepto_guard/Screens/User/loginScreen.dart';
import 'package:epilepto_guard/Screens/UserProfil/updateProfileScreen.dart';
import 'package:epilepto_guard/colors.dart';
import 'package:epilepto_guard/Screens/settings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

const double DefaultSize = 16.0; // Placeholder for your DefaultSize value
const String ProfileImage =
    'assets/images/user/youssef.jpg'; // Placeholder image path
const String ProfileHeading = 'Youssef Farhat'; // Placeholder text
const String ProfileSubHeading = 'Youssef.farhat@esprit.tn'; // Placeholder text
const String EditProfile = 'Edit Profile'; // Placeholder button text

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor:
        Colors.transparent, // Make AppBar background transparent
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(LineAwesomeIcons.angle_left),
        ),
        title: Text(
          'Profile',
          style: Theme.of(context).textTheme.headline4?.copyWith(
              color: Colors
                  .white), // Adjust text color for visibility on background
        ),
      ),
      body: Stack(
        children: [
          // Background image
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                    "assets/images/background/login.png"), // Specify the path to your background image
                fit: BoxFit.cover,
              ),
            ),
          ),
          // Your existing content in a SingleChildScrollView
          SingleChildScrollView(
            child: Container(
              padding:
              const EdgeInsets.all(16.0), // Adjust padding if necessary
              child: Column(
                children: [
                  // Your existing widgetSingleChildScrollView(
                  Container(
                    padding: const EdgeInsets.all(DefaultSize),
                    child: Column(
                      children: [
                        SizedBox(
                          width: 120,
                          height: 120,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(100),
                            child: Image.asset(ProfileImage),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          ProfileHeading,
                          style: Theme.of(context).textTheme.headline4,
                        ),
                        Text(
                          ProfileSubHeading,
                          style: Theme.of(context).textTheme.bodyText2,
                        ),
                        const SizedBox(height: 20),
                        SizedBox(
                          width: 200,
                          height: 50,
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => UpdateProfileScreen()));
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                              Color(0xFF8A4FE9), // Background color
                            ),
                            child: const Text(
                              'Edit Profile', // Make sure to replace 'Edit Profile' with a variable if it's dynamic
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),

                        const SizedBox(
                          height: 30,
                        ),
                        const Divider(),
                        const SizedBox(
                          height: 10,
                        ),
                        // MENU
                        ProfileMenuWidget(
                            title: "Settings",
                            icon: LineAwesomeIcons.cog,
                            onPress: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => Settings()));
                            }),
                        ProfileMenuWidget(
                            title: "Calendar",
                            icon: LineAwesomeIcons.calendar,
                            onPress: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => CalendarScreen()));
                            }),
                        const Divider(color: Colors.grey),
                        const SizedBox(height: 10),
                        ProfileMenuWidget(
                            title: "Medical File",
                            icon: LineAwesomeIcons.medical_notes,
                            onPress: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => MedicalSheetScreen()));
                            }),
                        ProfileMenuWidget(
                            title: "Crisis History",
                            icon: LineAwesomeIcons.history,
                            onPress: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => CrisisHistoryScreen()));
                            }),
                        ProfileMenuWidget(
                            title: "Drugs",
                            icon: LineAwesomeIcons.history,
                            onPress: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => ListDrug()));
                            }),
                        ProfileMenuWidget(
                          title: "Logout",
                          icon: LineAwesomeIcons.alternate_sign_out,
                          textColor: Colors.red,
                          endIcon: false,
                          onPress: () async {
                            const storage = FlutterSecureStorage();
                            await storage.delete(key: "token").then((value) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const LoginScreen()),
                              );
                            });
                          },
                        ),
                      ],
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

class ProfileMenuWidget extends StatelessWidget {
  const ProfileMenuWidget({
    Key? key,
    required this.title,
    required this.icon,
    required this.onPress,
    this.endIcon = true,
    this.textColor,
  }) : super(key: key);
  final String title;
  final IconData icon;
  final VoidCallback onPress;
  final bool endIcon;
  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onPress,
      leading: Container(
        width: 30,
        height: 30,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          color: Color(0xFFC2A3F7),
        ),
        child: Icon(
          icon,
          color: Color(0xFF8A4FE9),
        ),
      ),
      title: Text(title,
          style:
          Theme.of(context).textTheme.bodyText1?.apply(color: textColor)),
      trailing: endIcon
          ? Container(
        width: 30,
        height: 30,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          color: AppColors.lightPurple,
        ),
        child: const Icon(
          LineAwesomeIcons.angle_right,
          size: 18.0,
          color: Color(0xFF8A4FE9),
        ),
      )
          : null,
    );
  }
}
