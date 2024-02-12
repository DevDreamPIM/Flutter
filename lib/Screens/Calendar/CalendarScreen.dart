import 'dart:ui';

import 'package:epilepto_guard/consts.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
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
            image: AssetImage('assets/images/background/background.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: _buildWeatherUI(),
      ),
    );
  }

  Widget _buildWeatherUI() {
    if (_weather == null) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    } else {
      DateTime now = _weather!.date!;

      return Align(
        alignment: Alignment.topCenter,
        child: Container(
          margin: const EdgeInsets.only(top: 20),
          width: MediaQuery.of(context).size.width * 0.9,
          height: MediaQuery.of(context).size.height * 0.2,
          child: ClipRect(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
              child: Container(
                width: MediaQuery.of(context).size.width * 0.9,
                height: MediaQuery.of(context).size.height * 0.1,
                decoration: BoxDecoration(
                  color: AppColors.purple.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: [
                    // First Column
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            DateFormat("EEEE, MMMM dd").format(now),
                            style: const TextStyle(fontSize: 16),
                          ),
                          Text(
                            DateFormat("hh:mm a").format(now),
                            style: const TextStyle(
                              fontSize: 28,
                            ),
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
                            _weather?.areaName ?? "No Area Name",
                            style: const TextStyle(fontSize: 16),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Container(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 4),
                                decoration: BoxDecoration(
                                  color: AppColors.purple.withOpacity(0.2),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Column(
                                  children: [
                                    Image.network(
                                      "http://openweathermap.org/img/wn/${_weather?.weatherIcon}@4x.png",
                                      width: 50,
                                      height: 50,
                                    ),
                                    Text(
                                      _weather?.weatherDescription ??
                                          "No Description",
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(width: 8),
                              Text(
                                "${_weather?.temperature?.celsius?.toStringAsFixed(0)}°C",
                                style: const TextStyle(fontSize: 28),
                              ),
                            ],
                          ),
                          // Text(
                          //   "Max: ${_weather?.tempMax?.celsius?.toStringAsFixed(0)}°C - Min: ${_weather?.tempMin?.celsius?.toStringAsFixed(0)}°C",
                          //   style: TextStyle(fontSize: 16),
                          // ),
                          Text(
                            "Wind: ${_weather?.windSpeed?.toStringAsFixed(0)}m/s",
                            style: TextStyle(fontSize: 16),
                          ),
                          Text(
                            "Humidity: ${_weather?.humidity?.toStringAsFixed(0)}%",
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
