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
      var patients = await doctorService().getSensorData();
      setState(() {
        patientsData = patients;
      });

    } catch (error) {
      print('Error getting sensor data: $error');
      // Handle error: show a message or take appropriate action
    }
  }

  List<FlSpot> getFilteredData() {
    List<FlSpot> filteredData = [];

    if (selectedFilter == 'Week') {
      for (int i = 0; i < patientsData.length && i < 7; i++) {
        filteredData.add(FlSpot(i.toDouble(), patientsData[i].bmp.toDouble()));
      }
    } else if (selectedFilter == 'Month') {
      for (int i = 0; i < patientsData.length && i < 30; i++) {
        filteredData.add(FlSpot(i.toDouble(), patientsData[i].bmp.toDouble()));
      }
    } else {
      for (int i = 0; i < patientsData.length; i++) {
        filteredData.add(FlSpot(i.toDouble(), patientsData[i].bmp.toDouble()));
      }
    }

    return filteredData;
  }

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
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/background/splash_screen.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: [
            DropdownButton<String>(
              value: selectedFilter,
              onChanged: (value) {
                setState(() {
                  selectedFilter = value!;
                });
              },
              items: [
                DropdownMenuItem(
                  value: 'Week',
                  child: Text('Week'),
                ),
                DropdownMenuItem(
                  value: 'Month',
                  child: Text('Month'),
                ),
              ],
            ),
            SizedBox(height: 18.0),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
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
                    borderData: FlBorderData(show: true),
                    lineBarsData: [
                      LineChartBarData(
                        spots: getFilteredData(),
                        isCurved: true,
                        color: Color(0xFFEE83A3),
                        dotData: FlDotData(show: true),
                        belowBarData: BarAreaData(show: false),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 28.0),
            Text(
              "Highest BPM recorded",
              style: TextStyle(fontSize: 15, color: Color(0xFF000000), fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
//   List<int> getFilteredData(List<int> data) {
//     if (selectedFilter == 'Week') {
//       return data.sublist(0, data.length > 7 ? 7 : data.length);
//     } else if (selectedFilter == 'Month') {
//       return data.sublist(0, data.length > 30 ? 30 : data.length);
//     } else {
//       return [];
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     List<int> bpmData = patientsData.map((patient) => patient.bmp).toList();
//     List<int> filteredBPMData = getFilteredData(bpmData);
//
//     return Scaffold(
//       appBar: AppBar(
//         leading: IconButton(
//           icon: Icon(Icons.arrow_back),
//           onPressed: () {
//             Navigator.pop(context);
//           },
//         ),
//         title: const Text(
//           'Health Data',
//           style: TextStyle(
//             color: Colors.white,
//           ),
//         ),
//         backgroundColor: const Color(0xFFC987E1),
//       ),
//       body: SingleChildScrollView(
//         child: Column(
//           children: [
//             DropdownButton<String>(
//               value: selectedFilter,
//               onChanged: (String? newValue) {
//                 setState(() {
//                   selectedFilter = newValue!;
//                 });
//               },
//               items: <String>['Week', 'Month'].map((String value) {
//                 return DropdownMenuItem<String>(
//                   value: value,
//                   child: Text(value),
//                 );
//               }).toList(),
//             ),
//             LineChartWidget(
//               data: filteredBPMData,
//               title: 'Heart Rate',
//               legend: 'BPM',
//               selectedFilter: selectedFilter,
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
//
// class LineChartWidget extends StatelessWidget {
//   final List<int> data;
//   final String title;
//   final String legend;
//   final String selectedFilter;
//
//   LineChartWidget({required this.data, required this.title, required this.legend, required this.selectedFilter});
//
//   @override
//   Widget build(BuildContext context) {
//     int dataLength = selectedFilter == 'Week' ? 7 : (selectedFilter == 'Month' ? 30 : 0);
//     List<int> repeatedData = List<int>.generate(dataLength, (index) => data[data.length - 1 - index % data.length]);
//
//     return Container(
//       padding: const EdgeInsets.all(16.0),
//       child: Column(
//         children: [
//           Text(
//             title,
//             style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),
//           ),
//           const SizedBox(height: 8.0),
//           AspectRatio(
//             aspectRatio: 1.7,
//             child: LineChart(
//               LineChartData(
//                 lineTouchData: LineTouchData(enabled: true),
//                 gridData: FlGridData(show: false),
//                 titlesData: FlTitlesData(
//                   show: true,
//                   bottomTitles: AxisTitles(
//                     sideTitles: SideTitles(showTitles: true),
//                   ),
//                   leftTitles: AxisTitles(
//                     sideTitles: SideTitles(showTitles: true),
//                   ),),
//                 borderData: FlBorderData(show: true),
//                 lineBarsData: [
//                   LineChartBarData(
//                     spots: [
//                       for (int i = 0; i < dataLength; i++)
//                         FlSpot(i.toDouble(), repeatedData[i].toDouble()),
//                     ],
//                     isCurved: true,
//                     color: Color(0xFFEE83A3),
//                     dotData: FlDotData(show: true),
//                     belowBarData: BarAreaData(show: true, color: Color(0x15000000)),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//           SizedBox(height: 28.0),
//           Text(
//             legend,
//             style: TextStyle(fontSize: 15, color: Color(0x88000000), fontWeight: FontWeight.bold),
//           ),
//           SizedBox(height: 18.0),
//         ],
//       ),
//     );
//   }
// }
