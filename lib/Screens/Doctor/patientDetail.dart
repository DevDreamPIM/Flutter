import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../../Services/doctorService.dart';

class PatientDetail extends StatefulWidget {
  const PatientDetail({super.key});

  @override
  State<PatientDetail> createState() => _PatientDetailState();
}

class _PatientDetailState extends State<PatientDetail> {
  List<List<int>> emgData = [
    [2, 0, 0, 0, 0, -4, -1, 2],
    [4, 6, 0, 3, 8, -2, -1, 0],
    [2, 5, 5, 8, 3, -4, -4, 2],
    [15, -3, -2, -5, 4, 7, 6, 9]
  ];

  @override
  void initState() {
    super.initState();
    fetchPatients();
  }

  Future<void> fetchPatients() async {
    try {
      var patients = await doctorService().getSensorData();
      setState(() {
        // emgData = patients;
      });
    } catch (error) {
      print('Error getting sensor data: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'EMG Signals Chart',
          style: TextStyle(
            color: Colors.white,
            fontSize: 24.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: const Color(0xFFC987E1),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Container(
              width: MediaQuery.of(context).size.width * .95,
              height: MediaQuery.of(context).size.height * .85,
              child: LineChart(
                LineChartData(
                  titlesData: FlTitlesData(
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(showTitles: true),
                    ),
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(showTitles: true),
                    ),
                  ),
                  lineBarsData: emgData.asMap().entries.map((entry) {
                    final index = entry.key;
                    final data = entry.value;

                    return LineChartBarData(
                      spots: List.generate(data.length, (index) {
                        return FlSpot(index.toDouble(), data[index].toDouble());
                      }),
                      isCurved: false,
                      color: Colors.purple,
                      // You can specify colors for each line
                      barWidth: 3,
                      belowBarData: BarAreaData(show: false),
                      dotData: FlDotData(show: false),
                    );
                  }).toList(),
                  borderData: FlBorderData(show: true),
                  minX: 0,
                  maxX: emgData[0].length.toDouble() - 1,
                  minY: emgData
                      .expand((data) => data)
                      .reduce((a, b) => a < b ? a : b)
                      .toDouble(),
                  maxY: emgData
                      .expand((data) => data)
                      .reduce((a, b) => a > b ? a : b)
                      .toDouble(),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class EMGData {
  final int index;
  final int value;

  EMGData(this.index, this.value);
}
