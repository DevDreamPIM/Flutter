import 'package:epilepto_guard/Models/postCriseForm.dart';
import 'package:epilepto_guard/Services/postFormService.dart';
import 'package:flutter/material.dart';

class SubmittedForm extends StatelessWidget {
  final String id;
  final PostFormService postFormService =
      PostFormService(); // Instance de votre service

  SubmittedForm({required this.id});
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: postFormService.getFormData(id),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else {
          var formData = snapshot.data as PostCriseFormData?;
          if (formData != null) {
            return Scaffold(
              appBar: AppBar(
                title: Text('Submitted Form'),
              ),
              body: Padding(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Submitted Form Data:',
                        style: TextStyle(
                            fontSize: 20.0, fontWeight: FontWeight.bold)),
                    SizedBox(height: 10.0),
                    _buildQuestionWithResponse(
                      'How long did the seizure last?',
                      TextFormField(
                        readOnly: true,
                        initialValue: '${formData.selectedHours} hours ${formData.selectedMinutes} minutes' ,
                            
                        decoration: InputDecoration(
                          
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                      ),
                    ),
                   
                  ],
                ),
              ),
            );
          } else {
            return Center(child: Text('No data available'));
          }
        }
      },
    );
  }



 // Méthode pour construire un cadre question-réponse
  Widget _buildQuestionWithResponse(String question, Widget responseWidget) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10.0),
      padding: EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            question,
            style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 10.0),
          responseWidget,
        ],
      ),
    );
  }

}
