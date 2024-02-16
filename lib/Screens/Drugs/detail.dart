import 'package:flutter/material.dart';
import 'package:epilepto_guard/models/drug.dart';
import 'package:epilepto_guard/Screens/Drugs/modify.dart';

class DetailDrug extends StatelessWidget {
  final Drug drug;

  DetailDrug({required this.drug});

  Widget buildInfoRow(String label, String? value, IconData icon) {
    return Row(
      children: [
        Icon(icon, color: Colors.greenAccent),
        SizedBox(width: 8),
        Text(
          '$label: ${value ?? "N/A"}',
          style: TextStyle(fontSize: 18),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${drug.title}'),
        backgroundColor: Color(0xFF00C9B7),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 500,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              image: DecorationImage(
                image: AssetImage('/images/background/parkizol.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 16),
                buildInfoRow('Title', drug.title, Icons.local_hospital),
                buildInfoRow('Description', drug.description, Icons.description),
                buildInfoRow('Date', drug.date ?? "N/A", Icons.date_range), // Vérification de nullité
                buildInfoRow('Time', drug.time ?? "N/A", Icons.access_time), // Vérification de nullité
                buildInfoRow('Frequency', drug.frequencyOfIntake, Icons.access_alarm),
                // Ajouter d'autres champs au besoin
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        color: Color(0xFF00C9B7),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextButton(
              onPressed: () {
                Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => UpdateMedicineScreen()),
                        );
              },
              child: Text(
                'Update',
                style: TextStyle(
                  color: Colors.blue,
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                // Ajouter la fonctionnalité pour supprimer le médicament
              },
              child: Text(
                'Delete',
                style: TextStyle(
                  color: Colors.red,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
