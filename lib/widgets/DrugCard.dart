import 'package:flutter/material.dart';
import 'package:epilepto_guard/models/drug.dart';
import 'package:epilepto_guard/Screens/Drugs/detail.dart'; // Importez la vue de détail

class DrugCard extends StatelessWidget {
  final Drug drug;

  DrugCard({required this.drug});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Navigation vers la vue de détail lorsqu'on appuie sur la carte
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => DetailDrug(drug: drug)),
        );
      },
      child: Container(
        width: 200, 
        child: Card(
          margin: EdgeInsets.all(8.0),
          elevation: 5,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          child: Stack(
            children: [
              Container(
                height: 200,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  image: DecorationImage(
                    image: AssetImage('/images/background/parkizol.png'), // Image de fond
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Container(
                height: 200,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.black.withOpacity(0.3),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      'Name : ${drug.title}', // Affichage du titre avec "Titre :"
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Frequency : ${drug.frequencyOfIntake}', // Affichage de la fréquence avec "Fréquence :"
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
