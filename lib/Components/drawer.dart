import 'package:epilepto_guard/Utils/Constantes.dart';
import 'package:epilepto_guard/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

import '../Screens/Calendar/CalendarScreen.dart';
import '../Screens/HomeScreen.dart';
import '../Screens/PreSeizure/detectedSigns.dart';
import '../Screens/PreSeizure/healthData.dart';
import '../Screens/PreSeizure/seizureStatistics.dart';
import '../Screens/UserProfil/profileScreen.dart';

class Drawers extends StatefulWidget {
  final int selectedIndex;
  final Function(int) onItemTapped;

  const Drawers({
    super.key,
    required this.selectedIndex,
    required this.onItemTapped,
  });

  @override
  State<Drawers> createState() => _DrawersState();
}

class _DrawersState extends State<Drawers> {
    String? fullName;
  String? image;
  String? email;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

   Future<void> _loadUserData() async {
    final storage = FlutterSecureStorage();

    String? loadedFirstName = await storage.read(key: "firstName");
    String? loadedLastName = await storage.read(key: "lastName");
    String? loadedEmail = await storage.read(key: "email");
    String? loadedImage = await storage.read(key: "image");

    // Ensure there's a space between first name and last name only if both are not null
    String? loadedFullName = [loadedFirstName, loadedLastName]
        .where((s) => s != null && s.isNotEmpty)
        .join(" ");

    if (mounted) {
      setState(() {
        fullName = loadedFullName.isNotEmpty ? loadedFullName : "Your Name";
        image = loadedImage ?? '';
        email = loadedEmail ?? '';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
          decoration: BoxDecoration(
            color: Color(0xFFA99ADC),
            /*gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Colors.white,
                Color(0xFFA99ADC)], // 0xFFF4C2C2
            ),*/
          ),
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            accountName: Text(fullName ?? "Your Name"), 
            accountEmail: Text(email ?? "Your Email"),
            currentAccountPicture: CircleAvatar(
                backgroundImage: NetworkImage(
                    '${Constantes.USER_IMAGE_URL}/$image'),
              ),
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(
                    "https://appmaking.co/wp-content/uploads/2021/08/android-drawer-bg.jpeg",
                  ),
                  fit: BoxFit.fill,
                ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.home,
                color: widget.selectedIndex == 0 ? Colors.white : AppColors.purple),
            title: Text(
              'Home',
              style: TextStyle(
                color: widget.selectedIndex == 0 ? Colors.white : AppColors.purple,
              ),
            ),
            onTap: () {
              widget.onItemTapped(0);
              Navigator.pop(context);
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const HomeScreen()));
            },
            selected: widget.selectedIndex == 0,
            selectedTileColor: Color(0xFFC987E1),
          ),
          ListTile(
            leading: Icon(Icons.calendar_month,
                color: widget.selectedIndex == 1 ? Colors.white : AppColors.purple),
            title: Text(
              'Calendar',
              style: TextStyle(
                color: widget.selectedIndex == 1 ? Colors.white : AppColors.purple,
              ),
            ),
            onTap: () {
              widget.onItemTapped(1);
              Navigator.pop(context);
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => CalendarScreen()));
            },
            selected: widget.selectedIndex == 1,
            selectedTileColor: Color(0xFFC987E1),
          ),
          ListTile(
            leading: Icon(Icons.auto_graph,
                color: widget.selectedIndex == 2 ? Colors.white : AppColors.purple),
            title: Text(
              'Detected Signs Visualization',
              style: TextStyle(
                color: widget.selectedIndex == 2 ? Colors.white : AppColors.purple,
              ),
            ),
            onTap: () {
              widget.onItemTapped(2);
              Navigator.pop(context);
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => DetectedSigns()));
            },
            selected: widget.selectedIndex == 2,
            selectedTileColor: Color(0xFFC987E1),
          ),
          ListTile(
            leading: Icon(Icons.health_and_safety,
                color: widget.selectedIndex == 3 ? Colors.white : AppColors.purple),
            title: Text(
              'Health Data',
              style: TextStyle(
                color: widget.selectedIndex == 3 ? Colors.white : AppColors.purple,
              ),
            ),
            onTap: () {
              widget.onItemTapped(3);
              Navigator.pop(context);
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => HealthData()));
            },
            selected: widget.selectedIndex == 3,
            selectedTileColor: Color(0xFFC987E1),
          ),
          ListTile(
            leading: Icon(Icons.bar_chart_sharp,
                color: widget.selectedIndex == 4 ? Colors.white : AppColors.purple),
            title: Text(
              'Seizures Statistics',
              style: TextStyle(
                color: widget.selectedIndex == 4 ? Colors.white : AppColors.purple,
              ),
            ),
            onTap: () {
              widget.onItemTapped(4);
              Navigator.pop(context);
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => SeizureStatistics()));
            },
            selected: widget.selectedIndex == 4,
            selectedTileColor: Color(0xFFC987E1),
          ),
          ListTile(
            leading: Icon(LineAwesomeIcons.user,
                color: widget.selectedIndex == 5 ? Colors.white : AppColors.purple),
            title: Text(
              'Profile',
              style: TextStyle(
                color: widget.selectedIndex == 5 ? Colors.white : AppColors.purple,
              ),
            ),
            onTap: () {
              widget.onItemTapped(5);
              Navigator.pop(context);
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => ProfileScreen()));
            },
            selected: widget.selectedIndex == 5,
            selectedTileColor: Color(0xFFC987E1),
          ),

        ],
      )),
    );
  }
}
