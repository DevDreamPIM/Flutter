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
}
