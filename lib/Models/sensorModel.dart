class SensorModel {
  String? id;
  List<int>? emg;
  List<int>? bmp;
  // late int bmp;

  SensorModel(
      this.id,
      this.emg,
      this.bmp,
      );

  SensorModel.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    emg = List<int>.from(json['emg']);
    bmp = List<int>.from(json['bmp']);

    // if (json['bmp'] is String) {
    //   bmp = int.parse(json['bmp']);
    // } else {
    //   bmp = json['bmp'] is int ? json['bmp'] : 0;
    // }
  }
}