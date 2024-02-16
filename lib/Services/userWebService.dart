import 'dart:convert';
import 'package:epilepto_guard/Utils/Constantes.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class UserWebService {
  Future<bool> registerUser(
      String firstName,
      String lastName,
      String email,
      String phoneNumber,
      String password,
      String role,
      BuildContext context) async {
    final url = Uri.parse('${Constantes.URL_API}${Constantes.URL_API_USER}');
    final response = await http.post(
      url,
      body: jsonEncode({
        'firstName': firstName,
        'lastName': lastName,
        'email': email,
        'phoneNumber': phoneNumber,
        'password': password,
        'role': role,
      }),
      headers: {
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 201) {
      // User successfully registered
      print('User successfully registered');
      print(response.body);

      SnackBar snackBar = const SnackBar(
        content: Row(
          children: [
            Icon(Icons.check, color: Colors.white),
            SizedBox(width: 8),
            Text('Account created successfully!',
                style: TextStyle(color: Colors.white)),
          ],
        ),
        backgroundColor: Colors.green,
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      return true;


    }else if(response.statusCode == 409){
      SnackBar snackBar = const SnackBar(
        content: Row(
          children: [
            Icon(Icons.error, color: Colors.white),
            SizedBox(width: 8),
            Text('Email already in use',
                style: TextStyle(color: Colors.white)),
          ],
        ),
        backgroundColor: Colors.red,
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      return false;
    }else {
      SnackBar snackBar = SnackBar(
        content: Row(
          children: [
            const Icon(Icons.error, color: Colors.white),
            const SizedBox(width: 8),
            Text('Failed to register user. Status code: ${response.statusCode}',
                style: const TextStyle(color: Colors.white)),
          ],
        ),
        backgroundColor: Colors.red,
      );

      print('Failed to register user. Status code: ${response.statusCode}');
      ScaffoldMessenger.of(context).showSnackBar(snackBar);

      return false;
    }
  }
}
