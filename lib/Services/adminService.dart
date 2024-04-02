import 'dart:convert';


import '../Models/UserModel.dart';
import '../Models/feedbacksModel.dart';
import '../Models/user.dart';
import '../Utils/Constantes.dart';

import 'package:http/http.dart' as http;


class AdminService{
  Future<List<UserModel>> getUsers() async {

    final response = await http.get(
      Uri.parse('${Constantes.URL_API}/admin/getUsers'),
    );
    if (response?.statusCode == 200) {
      Map<String, dynamic> responseData = json.decode(response!.body);

      List<dynamic> data = responseData['data'];

      return data.map((json) => UserModel.fromJson(json)).toList();
    } else {
      throw Exception('Failed to get users');
    }
  }

  Future<List<FeedbacksModel>> getFeedback(String? id) async {

    final response = await http.get(
      Uri.parse('${Constantes.URL_API}/admin/getFeedback/$id'),
    );

    if (response?.statusCode == 200) {
      Map<String, dynamic> responseData = json.decode(response!.body);

      List<dynamic> data = responseData['data'];

      return data.map((json) => FeedbacksModel.fromJson(json)).toList();
    } else {
      throw Exception('Failed to get feedback');
    }
  }
}