import 'package:epilepto_guard/Components/drawer.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class HealthData extends StatefulWidget {
  @override
  _HealthDataState createState() => _HealthDataState();
}

class _HealthDataState extends State<HealthData> {
  int _selectedIndex = 3;
  String selectedFilter = 'Week';

  final List<double> heartRateData = [70, 75, 72, 68, 73, 77, 75, 72, 68, 73, 77, 80, 70, 75, 72, 68, 73, 77, 80];
  final List<double> movementData = [200, 300, 250, 280, 320, 290, 310, 280, 320, 290, 310, 200, 300, 250, 280, 320, 290, 310];
  final List<double> temperatureData = [36.5, 36.4, 36.6, 36.7, 36.8, 36.5, 36.4, 36.6, 36.7, 36.8, 36.5, 36.6, 36.5, 36.4, 36.6, 36.7, 36.8, 36.5, 36.6];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: AppBar(
        title: const Text('Health Data', style: TextStyle(color: Colors.white)),
        backgroundColor: Color(0xFFA99ADC),
      ),
      drawer: Drawers(
        selectedIndex: _selectedIndex,
        onItemTapped: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            DropdownButton<String>(
              value: selectedFilter,
              onChanged: (String? newValue) {
                setState(() {
                  selectedFilter = newValue!;
                });
              },
              items: <String>['Week', 'Month'].map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            LineChartWidget(
              data: selectedFilter == 'Week' ? heartRateData.sublist(0, 7) :
              selectedFilter == 'Month' ? heartRateData.sublist(0, heartRateData.length >= 30 ? 30 : heartRateData.length) : [],
              title: 'Heart Rate',
              legend: 'BPM',
              selectedFilter: selectedFilter,
            ),
            LineChartWidget(
              data: selectedFilter == 'Week' ? movementData.sublist(0, 7) :
              selectedFilter == 'Month' ? movementData.sublist(0, movementData.length >= 30 ? 30 : movementData.length) : [],
              title: 'Movements',
              legend: 'Gyroscope Data',
              selectedFilter: selectedFilter,
            ),
            LineChartWidget(
              data: selectedFilter == 'Week' ? temperatureData.sublist(0, 7) :
              selectedFilter == 'Month' ? temperatureData.sublist(0, temperatureData.length >= 30 ? 30 : temperatureData.length) : [],
              title: 'Body Temperature',
              legend: '°C',
              selectedFilter: selectedFilter,
            ),
          ],
        ),
      ),
    );
  }
}


class LineChartWidget extends StatelessWidget {
  final List<double> data;
  final String title;
  final String legend;
  final String selectedFilter;

  LineChartWidget({required this.data, required this.title, required this.legend, required this.selectedFilter});

  @override
  Widget build(BuildContext context) {
    int dataLength = selectedFilter == 'Week' ? 7 : (selectedFilter == 'Month' ? data.length : 0);
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/background/splash_screen.png'),
          fit: BoxFit.cover,
        ),
      ),
      padding: EdgeInsets.all(16.0),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Text(
              title,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),
            ),
            SizedBox(height: 8.0),
            AspectRatio(
              aspectRatio: 1.7,
              child: LineChart(
                LineChartData(
                  lineTouchData: LineTouchData(enabled: true),
                  gridData: FlGridData(show: false),
                  titlesData: FlTitlesData(
                    show: true,
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(showTitles: true),
                    ),
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(showTitles: true),
                    ),
                  ),
                  borderData: FlBorderData(show: true),
                  lineBarsData: [
                    LineChartBarData(
                      spots: [
                        for (int i = 0; i < dataLength; i++)
                          FlSpot(i.toDouble(), data[i]),
                      ],
                      isCurved: true,
                      color: Color(0xFFEE83A3),
                      dotData: FlDotData(show: true),
                      belowBarData: BarAreaData(show: true, color: Color(0x15000000)),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 28.0),
            Text(
              legend,
              style: TextStyle(fontSize: 15, color: Color(0x88000000), fontWeight: FontWeight.bold
              ),
            ),
            SizedBox(height: 18.0),
          ],
        ),
      ),
    );
  }
}
