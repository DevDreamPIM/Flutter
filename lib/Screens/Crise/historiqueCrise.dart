import 'package:epilepto_guard/Screens/Crise/detailCrise.dart';
import 'package:flutter/material.dart';
import 'package:epilepto_guard/Models/crise.dart';

class CrisisHistoryScreen extends StatelessWidget {
  final List<Crisis> crises = [
    Crisis(
        date: '2024-02-08',
        startTime: '09:00',
        endTime: '09:30',
        duration: '00:30',
        type: 'Partial Seizure',
        location: 'Home'),
    Crisis(
        date: '2024-02-05',
        startTime: '12:00',
        endTime: '12:15',
        duration: '00:15',
        type: 'Generalized Seizure',
        location: 'School'),
    Crisis(
        date: '2024-02-02',
        startTime: '18:00',
        endTime: '18:05',
        duration: '00:05',
        type: 'Absence Seizure',
        location: 'Park'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Crisis History',
          style: TextStyle(
            color: const Color(0xFF8A4FE9),
            fontSize: 24.0,
          ),
        ),
        centerTitle: true,
      ),
      body: Container(
        padding: EdgeInsets.all(20.0),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/background/login.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: ListView.builder(
          itemCount: crises.length,
          itemBuilder: (BuildContext context, int index) {
            return Card(
              elevation: 4, // Ajouter une ombre
              margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              child: ListTile(
                title: Text(
                  crises[index].date,
                  style: TextStyle(fontSize: 18.0),
                ),
                subtitle: Text(
                  crises[index].type,
                  style: TextStyle(fontSize: 16.0),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CrisisDetailScreen(crises[index]),
                    ),
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
