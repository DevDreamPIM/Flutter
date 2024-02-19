import 'dart:convert';
import 'package:epilepto_guard/Utils/Constantes.dart';
import 'package:epilepto_guard/Utils/rescrueStorage.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
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
    } else if (response.statusCode == 409) {
      SnackBar snackBar = const SnackBar(
        content: Row(
          children: [
            Icon(Icons.error, color: Colors.white),
            SizedBox(width: 8),
            Text('Email already in use', style: TextStyle(color: Colors.white)),
          ],
        ),
        backgroundColor: Colors.red,
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      return false;
    } else {
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

  Future<bool> login(context, email, password) async {
    Map<String, Object> userObject = {
      "email": email,
      "password": password,
    };

    final url =
        Uri.parse('${Constantes.URL_API}${Constantes.URL_API_USER}/login');
    final response = await http.post(
      url,
      body: jsonEncode(userObject),
      headers: {
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      final responseData = json.decode(response.body);
      RescureStorage.saveData(responseData);
     
      var name = responseData['firstName']+" "+responseData['lastName'];
      SnackBar snackBar =  SnackBar(
        content: Row(
          children: [
            const Icon(Icons.check, color: Colors.white),
            const SizedBox(width: 8),
            Text('Welcome $name', style: const TextStyle(color: Colors.white)),
          ],
        ),
        backgroundColor: Colors.green,
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      return true;
    } else {
      SnackBar snackBar = SnackBar(
        content: Row(
          children: [
            const Icon(Icons.error, color: Colors.white),
            const SizedBox(width: 8),
            Text(response.body,
                style: const TextStyle(color: Colors.white)),
          ],
        ),
        backgroundColor: Colors.red,
      );

      print('Failed to login user. Status code: ${response.statusCode}');
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      return false;
    }
  }

  Future<bool> sendCode(String email,BuildContext context) async {
    final url = Uri.parse('${Constantes.URL_API}${Constantes.URL_API_USER}/sendActivationCode');
    final response = await http.post(
      url,
      body: jsonEncode({
        'email': email,
      }),
      headers: {
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
  SnackBar snackBar =  const SnackBar(
        content: Row(
          children: [
            Icon(Icons.check, color: Colors.white),
            SizedBox(width: 8),
            Text('Check your email', style: TextStyle(color: Colors.white)),
          ],
        ),
        backgroundColor: Colors.green,
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);

      print('Code sent successfully');
      print(response.body);
      return true;

    }else {
      SnackBar snackBar = const SnackBar(
        content: Row(
          children: [
            Icon(Icons.error, color: Colors.white),
            SizedBox(width: 8),
            Text('Failed to send code.please verify your email address and try again.',
                style: TextStyle(color: Colors.white)),
          ],
        ),
        backgroundColor: Colors.red,
      );

      print('Failed to send code. Status code: ${response.statusCode}');
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      return false;
    }
  }

  Future<bool> verifyCode(String email, int code, BuildContext context) async {
    final url = Uri.parse('${Constantes.URL_API}${Constantes.URL_API_USER}/verifyCode');
    print(email);
    final response = await http.post(
      url,
      body: jsonEncode({
        'email': email,
        'resetCode': code,
      }),
      headers: {
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      SnackBar snackBar = const SnackBar(
        content: Row(
          children: [
            Icon(Icons.check, color: Colors.white),
            SizedBox(width: 8),
            Text('Code verified successfully!', style: TextStyle(color: Colors.white)),
          ],
        ),
        backgroundColor: Colors.green,
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);

      print('Code verified successfully!');
      print(response.body);
      return true;

    }else {
      SnackBar snackBar =  SnackBar(
        content: Row(
          children: [
            Icon(Icons.error, color: Colors.white),
            SizedBox(width: 8),
            Text('Incorrect code. Please try again.',
                style: TextStyle(color: Colors.white)),
          ],
        ),
        backgroundColor: Colors.red,
      );

      print('Failed to verify code. Status code: ${response.statusCode}');
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      return false;
    }
  }

  Future<bool> resetPassword(String email, String password, String confirmPassword ,BuildContext context) async {
    final url = Uri.parse('${Constantes.URL_API}${Constantes.URL_API_USER}/resetPassword');
    final response = await http.post(
      url,
      body: jsonEncode({
        'email': email,
        'newPassword': password,
        'confirmPassword': confirmPassword,
      }),
      headers: {
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      SnackBar snackBar = const SnackBar(
        content: Row(
          children: [
            Icon(Icons.check, color: Colors.white),
            SizedBox(width: 8),
            Text('Password reset successfully!', style: TextStyle(color: Colors.white)),
          ],
        ),
        backgroundColor: Colors.green,
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);

      print('Password reset successfully!');
      print(response.body);
      return true;

    }else {
      SnackBar snackBar =  SnackBar(
        content: Row(
          children: [
            Icon(Icons.error, color: Colors.white),
            SizedBox(width: 8),
            Text('Failed to reset password. Status code: ${response.statusCode}',
                style: TextStyle(color: Colors.white)),
          ],
        ),
        backgroundColor: Colors.red,
      );

      print('Failed to reset password. Status code: ${response.statusCode}');
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      return false;
    }
  }

}


