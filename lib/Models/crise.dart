import 'package:flutter/material.dart';

enum CrisisType {
  partial,
  generalized,
  absence,
}

class Crisis {
  //final String idCrise;
  final DateTime date;
  final TimeOfDay startTime;
  final TimeOfDay endTime;
  final int duration;
  final String location;
  final CrisisType type;
  final bool emergencyServicesCalled;
  final bool medicalAssistance;
  final String severity;

  Crisis({
    //required this.idCrise,
    required this.date,
    required this.startTime,
    required this.endTime,
    required this.duration,
    required this.type,
    required this.location,
    required this.emergencyServicesCalled,
    required this.medicalAssistance,
    required this.severity,
  });

  // Méthode pour désérialiser un objet JSON en instance de Crisis
  factory Crisis.fromJson(Map<String, dynamic> json) {
    return Crisis(
      date: DateTime.parse(json['date']),
      startTime: _parseTimeOfDay(json['startTime']),
      endTime: _parseTimeOfDay(json['endTime']),
      duration: json['duration'],
      location: json['location'],
      type: CrisisType.values.firstWhere(
          (type) => type.toString() == 'CrisisType.${json['type']}'),
      emergencyServicesCalled: json['emergencyServicesCalled'],
      medicalAssistance: json['medicalAssistance'],
      severity: json['severity'],
    );
  }

  static TimeOfDay _parseTimeOfDay(String timeString) {
    final parts = timeString.split(':');
    return TimeOfDay(hour: int.parse(parts[0]), minute: int.parse(parts[1]));
  }
}
