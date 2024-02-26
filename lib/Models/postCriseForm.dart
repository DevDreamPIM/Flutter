class PostCriseFormData {
  int id; // id de la crise associée
  int selectedHours;
  int selectedMinutes;
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
  List<bool> triggerFactorsSelection;
  bool? injured;
  bool? conscious;
  bool? episodes;
  bool? memoryDisturbances;
  bool? assistance;
  bool? advice;
  double emotionalStateRating;
  double recoveryRating;
  double stressAnxietyRating;
  double medicalCareRating;
  String response1;
  String response2;
  String response3;

  PostCriseFormData({
    required this.id,
    required this.selectedHours,
    required this.selectedMinutes,
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
    required this.triggerFactorsSelection,
    required this.injured,
    required this.conscious,
    required this.episodes,
    required this.memoryDisturbances,
    required this.assistance,
    required this.advice,
    required this.emotionalStateRating,
    required this.recoveryRating,
    required this.stressAnxietyRating,
    required this.medicalCareRating,
    required this.response1,
    required this.response2,
    required this.response3,
  });

  // Méthode pour sérialiser les données du formulaire
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'selectedHours': selectedHours,
      'selectedMinutes': selectedMinutes,
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
      'triggerFactorsSelection': triggerFactorsSelection,
      'injured': injured,
      'conscious': conscious,
      'episodes': episodes,
      'memoryDisturbances': memoryDisturbances,
      'assistance': assistance,
      'advice': advice,
      'emotionalStateRating': emotionalStateRating,
      'recoveryRating': recoveryRating,
      'stressAnxietyRating': stressAnxietyRating,
      'medicalCareRating': medicalCareRating,
      'response1': response1,
      'response2': response2,
      'response3': response3,
    };
  }

  // Méthode pour désérialiser les données du formulaire
  factory PostCriseFormData.fromJson(Map<String, dynamic> json) {
    return PostCriseFormData(
      id: json['id'],
      selectedHours: json['selectedHours'],
      selectedMinutes: json['selectedMinutes'],
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
      triggerFactorsSelection: List<bool>.from(json['triggerFactorsSelection']),
      injured: json['injured'],
      conscious: json['conscious'],
      episodes: json['episodes'],
      memoryDisturbances: json['memoryDisturbances'],
      assistance: json['assistance'],
      advice: json['advice'],
      emotionalStateRating: json['emotionalStateRating'],
      recoveryRating: json['recoveryRating'],
      stressAnxietyRating: json['stressAnxietyRating'],
      medicalCareRating: json['medicalCareRating'],
      response1: json['response1'],
      response2: json['response2'],
      response3: json['response3'],
    );
  }
}
