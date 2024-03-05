import 'package:flutter/material.dart';

class DailyForm {
  // String userId;
  TimeOfDay bedTime;
  TimeOfDay wakeUpTime;
  double stress;
  double alcoholDrug;
  bool? medication;
  double moodchanges;
  double? sleeping;
  double? flashingLights;
  double? exercise;
  //List<dynamic>? list; // Liste d'attributs manquante
  String recentChanges;
  bool visualAuraChecked;
  bool sensoryAuraChecked;
  bool auditoryAuraChecked;
  bool gustatoryOrOlfactoryAuraChecked;
  bool headachesChecked;
  bool excessiveFatigueChecked;
  bool abnormalMoodChecked;
  bool sleepDisturbancesChecked;
  bool concentrationDifficultiesChecked;
  bool increasedSensitivityChecked;

  DailyForm({
    // required this.userId,
    required this.bedTime,
    required this.wakeUpTime,
    required this.stress,
    required this.alcoholDrug,
    this.medication,
    required this.moodchanges,
    this.sleeping,
    this.flashingLights,
    this.exercise,
    //this.list, // Liste d'attributs manquante
    required this.recentChanges,
    required this.visualAuraChecked,
    required this.sensoryAuraChecked,
    required this.auditoryAuraChecked,
    required this.gustatoryOrOlfactoryAuraChecked,
    required this.headachesChecked,
    required this.excessiveFatigueChecked,
    required this.abnormalMoodChecked,
    required this.sleepDisturbancesChecked,
    required this.concentrationDifficultiesChecked,
    required this.increasedSensitivityChecked,
  });

  // Méthode pour sérialiser les données du formulaire
  Map<String, dynamic> toJson() {
    return {
      // 'userId': userId,
      'bedTime':
          '${bedTime.hour}:${bedTime.minute}', // Convertir TimeOfDay en String
      'wakeUpTime':
          '${wakeUpTime.hour}:${wakeUpTime.minute}', // Convertir TimeOfDay en String
      'stress': stress,
      'alcoholDrug': alcoholDrug,
      'medication': medication,
      'moodchanges': moodchanges,
      'sleeping': sleeping,
      'flashingLights': flashingLights,
      'exercise': exercise,
      //'list': list, // Liste d'attributs manquante
      'recentChanges': recentChanges,
      'visualAuraChecked': visualAuraChecked,
      'sensoryAuraChecked': sensoryAuraChecked,
      'auditoryAuraChecked': auditoryAuraChecked,
      'gustatoryOrOlfactoryAuraChecked': gustatoryOrOlfactoryAuraChecked,
      'headachesChecked': headachesChecked,
      'excessiveFatigueChecked': excessiveFatigueChecked,
      'abnormalMoodChecked': abnormalMoodChecked,
      'sleepDisturbancesChecked': sleepDisturbancesChecked,
      'concentrationDifficultiesChecked': concentrationDifficultiesChecked,
      'increasedSensitivityChecked': increasedSensitivityChecked,
    };
  }

  // Méthode pour désérialiser les données du formulaire
  factory DailyForm.fromJson(Map<String, dynamic> json) {
    return DailyForm(
      // userId: json['userId'],
      bedTime: _parseTime(json['bedTime']),
      wakeUpTime: _parseTime(json['wakeUpTime']),
      stress: json['stress'],
      alcoholDrug: json['alcoholDrug'],
      medication: json['medication'],
      moodchanges: json['moodchanges'],
      sleeping: json['sleeping'],
      flashingLights: json['flashingLights'],
      exercise: json['exercise'],
      //list: json['list'], // Liste d'attributs manquante
      recentChanges: json['recentChanges'],
      visualAuraChecked: json['visualAuraChecked'],
      sensoryAuraChecked: json['sensoryAuraChecked'],
      auditoryAuraChecked: json['auditoryAuraChecked'],
      gustatoryOrOlfactoryAuraChecked: json['gustatoryOrOlfactoryAuraChecked'],
      headachesChecked: json['headachesChecked'],
      excessiveFatigueChecked: json['excessiveFatigueChecked'],
      abnormalMoodChecked: json['abnormalMoodChecked'],
      sleepDisturbancesChecked: json['sleepDisturbancesChecked'],
      concentrationDifficultiesChecked:
          json['concentrationDifficultiesChecked'],
      increasedSensitivityChecked: json['increasedSensitivityChecked'],
    );
  }

  // Méthode pour convertir une String au format HH:mm en TimeOfDay
  static TimeOfDay _parseTime(String timeString) {
    final parts = timeString.split(':');
    return TimeOfDay(hour: int.parse(parts[0]), minute: int.parse(parts[1]));
  }
}
