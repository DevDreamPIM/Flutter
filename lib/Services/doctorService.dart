import 'dart:convert';

import 'package:epilepto_guard/Screens/Doctor/patientDetail.dart';

import '../Models/patientsModel.dart';
import '../Models/sensorModel.dart';
import '../Models/user.dart';
import '../Utils/Constantes.dart';

import 'package:http/http.dart' as http;


class doctorService{
  Future<List<PatientsModel>> getPatients() async {

    final response = await http.get(
      Uri.parse('${Constantes.URL_API}/doctor/getPatients'),
      // headers: {
      //   'Authorization': 'Bearer $token',
      // },
    );
    if (response?.statusCode == 200) {
      // List<dynamic> data = json.decode(response!.body);
      Map<String, dynamic> responseData = json.decode(response!.body);
      // print("responseData");
      // print(responseData);

      List<dynamic> data = responseData['data'];

      // print("aaaaaaaaaaaaaaaaaaaaaaaa");
      // print(data);
      return data.map((json) => PatientsModel.fromJson(json)).toList();
    } else {
      throw Exception('Failed to get patients');
    }
  }

  Future<List<SensorModel>> getSensorData() async {

    final response = await http.get(
      Uri.parse('${Constantes.URL_API}/sensors/609f1519c33d2d001d45e888'),
      // headers: {
      //   'Authorization': 'Bearer $token',
      // },
    );
    print(json.decode(response.body));
    if (response?.statusCode == 200) {
      List<dynamic> responseData = json.decode(response.body);
      print("getSensorDataaaaaaaaaaaaaaaaaa");
      print(responseData);

      // Convert the JSON object directly into a SensorModel
      return responseData.map((json) => SensorModel.fromJson(json)).toList();
    } else {
      throw Exception('Failed to get sensor data');
    }
  }
}