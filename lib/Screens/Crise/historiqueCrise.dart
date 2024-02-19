import 'package:epilepto_guard/Screens/Crise/detailCrise.dart';
import 'package:flutter/material.dart';
import 'package:epilepto_guard/Models/crise.dart';

class CrisisHistoryScreen extends StatelessWidget {
  final List<Crisis> crises = [
    Crisis(
      date: DateTime(2024, 2, 8),
      startTime: TimeOfDay(hour: 9, minute: 0),
      endTime: TimeOfDay(hour: 9, minute: 30),
      duration: 30, // en minutes
      type: CrisisType.partial,
      location: 'Home',
      //symptoms: ['Symptom 1', 'Symptom 2'],
      //preSymptoms: 'Pre-symptom',
      emergencyServicesCalled: false,
      medicalAssistance: true,
      severity: 'mild',
    ),
    Crisis(
      date: DateTime(2024, 2, 5),
      startTime: TimeOfDay(hour: 12, minute: 0),
      endTime: TimeOfDay(hour: 12, minute: 15),
      duration: 15, // en minutes
      type: CrisisType.generalized,
      location: 'School',
     // symptoms: ['Symptom 3', 'Symptom 4'],
     // preSymptoms: 'Pre-symptom',
      emergencyServicesCalled: true,
      medicalAssistance: true,
      severity: 'moderate',
    ),
    Crisis(
      date: DateTime(2024, 2, 2),
      startTime: TimeOfDay(hour: 18, minute: 0),
      endTime: TimeOfDay(hour: 18, minute: 5),
      duration: 5, // en minutes
      type: CrisisType.absence,
      location: 'Park',
     // symptoms: ['Symptom 5', 'Symptom 6'],
     // preSymptoms: 'Pre-symptom',
      emergencyServicesCalled: false,
      medicalAssistance: false,
      severity: 'severe',
    ),
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
                  crises[index].date.toString(),
                  style: TextStyle(fontSize: 18.0),
                ),
                subtitle: Text(
                  crises[index].type.toString().split('.')[
                      1], // Récupérer le nom du type sans le préfixe "CrisisType."
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
