import 'package:epilepto_guard/Screens/Crise/detailDailyForm.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:intl/intl.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:epilepto_guard/Models/dailyForm.dart';
import 'package:epilepto_guard/Utils/Constantes.dart';

class DailyFormHistoryScreen extends StatefulWidget {
  @override
  _DailyFormHistoryScreenState createState() => _DailyFormHistoryScreenState();
}

class _DailyFormHistoryScreenState extends State<DailyFormHistoryScreen> {
  List<DailyForm> dailyForms =
      []; // Utiliser la liste de DailyForm au lieu de Crise

  Future<void> fetchDailyForms() async {
    const storage = FlutterSecureStorage();
    final String? token = await storage.read(key: "token");

    final response = await http.get(
      Uri.parse('${Constantes.URL_API}/dailyForm/'),
      headers: <String, String>{
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      setState(() {
        dailyForms = data
            .map((item) => DailyForm.fromJson(item))
            .toList(); // Convertir les données JSON en objets DailyForm
      });
    } else {
      throw Exception('Failed to load Forms');
    }
  }

  @override
  void initState() {
    super.initState();
    fetchDailyForms();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Daily Forms History',
          style: TextStyle(
            color: const Color(0xFF8A4FE9),
            fontSize: 24.0,
          ),
        ),
        centerTitle: true,
      ),
      body: Container(
        padding: EdgeInsets.all(20.0),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/background/login.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: ListView.builder(
          itemCount: dailyForms.length,
          itemBuilder: (BuildContext context, int index) {
            return Card(
              elevation: 4,
              margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              child: ListTile(
                title: Text(
                  // Utiliser les attributs du DailyForm pour afficher les détails
                  'Bed Time: ${dailyForms[index].bedTime.hour}:${dailyForms[index].bedTime.minute}',
                  style: TextStyle(fontSize: 18.0),
                ),
                subtitle: Text(
                  // Utiliser les autres attributs du DailyForm pour afficher les détails
                  'Stress: ${dailyForms[index].stress}, Mood Changes: ${dailyForms[index].moodchanges}',
                  style: TextStyle(fontSize: 16.0),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          DailyFormDetailScreen(dailyForm: dailyForms[index]),
                    ),
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
