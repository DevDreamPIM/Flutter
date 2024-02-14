import 'package:epilepto_guard/Screens/PreSeizure/detectedSigns.dart';
import 'package:epilepto_guard/Screens/PreSeizure/healthData.dart';
import 'package:epilepto_guard/Screens/PreSeizure/seizureStatistics.dart';
import 'package:epilepto_guard/Screens/UserProfil/profileScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

import 'Calendar/CalendarScreen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: Center(
        child: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/background/background.png'),
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text('Home'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.calendar_month),
              title: const Text('Calendar'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => CalendarScreen()),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.auto_graph),
              title: const Text('Detected Signs Visualization'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => DetectedSigns()),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.health_and_safety),
              title: const Text('Health Data'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => HealthData()),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.bar_chart_sharp),
              title: const Text('Seizure Statistics'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => SeizureStatistics()),
                );
              },
            ),
            ListTile(
              leading: const Icon(LineAwesomeIcons.user),
              title: const Text('Profile'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ProfileScreen()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}