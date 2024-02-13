import 'package:flutter/material.dart';
import 'package:epilepto_guard/models/drug.dart'; 
import 'package:epilepto_guard/widgets/DrugCard.dart'; 
import 'package:epilepto_guard/Screens/Drugs/add.dart';

class ListDrug extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<Drug> drugs = [
      Drug(
        title: 'Aspirin',
        frequencyOfIntake: 'Twice a day',
      ),
      Drug(
        title: 'Paracetamol',
        frequencyOfIntake: 'Every 4 hours',
      ),
      Drug(
        title: 'Amoxicillin',
        frequencyOfIntake: 'Once a day',
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text('Liste de médicaments'),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("images/background/login.png"), // Assurez-vous que le chemin est correct
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: drugs.length,
                itemBuilder: (context, index) {
                  return DrugCard(drug: drugs[index]);
                },
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => AddMedicineScreen()),
                        );
              },
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 16.0),
                child: Text(
                  'Add Drug',
                  style: TextStyle(fontSize: 18.0, color: Colors.white),
                ),
              ),
              style: ElevatedButton.styleFrom(
                primary: const Color(0xFF8A4FE9),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
