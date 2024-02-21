import 'package:epilepto_guard/Components/drawer.dart';
import 'package:epilepto_guard/Screens/Bluetooth/MainPageBluetooth.dart';
import 'package:epilepto_guard/Screens/Crise/formulaireQuotidien.dart';
import 'package:flutter/material.dart';
import 'package:epilepto_guard/Screens/PreSeizure/detectedSigns.dart';
import 'package:epilepto_guard/Screens/PreSeizure/healthData.dart';
import 'package:epilepto_guard/Screens/PreSeizure/seizureStatistics.dart';
import 'package:epilepto_guard/Screens/UserProfil/profileScreen.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'Calendar/CalendarScreen.dart';
import 'package:weather_icons/weather_icons.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();

}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  Icon getWeatherIcon(String weatherCondition) {
    switch (weatherCondition.toLowerCase()) {
      case 'clear':
        return Icon(WeatherIcons.day_sunny);
      case 'clouds':
        return Icon(WeatherIcons.day_cloudy);
      case 'rain':
        return Icon(WeatherIcons.rain);
      case 'snow':
        return Icon(WeatherIcons.snow);
      case 'thunderstorm':
        return Icon(WeatherIcons.thunderstorm);
      default:
        return Icon(WeatherIcons.alien);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
        drawer:  Drawers(
            selectedIndex: _selectedIndex,
            onItemTapped: (index) {
              setState(() {
                _selectedIndex = index;
              });}),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  child: _buildClickableCardWithWeather(
                    context,
                    Colors.transparent,
                    'Widget 1',
                    'sunny', // Condition météorologique actuelle (ici, ensoleillé)
                    () {
                      // Action à effectuer lorsque le widget est cliqué
                    },
                  ),
                ),
                Expanded(
                  child: _buildClickableCard(
                    context,
                    Colors.transparent,
                    'Pair to device',
                    () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MainPageBluetooth(),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: _buildClickableCardWithBackgroundImage(
              context,
              'assets/images/background/formulaire-quotidien.jpg',
              'How are you doing today ?\nAre you experiencing any symptoms?',
              () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => FormulaireQuotidien(),
                  ),
                );
              },
            ),
          ),
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  child: _buildClickableCard(
                    context,
                    Colors.transparent,
                    'Widget 4',
                    () {
                      // Action à effectuer lorsque le widget est cliqué
                    },
                  ),
                ),
                Expanded(
                  child: _buildClickableCard(
                    context,
                    Colors.transparent,
                    'Widget 5',
                    () {
                      // Action à effectuer lorsque le widget est cliqué
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildClickableCardWithWeather(
      BuildContext context,
      Color color,
      String title,
      String weatherCondition, // Ajoutez un paramètre pour la condition météo
      Function() onTap) {
    return InkWell(
      onTap: onTap,
      child: Card(
        elevation: 4,
        shadowColor: Colors.black,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Container(
          margin: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              getWeatherIcon(weatherCondition), // Afficher l'icône météo
              SizedBox(height: 10), // Espacement entre l'icône et le titre
              Text(
                title,
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildClickableCard(
      BuildContext context, Color color, String title, Function() onTap) {
    return InkWell(
      onTap: onTap,
      child: Card(
        elevation: 4,
        shadowColor: Colors.black,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Container(
          margin: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Center(
            child: Text(
              title,
              style: TextStyle(
                fontSize: 20,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildClickableCardWithBackgroundImage(BuildContext context,
      String backgroundImage, String title, Function() onTap) {
    return InkWell(
      onTap: onTap,
      child: Card(
        elevation: 4,
        shadowColor: Colors.black,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            image: DecorationImage(
              image: AssetImage(backgroundImage),
              fit: BoxFit.cover,
            ),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(width: 10), // Espacement à gauche de l'image
              Expanded(
                child: Text(
                  title,
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
