import 'package:epilepto_guard/consts.dart';
import 'package:flutter/material.dart';
import 'package:weather/weather.dart';

class CalendarScreen extends StatefulWidget {
  const CalendarScreen({super.key});

  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  final WeatherFactory _wf = WeatherFactory(OPENWEATHER_API_KEY);

  Weather? _weather;
  String cityName = "Tunis";

  @override
  void initState() {
    super.initState();
    // _wf.currentWeatherByLocation();
    _wf.currentWeatherByCityName(cityName).then((w) {
      setState(() {
        _weather = w;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/background/background.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: _buildUI(),
      ),
    );
  }

  Widget _buildUI() {
    if (_weather == null) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    } else {
      return Align(
        alignment: Alignment.topCenter,
        child: Container(
          margin: EdgeInsets.only(top: 20),
          width: MediaQuery.of(context).size.width * 0.9,
          height: MediaQuery.of(context).size.height * 0.2,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10), // 10px radius corners
            color: Colors.white, // Color of the rectangle
          ),
        ),
      );
    }
  }
}
