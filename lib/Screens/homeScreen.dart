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
import 'dart:convert'; // Importez pour utiliser json.decode
import 'package:http/http.dart'
    as http; // Importez pour effectuer des requêtes HTTP

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

  Future<String> fetchWeatherData(String city) async {
    final apiKey = '55d01bf8725c76115d1b1c6d31fecae5';
    final response = await http.get(Uri.parse(
        'https://api.openweathermap.org/data/2.5/weather?q=Tunis&appid=$apiKey'));

    if (response.statusCode == 200) {
      final weatherData = json.decode(response.body);
      final weatherCondition = weatherData['weather'][0]['main'];
      return weatherCondition;
    } else {
      throw Exception('Failed to load weather data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      drawer: Drawers(
        selectedIndex: _selectedIndex,
        onItemTapped: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  child: FutureBuilder<String>(
                    future: fetchWeatherData('Tunis'),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(child: CircularProgressIndicator());
                      } else if (snapshot.hasError) {
                        return Center(child: Text('Error: ${snapshot.error}'));
                      } else {
                        final weatherCondition = snapshot.data!;
                        return _buildClickableCardWithWeather(
                          context,
                          Colors.transparent,
                          'Weather',
                          weatherCondition,
                          () {
                            // Action à effectuer lorsque le widget est cliqué
                          },
                        );
                      }
                    },
                  ),
                ),
                //*****************2*********************** */
                Expanded(
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MainPageBluetooth(),
                        ),
                      );
                      // Action à effectuer lorsque l'image est cliquée
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(
                            'assets/images/background/pairdevice.jpg',
                          ),
                          fit: BoxFit
                              .cover, // Pour que l'image occupe tout le conteneur
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                              height:
                                  10), // Espacement entre l'image et le titre
                          Text(
                            'Pair to Device',
                            style: TextStyle(
                              fontSize:
                                  20, // Ajustez la taille de la police selon vos besoins
                              fontWeight: FontWeight
                                  .bold, // Vous pouvez modifier le style du texte ici
                              color: Colors.blueGrey, // Couleur du texte
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          //*************3********************************* */
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

  Widget _buildClickableCardWithWeather(BuildContext context, Color color,
      String title, String weatherCondition, Function() onTap) {
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
              getWeatherIcon(weatherCondition),
              SizedBox(height: 10),
              Text(
                title,
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.black,
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
              SizedBox(width: 10),
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
