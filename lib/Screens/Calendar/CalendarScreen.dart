import 'dart:ui';

import 'package:epilepto_guard/consts.dart';
import 'package:flutter/material.dart';
import 'package:weather/weather.dart';

import '../../colors.dart';

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
            image: AssetImage('assets/images/background/splash_screen.png'),
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
          child: ClipRect(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
              child: Container(
                width: MediaQuery.of(context).size.width * 0.9,
                height: MediaQuery.of(context).size.height * 0.2,
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 175, 80, 212).withOpacity(0.5),
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: EdgeInsets.symmetric(
                    horizontal: 20), // Adding left and right padding
                child: Row(
                  children: [
                    // First Column
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Monday',
                            style: TextStyle(fontSize: 16), // Normal size
                          ),
                          Text(
                            '8:00 AM', // Buffer size
                            style: TextStyle(
                                fontSize: 24, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                    // Second Column
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment
                            .end, // Align elements to the right
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Town Name',
                            style: TextStyle(fontSize: 16),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Image.asset(
                                'assets/images/background/drug.png',
                                width: 50,
                                height: 50,
                              ),
                              SizedBox(width: 8),
                              Text(
                                '23',
                                style: TextStyle(
                                    fontSize: 24, fontWeight: FontWeight.bold),
                              ),
                            ],
                          ), // Adjust the image path
                          Text(
                            'Max: 25°C - Min: 15°C',
                            style: TextStyle(fontSize: 16),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    }
  }
}
