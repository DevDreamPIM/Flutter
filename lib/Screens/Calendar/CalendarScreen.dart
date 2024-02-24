import 'dart:ui';

import 'package:epilepto_guard/consts.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:weather/weather.dart';
import 'package:epilepto_guard/Screens/Drugs/add.dart';
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

  DateTime today = DateTime.now();
  void _onDaySelected(DateTime day, DateTime focusedDay) {
    setState(() {
      today = day;
    });
  }

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
      appBar: AppBar(
        title: Text('Calendar',
          style: TextStyle(
          color: Colors.white,
        ),
      ),
      backgroundColor: const Color(0xFFC987E1),
      ),
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/background/background.png'),
                fit: BoxFit.cover,
              ),
            ),
            child: Column(
              children: [
                _buildWeatherUI(),
                _buildCalendarUI(),
              ],
            ),
          ),
          Positioned(
            bottom: 16,
            right: 16,
            child: ElevatedButton(
              onPressed: () {
                _showSelectionPopup(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.purple,
              ),
              child: const Padding(
                padding: EdgeInsets.symmetric(vertical: 16.0),
                child: Text('Add',
                    style: TextStyle(fontSize: 18.0, color: Colors.white)),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showSelectionPopup(BuildContext context) {
    showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) {
        return ListView(
          shrinkWrap: true,
          children: [
            ListTile(
              title: Center(child: Text('Add Drug')),
              onTap: () {
                // Handle selection of Item 1
                Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => AddMedicineScreen()),
                        );
              },
            ),
            ListTile(
              title: Center(child: Text('Add Drug Reminder')),
              onTap: () {
                // Handle selection of Item 2
                Navigator.pop(context);
              },
            ),
            // ListTile(
            //   title: Center(child: Text('Item 3')),
            //   onTap: () {
            //     // Handle selection of Item 3
            //     Navigator.pop(context);
            //   },
            // ),
          ],
        );
      },
    );
  }

  Widget _buildCalendarUI() {
    return Padding(
      padding: const EdgeInsets.all(6.0),
      child: Container(
        margin: EdgeInsets.only(top: 20),
        child: Column(
          children: [
            Container(
              child: TableCalendar(
                rowHeight: 80,
                headerStyle: HeaderStyle(
                    formatButtonVisible: false, titleCentered: true),
                availableGestures: AvailableGestures.all,
                selectedDayPredicate: (day) => isSameDay(day, today),
                focusedDay: today,
                firstDay: DateTime.utc(2023),
                lastDay: DateTime.utc(2034),
                onDaySelected: _onDaySelected,
              ),
            ),
            Text("Selected Day: ${today.toString().split(" ")[0]}"),
          ],
        ),
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
                              const SizedBox(width: 8),
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
                            style: const TextStyle(fontSize: 16),
                          ),
                          Text(
                            "Humidity: ${_weather?.humidity?.toStringAsFixed(0)}%",
                            style: const TextStyle(fontSize: 16),
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
