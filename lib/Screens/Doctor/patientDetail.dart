import 'dart:math';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../Localization/language_constants.dart';
import '../../Models/sensorModel.dart';
import '../../Services/doctorService.dart';

class PatientDetail extends StatefulWidget {
  const PatientDetail({Key? key}) : super(key: key);
  @override
  State<PatientDetail> createState() => _PatientDetailState();
}
class _PatientDetailState extends State<PatientDetail> {
  List<SensorModel> patientsData = [];
  bool _darkMode = false; // Default mode

  @override
  void initState() {
    super.initState();
    _initPreferences();
    fetchPatients();
  }

  Future<void> _initPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _darkMode = prefs.getBool('darkMode') ?? false;
    });
  }

  Future<void> fetchPatients() async {
    try {
      var patients = await DoctorService().getSensorData();
      setState(() {
        patientsData = patients;
      });
    } catch (error) {
      print('Error getting sensor data: $error');
    }
  }
  List<Widget> _buildLineCharts() {
    List<Widget> charts = [];
    if (patientsData.isNotEmpty && patientsData[0].emg != null) {
      for (int i = 0; i < patientsData[0].emg!.length; i++) {
        List<FlSpot> spots = [];
        for (int j = 0; j < patientsData.length; j++) {
          if (patientsData[j].emg != null && patientsData[j].emg!.isNotEmpty) {
            if (i < patientsData[j].emg!.length) {
              double value = patientsData[j].emg![i].toDouble();
              if (value.isFinite) {
                spots.add(FlSpot(
                  j.toDouble(),
                  value,
                ));
              } else {
                print('Invalid value at index $i, patient $j: $value');
              }
            }
          }
        }
        charts.add(
          LineChart(
            LineChartData(
              titlesData: FlTitlesData(
                bottomTitles: AxisTitles(
                  sideTitles: SideTitles(showTitles: true),
                ),
                leftTitles: AxisTitles(
                  sideTitles: SideTitles(showTitles: true),
                ),
              ),
              lineBarsData: [
                LineChartBarData(
                  spots: spots,
                  isCurved: false,
                  color: Colors.purple,
                  barWidth: 3,
                  belowBarData: BarAreaData(show: false),
                  dotData: FlDotData(show: false),
                ),
              ],
              borderData: FlBorderData(show: true),
              minX: 0,
              maxX: patientsData.length.toDouble() - 1,
              minY: spots.isNotEmpty ? spots.map((spot) => spot.y).reduce(min) : 0,
              maxY: spots.isNotEmpty ? spots.map((spot) => spot.y).reduce(max) : 0,
            ),
          ),
        );
      }
    }
    return charts;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          getTranslated(context, 'EMG Signals Chart'),
          style: TextStyle(
            color: Colors.white,
            fontSize: 24.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: _darkMode ? Color(0xFF301148) : Color(0xFFC987E1),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: _darkMode
                ? [const Color(0xFF4B0082), const Color(0xFF202020)]
                : [const Color(0xFFC2A3F7), const Color(0xFFFFFFFF)],
          ),
        ),
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Container(
                width: MediaQuery.of(context).size.width * .95,
                height: MediaQuery.of(context).size.height * .85,
                child: Row(
                  children: _buildLineCharts(),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
