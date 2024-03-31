class SensorModel {
  String? id;
  List<int>? emg;
  late int bmp;

  SensorModel(
      this.id,
      this.emg,
      this.bmp,
      );

  SensorModel.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    emg = List<int>.from(json['emg']);

    if (json['bmp'] is String) {
      bmp = int.parse(json['bmp']);
    } else {
      bmp = json['bmp'] is int ? json['bmp'] : 0;
    }
  }
}