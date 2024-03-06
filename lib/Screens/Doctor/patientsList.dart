import 'package:epilepto_guard/Models/patientsModel.dart';
import 'package:epilepto_guard/Screens/Doctor/patientDetail.dart';
import 'package:epilepto_guard/Services/doctorService.dart';
import 'package:flutter/material.dart';

import '../../Utils/Constantes.dart';

class PatientsList extends StatefulWidget {
  @override
  _PatientsListState createState() => _PatientsListState();
}

class _PatientsListState extends State<PatientsList> {
  List<PatientsModel> patientsArray = [];

  @override
  void initState() {
    super.initState();
    fetchPatients();
  }

  Future<void> fetchPatients() async {
    try {
      var patients = await doctorService().getPatients();
      setState(() {
        patientsArray = patients;
      });
    } catch (error) {
      print('Error getting patients: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Patients List',
          style: TextStyle(
            color: Colors.white,
            fontSize: 24.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: const Color(0xFFC987E1),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFFC2A3F7),
              Color(0xFFFFFFFF),
            ],
          ),
        ),
        child: ListView.builder(
          itemCount: patientsArray.length + 1,
          itemBuilder: (context, index) {
            if (index == 0) {
              return const Padding(
                padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                child: Column(
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: 65,
                        ),
                        Expanded(
                          flex: 2,
                          child: Text(
                            'Patient Name',
                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Text(
                            'Height',
                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Text(
                            'Weight',
                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            } else {
              final patient = patientsArray[index - 1];
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                child: Card(
                  elevation: 3,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  child: ListTile(
                    contentPadding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 20.0),
                    leading: CircleAvatar(
                      radius: 30.0,
                      backgroundImage: Image.network(
                        '${Constantes.USER_IMAGE_URL}/${patient.image}',
                        fit: BoxFit.cover, // You can adjust the BoxFit as needed
                      ).image,
                    ),
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.3,
                          child: Text(
                            '${patient.firstName!} ${patient.lastName!}',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20.0,
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Text(
                            patient.height?.toStringAsFixed(1) ?? "",
                            style: TextStyle(
                              fontSize: 16.0,
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Text(
                            patient.weight?.toStringAsFixed(1) ?? "",
                            style: TextStyle(
                              fontSize: 16.0,
                            ),
                          ),
                        ),
                      ],
                    ),
                    trailing: Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.grey[700],
                      size: 30.0,
                    ),
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => PatientDetail()));
                    },
                  ),
                ),
              );
            }
          },
        ),
      ),
    );
  }
}

// class Patient {
//   final String name;
//   final String profilePic;
//   final String height;
//   final String weight;
//
//   Patient({
//     required this.name,
//     required this.profilePic,
//     required this.height,
//     required this.weight,
//   });
// }
