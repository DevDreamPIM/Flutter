import 'package:epilepto_guard/Screens/Crise/postCriseFormulaire.dart';
import 'package:flutter/material.dart';
import 'package:epilepto_guard/Models/crise.dart' as CriseModel;

class CrisisDetailScreen extends StatelessWidget {
  final CriseModel.Crisis crisis;

  const CrisisDetailScreen(this.crisis);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Crisis Detail',
          style: TextStyle(
            color: const Color(0xFF8A4FE9),
            fontSize: 24.0,
          ),
        ),
        centerTitle: true,
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/background/login.png'),
            fit: BoxFit.cover,
          ),
        ),
        padding: EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildDetailItem(
                  'Date of Crisis:',
                  crisis.date
                      .toIso8601String()), // Convertit la date en chaîne ISO 8601
              _buildDetailItem(
                'Start Time:',
                '${crisis.startTime.hour}:${crisis.startTime.minute}',
              ),
              _buildDetailItem(
                'End Time:',
                '${crisis.endTime.hour}:${crisis.endTime.minute}',
              ),

              //.toIso8601String()), // Convertit la date en chaîne ISO 8601
              _buildDetailItem(
                  'Duration:',
                  crisis.duration
                      .toString()), // Convertit la durée en chaîne de caractères
              _buildDetailItem(
                  'Type of Crisis:', crisis.type.toString().split('.').last),

              _buildDetailItem('Location:', crisis.location),
              _buildDetailItem('Emergency Services Called:',
                  crisis.emergencyServicesCalled ? 'Yes' : 'No'),
              _buildDetailItem('Medical Assistance:',
                  crisis.medicalAssistance ? 'Yes' : 'No'),
              _buildDetailItem('Severity:', crisis.severity),

              SizedBox(height: 20),
              Center(
                child: TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PostCriseFormulaire(),
                      ),
                    );
                  },
                  child: Text(
                    'Crisis Form',
                    style:
                        TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDetailItem(String label, String value) {
    return Container(
      margin: EdgeInsets.only(bottom: 10.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 1,
            blurRadius: 3,
            offset: Offset(0, 2), // changes position of shadow
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 120.0, // Largeur maximale du label
            padding: EdgeInsets.all(10.0),
            child: Text(
              label,
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                color: const Color(0xFF8A4FE9),
              ),
            ),
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.all(10.0),
              child: Text(
                value,
                style: TextStyle(fontSize: 16.0),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
