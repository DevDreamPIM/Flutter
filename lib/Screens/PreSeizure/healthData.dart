import 'package:epilepto_guard/Components/drawer.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../../Models/sensorModel.dart';
import '../../Services/doctorService.dart';

class HealthData extends StatefulWidget {
  @override
  _HealthDataState createState() => _HealthDataState();
}

class _HealthDataState extends State<HealthData> {
  int _selectedIndex = 3;
  String selectedFilter = 'Week';
  List<SensorModel> patientsData = [];

  @override
  void initState() {
    super.initState();
    fetchPatients();
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

  List<LineChartBarData> heartBeatData() {
    List<LineChartBarData> lineChartData = [];

    if (patientsData.isNotEmpty) {
      lineChartData.add(_buildLineChartBarData(
          data: patientsData
              .expand((e) => e.bmp!)
              .map((e) => e.toDouble())
              .toList(),
          color: Color(0xFFEE83A3)));
    }
    return lineChartData;
  }

  List<LineChartBarData> emgData() {
    List<LineChartBarData> lineChartData = [];

    if (patientsData.isNotEmpty) {
      lineChartData.add(_buildLineChartBarData(
          data: patientsData
              .expand((e) => e.emg!)
              .map((e) => e.toDouble())
              .toList(),
          color: Color(0xFFC987E1)));
    }
    return lineChartData;
  }

  LineChartBarData _buildLineChartBarData(
      {required List<double> data, required Color color}) {
    return LineChartBarData(
      spots: data
          .asMap()
          .entries
          .map((entry) => FlSpot(entry.key.toDouble(), entry.value))
          .toList(),
      isCurved: true,
      color: color,
      barWidth: 4,
      isStrokeCapRound: true,
      dotData: FlDotData(show: true),
      belowBarData: BarAreaData(show: false),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Health Data', style: TextStyle(color: Colors.white)),
        backgroundColor: const Color(0xFFC987E1),
      ),
      drawer: Drawers(
        selectedIndex: _selectedIndex,
        onItemTapped: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
      ),
      body: Stack(children: [
        Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Color(0xFFC2A3F7), Color(0xFFFFFFFF)],
            ),
          ),
          width: double.infinity,
          height: double.infinity,
        ),
        Positioned(
          top: 0,
          left: 0,
          child: Container(
            width: MediaQuery.of(context).size.width * .3,
            height: MediaQuery.of(context).size.height * .3,
            child: Opacity(
              opacity: 0.5,
              child: Image.asset(
                "assets/images/background/drug.png",
              ),
            ),
          ),
        ),
        Positioned(
          top: 150,
          right: 0,
          child: Container(
            width: MediaQuery.of(context).size.width * .3,
            height: MediaQuery.of(context).size.height * .3,
            child: Opacity(
              opacity: 0.5,
              child: Image.asset(
                "assets/images/background/drug.png",
              ),
            ),
          ),
        ),
        Positioned(
          bottom: 0,
          left: 140,
          child: Container(
            width: MediaQuery.of(context).size.width * .3,
            height: MediaQuery.of(context).size.height * .3,
            child: Opacity(
              opacity: 0.5,
              child: Image.asset(
                "assets/images/background/drug.png",
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(26.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                const SizedBox(height: 20),
                SizedBox(
                  height: MediaQuery.of(context).size.width * .17,
                  child: LineChart(
                    LineChartData(
                      gridData: const FlGridData(show: false),
                      lineBarsData: heartBeatData(),
                      titlesData: const FlTitlesData(
                        bottomTitles: AxisTitles(
                          sideTitles: SideTitles(
                            showTitles: true,
                            reservedSize: 30,
                          ),
                        ),
                        topTitles: AxisTitles(
                          sideTitles: SideTitles(showTitles: false),
                        ),
                        leftTitles: AxisTitles(
                          sideTitles:
                          SideTitles(showTitles: true, reservedSize: 30),
                        ),
                        rightTitles: AxisTitles(
                          sideTitles: SideTitles(
                            showTitles: false,
                            reservedSize: 30,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  "Highest BPM recorded",
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 60),
                SizedBox(
                  height: MediaQuery.of(context).size.width * .25,
                  child: LineChart(
                    LineChartData(
                      gridData: const FlGridData(show: true),
                      lineBarsData: emgData(),
                      titlesData: const FlTitlesData(
                        bottomTitles: AxisTitles(
                          sideTitles:
                          SideTitles(showTitles: true, reservedSize: 30),
                        ),
                        topTitles: AxisTitles(
                          sideTitles: SideTitles(showTitles: false),
                        ),
                        leftTitles: AxisTitles(
                          sideTitles:
                          SideTitles(showTitles: true, reservedSize: 30),
                        ),
                        rightTitles: AxisTitles(
                          sideTitles: SideTitles(showTitles: false),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  'EMG Data',
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
              ],
            ),
          ),
        ),
      ]),
    );
  }
}
