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
      print("responseData");
      print(responseData);

      List<dynamic> data = responseData['data'];

      print("aaaaaaaaaaaaaaaaaaaaaaaa");
      print(data);
      return data.map((json) => PatientsModel.fromJson(json)).toList();
    } else {
      throw Exception('Failed to get patients');
    }
  }

  Future<SensorModel?> getSensorData() async {
    final response = await http.get(
      Uri.parse('${Constantes.URL_API}/doctor/getSensorData/609f1519c33d2d001d45e888'),
    );

    if (response.statusCode == 200) {
      Map<String, dynamic>? responseData = json.decode(response.body);
      if (responseData != null) {
        print("getSensorDataaaaaaaaaaaaaaaaaa");
        print(responseData['data']);

        // Check if the 'data' field is null
        if (responseData['data'] != null) {
          // Convert the JSON object directly into a SensorModel
          return SensorModel.fromJson(responseData['data']);
        } else {
          print("responseData['data'] is null");
          return null;
        }
      } else {
        throw Exception('Response data is null');
      }
    } else {
      throw Exception('Failed to get sensor data');
    }
  }
}