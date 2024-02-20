import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

import '../Screens/Calendar/CalendarScreen.dart';
import '../Screens/HomeScreen.dart';
import '../Screens/PreSeizure/detectedSigns.dart';
import '../Screens/PreSeizure/healthData.dart';
import '../Screens/PreSeizure/seizureStatistics.dart';
import '../Screens/UserProfil/profileScreen.dart';

class Drawers extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onItemTapped;

  const Drawers({
    super.key,
    required this.selectedIndex,
    required this.onItemTapped,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Colors.white,
                Color(0xFFA99ADC)], // 0xFFF4C2C2
            ),
          ),
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          ListTile(
            leading: Icon(Icons.home,
                color: selectedIndex == 0 ? Color(0xFFFF326A) : Color(0xFFC987E1)),
            title: Text(
              'Home',
              style: TextStyle(
                color: selectedIndex == 0 ? Color(0xFFFF326A)
                    : Colors.black87,
              ),
            ),
            onTap: () {
              onItemTapped(0);
              Navigator.pop(context);
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const HomeScreen()));
            },
            selected: selectedIndex == 0,
            selectedTileColor: Color(0xFFC987E1),
          ),
          ListTile(
            leading: Icon(Icons.calendar_month,
                color: selectedIndex == 1 ? Color(0xFFFF326A) : Color(0xFFC987E1)),
            title: Text(
              'Calendar',
              style: TextStyle(
                color: selectedIndex == 1 ? Color(0xFFFF326A) : Colors.black87,
              ),
            ),
            onTap: () {
              onItemTapped(1);
              Navigator.pop(context);
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => CalendarScreen()));
            },
            selected: selectedIndex == 1,
            selectedTileColor: Color(0xFFC987E1),
          ),
          ListTile(
            leading: Icon(Icons.auto_graph,
                color: selectedIndex == 2 ? Color(0xFFFF326A) : Color(0xFFC987E1)),
            title: Text(
              'Detected Signs Visualization',
              style: TextStyle(
                color: selectedIndex == 2 ? Color(0xFFFF326A) : Colors.black87,
              ),
            ),
            onTap: () {
              onItemTapped(2);
              Navigator.pop(context);
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => DetectedSigns()));
            },
            selected: selectedIndex == 2,
            selectedTileColor: Color(0xFFC987E1),
          ),
          ListTile(
            leading: Icon(Icons.health_and_safety,
                color: selectedIndex == 3 ? Color(0xFFFF326A) : Color(0xFFC987E1)),
            title: Text(
              'Health Data',
              style: TextStyle(
                color: selectedIndex == 3 ? Color(0xFFFF326A) : Colors.black87,
              ),
            ),
            onTap: () {
              onItemTapped(3);
              Navigator.pop(context);
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => HealthData()));
            },
            selected: selectedIndex == 3,
            selectedTileColor: Color(0xFFC987E1),
          ),
          ListTile(
            leading: Icon(Icons.bar_chart_sharp,
                color: selectedIndex == 4 ? Color(0xFFFF326A) : Color(0xFFC987E1)),
            title: Text(
              'Seizures Statistics',
              style: TextStyle(
                color: selectedIndex == 4 ? Color(0xFFFF326A) : Colors.black87,
              ),
            ),
            onTap: () {
              onItemTapped(4);
              Navigator.pop(context);
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => SeizureStatistics()));
            },
            selected: selectedIndex == 4,
            selectedTileColor: Color(0xFFC987E1),
          ),
          ListTile(
            leading: Icon(LineAwesomeIcons.user,
                color: selectedIndex == 5 ? Color(0xFFFF326A) : Color(0xFFC987E1)),
            title: Text(
              'Profile',
              style: TextStyle(
                color: selectedIndex == 5 ? Color(0xFFFF326A) : Colors.black87,
              ),
            ),
            onTap: () {
              onItemTapped(5);
              Navigator.pop(context);
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => ProfileScreen()));
            },
            selected: selectedIndex == 5,
            selectedTileColor: Color(0xFFC987E1),
          ),

        ],
      )),
    );
  }
}
