class SensorModel {
  String? id;
  List<int>? emg;
  int? bmp;

  SensorModel(
      this.id,
      this.emg,
      this.bmp,

      );

  SensorModel.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    emg = List<int>.from(json['emg']);
    bmp = json['bmp'];
  }

}
