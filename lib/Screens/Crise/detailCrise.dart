import 'package:epilepto_guard/Screens/Crise/postCriseFormulaire.dart';
import 'package:flutter/material.dart';
import 'package:epilepto_guard/Models/crise.dart' as CriseModel;
import 'package:intl/intl.dart'; // Importez intl pour formater la date
//import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:latlong2/latlong.dart'; // Importez latlong pour utiliser LatLng
import 'package:flutter_map/flutter_map.dart';

class CrisisDetailScreen extends StatelessWidget {
  final CriseModel.Crisis crisis;

  const CrisisDetailScreen(this.crisis);
  //LatLng(latitude, longitude)

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
                // Formatez la date au format année, mois et jour
                DateFormat.yMMMd().format(crisis.date),
              ),
              _buildDetailItem(
                'Start Time:',
                '${crisis.startTime.hour}:${crisis.startTime.minute}',
              ),
              _buildDetailItem(
                'End Time:',
                '${crisis.endTime.hour}:${crisis.endTime.minute}',
              ),
              _buildDetailItem(
                'Duration:',
                crisis.duration.toString(),
              ),
              _buildDetailItem(
                'Type of Crisis:',
                crisis.type.toString().split('.').last,
              ),
              _buildDetailItem('Location:', crisis.location),
              // Afficher la carte pour la location
              //_buildMapItem('Location:', crisis.location),
              _buildDetailItem(
                'Emergency Services Called:',
                crisis.emergencyServicesCalled ? 'Yes' : 'No',
              ),
              _buildDetailItem(
                'Medical Assistance:',
                crisis.medicalAssistance ? 'Yes' : 'No',
              ),
              _buildDetailItem(
                'Severity:',
                crisis.severity,
              ),
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

  /* Widget _buildMapItem(String label, String value) {
    // Splittez les coordonnées de la localisation (par exemple, "latitude,longitude")
    List<String> coordinates = value.split(',');
    double latitude = double.parse(coordinates[0]);
    double longitude = double.parse(coordinates[1]);

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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
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
          Container(
            height: 200, // Ajustez la hauteur de la carte selon vos besoins
            child: FlutterMap(
              options: MapOptions(
                center: LatLng(latitude,
                    longitude), // Utilisez les coordonnées de la localisation de la crise
                zoom: 10.0, // Zoom initial de la carte
              ),
              children: [
                // Ajoutez une liste vide ou les enfants de la carte
                // Vous pouvez ajouter d'autres widgets ici si nécessaire
              ],
              layers: [
                TileLayerOptions(
                  urlTemplate:
                      "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                  subdomains: ['a', 'b', 'c'],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }*/
}
