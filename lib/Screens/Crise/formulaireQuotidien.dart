import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class FormulaireQuotidien extends StatefulWidget {
  const FormulaireQuotidien({Key? key}) : super(key: key);
  @override
  _FormulaireQuotidienState createState() => _FormulaireQuotidienState();
}

class _FormulaireQuotidienState extends State<FormulaireQuotidien> {
  TimeOfDay _bedTime = TimeOfDay.now(); // Pour stocker l'heure du coucher
  TimeOfDay _wakeUpTime = TimeOfDay.now(); // Pour stocker l'heure du réveil
  // rate variable
  double _stressRating = 0;
  double _alcoholDrugRating = 0;
  double _moodchangesRating = 0;
  double _sleepingRating = 0;
  double _flashingLightsRating = 0;
  double _exerciseRating = 0;
  bool _takenMedicationsAsPrescribed = false;
  String _mealSleepNoValue = '';
  //Variables a cocher pour la derniere question (13)
  bool _visualAuraChecked = false;
  bool _sensoryAuraChecked = false;
  bool _auditoryAuraChecked = false;
  bool _gustatoryOrOlfactoryAuraChecked = false;
  bool _headachesChecked = false;
  bool _excessiveFatigueChecked = false;
  bool _abnormalMoodChecked = false;
  bool _sleepDisturbancesChecked = false;
  bool _concentrationDifficultiesChecked = false;
  bool _increasedSensitivityChecked = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Your Daily Questionnaire',
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
        //******************* 1 ***************************************************
        child: ListView(
          children: [
            Container(
              padding: EdgeInsets.all(20.0),
              margin: EdgeInsets.symmetric(vertical: 10.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                border: Border.all(color: Colors.grey),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'What time did you go to bed last night?',
                    style:
                        TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                  ),
                  InkWell(
                    onTap: () {
                      _selectBedTime(context);
                    },
                    child: Container(
                      alignment: Alignment.center,
                      height: 50,
                      width: 100,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        border: Border.all(color: Colors.grey),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.access_time),
                          SizedBox(width: 10),
                          Text(
                            '${_bedTime.hour}:${_bedTime.minute}',
                            style: TextStyle(fontSize: 16),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            //************************* 2 *********************************/
            Container(
              padding: EdgeInsets.all(20.0),
              margin: EdgeInsets.symmetric(vertical: 10.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                border: Border.all(color: Colors.grey),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'When did you wake up today ?',
                    style:
                        TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                  ),
                  InkWell(
                    onTap: () {
                      _selectWakeUpTime(context);
                    },
                    child: Container(
                      alignment: Alignment.center,
                      height: 50,
                      width: 100,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        border: Border.all(color: Colors.grey),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.access_time),
                          SizedBox(width: 10),
                          Text(
                            '${_wakeUpTime.hour}:${_wakeUpTime.minute}',
                            style: TextStyle(fontSize: 16),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            //********** 3 (rate) ****************************************
            Container(
              padding: EdgeInsets.all(20.0),
              margin: EdgeInsets.symmetric(vertical: 10.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                border: Border.all(color: Colors.grey),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Were you exposed to sources of stress yesterday ?',
                    style:
                        TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                  ),
                  RatingBar.builder(
                    initialRating: 0,
                    minRating: 0,
                    direction: Axis.horizontal,
                    allowHalfRating: true,
                    itemCount: 5,
                    itemSize: 40.0,
                    itemBuilder: (context, _) => Icon(
                      Icons.star,
                      color: const Color(0xFF8A4FE9),
                    ),
                    onRatingUpdate: (rating) {
                      setState(() {
                        _stressRating = rating;
                      });
                    },
                  ),
                ],
              ),
            ),
//************ 4 ************************************************************ */
            Container(
              padding: EdgeInsets.all(20.0),
              margin: EdgeInsets.symmetric(vertical: 10.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                border: Border.all(color: Colors.grey),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Have you consumed alcohol or drugs recently ?',
                    style:
                        TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                  ),
                  RatingBar.builder(
                    initialRating: 0,
                    minRating: 0,
                    direction: Axis.horizontal,
                    allowHalfRating: true,
                    itemCount: 5,
                    itemSize: 40.0,
                    itemBuilder: (context, _) => Icon(
                      Icons.star,
                      color: const Color(0xFF8A4FE9),
                    ),
                    onRatingUpdate: (rating) {
                      setState(() {
                        _alcoholDrugRating = rating;
                      });
                    },
                  ),
                ],
              ),
            ),
//********** *********** 5 *******************************************************/
            Container(
              padding: EdgeInsets.all(20.0),
              margin: EdgeInsets.symmetric(vertical: 10.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                border: Border.all(color: Colors.grey),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Have you taken all your antiepileptic medications as prescribed ?',
                    style:
                        TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Yes',
                        style: TextStyle(fontSize: 18.0),
                      ),
                      Radio<bool>(
                        value: true,
                        groupValue: _takenMedicationsAsPrescribed,
                        onChanged: (bool? value) {
                          setState(() {
                            _takenMedicationsAsPrescribed = value!;
                          });
                        },
                        activeColor: const Color(0xFF8A4FE9),
                      ),
                      Text(
                        'No',
                        style: TextStyle(fontSize: 18.0),
                      ),
                      Radio<bool>(
                        value: false,
                        groupValue: _takenMedicationsAsPrescribed,
                        onChanged: (bool? value) {
                          setState(() {
                            _takenMedicationsAsPrescribed = value!;
                          });
                        },
                        activeColor: const Color(0xFF8A4FE9),
                      ),
                    ],
                  ),
                ],
              ),
            ),
//******************************** 6 *************************************** */
            Container(
              padding: EdgeInsets.all(20.0),
              margin: EdgeInsets.symmetric(vertical: 10.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                border: Border.all(color: Colors.grey),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Have you noticed any changes in your mood or level of anxiety recently ?',
                    style:
                        TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                  ),
                  RatingBar.builder(
                    initialRating: 0,
                    minRating: 0,
                    direction: Axis.horizontal,
                    allowHalfRating: true,
                    itemCount: 5,
                    itemSize: 40.0,
                    itemBuilder: (context, _) => Icon(
                      Icons.star,
                      color: const Color(0xFF8A4FE9),
                    ),
                    onRatingUpdate: (rating) {
                      setState(() {
                        _moodchangesRating = rating;
                      });
                    },
                  ),
                ],
              ),
            ),
//********************  7 ************************************************* */
            Container(
              padding: EdgeInsets.all(20.0),
              margin: EdgeInsets.symmetric(vertical: 10.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                border: Border.all(color: Colors.grey),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Have you experienced difficulty sleeping recently ?',
                    style:
                        TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                  ),
                  RatingBar.builder(
                    initialRating: 0,
                    minRating: 0,
                    direction: Axis.horizontal,
                    allowHalfRating: true,
                    itemCount: 5,
                    itemSize: 40.0,
                    itemBuilder: (context, _) => Icon(
                      Icons.star,
                      color: const Color(0xFF8A4FE9),
                    ),
                    onRatingUpdate: (rating) {
                      setState(() {
                        _sleepingRating = rating;
                      });
                    },
                  ),
                ],
              ),
            ),
//************************************** 8 ******************************** */
            Container(
              padding: EdgeInsets.all(20.0),
              margin: EdgeInsets.symmetric(vertical: 10.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                border: Border.all(color: Colors.grey),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Have you been exposed to flashing lights or intense visual stimulation ?',
                    style:
                        TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                  ),
                  RatingBar.builder(
                    initialRating: 0,
                    minRating: 0,
                    direction: Axis.horizontal,
                    allowHalfRating: true,
                    itemCount: 5,
                    itemSize: 40.0,
                    itemBuilder: (context, _) => Icon(
                      Icons.star,
                      color: const Color(0xFF8A4FE9),
                    ),
                    onRatingUpdate: (rating) {
                      setState(() {
                        _flashingLightsRating = rating;
                      });
                    },
                  ),
                ],
              ),
            ),
//************************** 9 ********************************************* */
            Container(
              padding: EdgeInsets.all(20.0),
              margin: EdgeInsets.symmetric(vertical: 10.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                border: Border.all(color: Colors.grey),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Have you engaged in exercise or intense physical activity recently?',
                    style:
                        TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                  ),
                  RatingBar.builder(
                    initialRating: 0,
                    minRating: 0,
                    direction: Axis.horizontal,
                    allowHalfRating: true,
                    itemCount: 5,
                    itemSize: 40.0,
                    itemBuilder: (context, _) => Icon(
                      Icons.star,
                      color: const Color(0xFF8A4FE9),
                    ),
                    onRatingUpdate: (rating) {
                      setState(() {
                        _exerciseRating = rating;
                      });
                    },
                  ),
                ],
              ),
            ),
//***********************  10 ****************************************************** */
            Container(
              padding: EdgeInsets.all(20.0),
              margin: EdgeInsets.symmetric(vertical: 10.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                border: Border.all(color: Colors.grey),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Have you missed meals or sleep periods recently ?',
                    style:
                        TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Meals',
                        style: TextStyle(fontSize: 18.0),
                      ),
                      Radio<String>(
                        value: 'Meals',
                        groupValue: _mealSleepNoValue,
                        onChanged: (String? value) {
                          setState(() {
                            _mealSleepNoValue = value!;
                          });
                        },
                        activeColor: const Color(0xFF8A4FE9),
                      ),
                      Text(
                        'Sleep',
                        style: TextStyle(fontSize: 18.0),
                      ),
                      Radio<String>(
                        value: 'Sleep',
                        groupValue: _mealSleepNoValue,
                        onChanged: (String? value) {
                          setState(() {
                            _mealSleepNoValue = value!;
                          });
                        },
                        activeColor: const Color(0xFF8A4FE9),
                      ),
                      Text(
                        'No',
                        style: TextStyle(fontSize: 18.0),
                      ),
                      Radio<String>(
                        value: 'No',
                        groupValue: _mealSleepNoValue,
                        onChanged: (String? value) {
                          setState(() {
                            _mealSleepNoValue = value!;
                          });
                        },
                        activeColor: const Color(0xFF8A4FE9),
                      ),
                    ],
                  ),
                ],
              ),
            ),
//*******************************11******************************** */
            Container(
              padding: EdgeInsets.all(20.0),
              margin: EdgeInsets.symmetric(vertical: 10.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                border: Border.all(color: Colors.grey),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Have you had any recent changes in your work or study schedule ?',
                    style:
                        TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      hintText: 'Answer...',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                  ),
                ],
              ),
            ),
//************************12****************************** */
            Container(
              padding: EdgeInsets.all(20.0),
              margin: EdgeInsets.symmetric(vertical: 10.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                border: Border.all(color: Colors.grey),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Have you experienced prodromal symptoms before previous seizures?',
                    style:
                        TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 35),
                  // Première option
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: RichText(
                          text: TextSpan(
                            style:
                                TextStyle(fontSize: 18.0, color: Colors.black),
                            children: [
                              TextSpan(
                                text: 'Visual Aura: ',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              TextSpan(
                                text:
                                    'Visual changes such as flashing lights, blind spots, or flickering.',
                              ),
                            ],
                          ),
                        ),
                      ),
                      Checkbox(
                        value: _visualAuraChecked,
                        onChanged: (bool? value) {
                          setState(() {
                            _visualAuraChecked = value!;
                          });
                        },
                        activeColor: const Color(0xFF8A4FE9),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  // Deuxième option
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: RichText(
                          text: TextSpan(
                            style:
                                TextStyle(fontSize: 18.0, color: Colors.black),
                            children: [
                              TextSpan(
                                text: 'Sensory Aura: ',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              TextSpan(
                                text:
                                    'Unusual sensations such as tingling, numbness, or burning sensations in certain parts of the body.',
                              ),
                            ],
                          ),
                        ),
                      ),
                      Checkbox(
                        value: _sensoryAuraChecked,
                        onChanged: (bool? value) {
                          setState(() {
                            _sensoryAuraChecked = value!;
                          });
                        },
                        activeColor: const Color(0xFF8A4FE9),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  // Troisième option
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: RichText(
                          text: TextSpan(
                            style:
                                TextStyle(fontSize: 18.0, color: Colors.black),
                            children: [
                              TextSpan(
                                text: 'Auditory Aura: ',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              TextSpan(
                                text:
                                    'Unusual sounds such as buzzing, ringing, or auditory hallucinations.',
                              ),
                            ],
                          ),
                        ),
                      ),
                      Checkbox(
                        value: _auditoryAuraChecked,
                        onChanged: (bool? value) {
                          setState(() {
                            _auditoryAuraChecked = value!;
                          });
                        },
                        activeColor: const Color(0xFF8A4FE9),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  // Quatrième option
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: RichText(
                          text: TextSpan(
                            style:
                                TextStyle(fontSize: 18.0, color: Colors.black),
                            children: [
                              TextSpan(
                                text: 'Gustatory or Olfactory Aura: ',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              TextSpan(
                                text:
                                    'Abnormal or unpleasant tastes or smells that are not present in the environment.',
                              ),
                            ],
                          ),
                        ),
                      ),
                      Checkbox(
                        value: _gustatoryOrOlfactoryAuraChecked,
                        onChanged: (bool? value) {
                          setState(() {
                            _gustatoryOrOlfactoryAuraChecked = value!;
                          });
                        },
                        activeColor: const Color(0xFF8A4FE9),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  // Cinquième option
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: RichText(
                          text: TextSpan(
                            style:
                                TextStyle(fontSize: 18.0, color: Colors.black),
                            children: [
                              TextSpan(
                                text: 'Headaches: ',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              TextSpan(
                                text:
                                    'Headaches often described as severe or throbbing.',
                              ),
                            ],
                          ),
                        ),
                      ),
                      Checkbox(
                        value: _headachesChecked,
                        onChanged: (bool? value) {
                          setState(() {
                            _headachesChecked = value!;
                          });
                        },
                        activeColor: const Color(0xFF8A4FE9),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  // Sixième option
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: RichText(
                          text: TextSpan(
                            style:
                                TextStyle(fontSize: 18.0, color: Colors.black),
                            children: [
                              TextSpan(
                                text: 'Excessive Fatigue: ',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              TextSpan(
                                text:
                                    'Feelings of extreme fatigue or unusual exhaustion.',
                              ),
                            ],
                          ),
                        ),
                      ),
                      Checkbox(
                        value: _excessiveFatigueChecked,
                        onChanged: (bool? value) {
                          setState(() {
                            _excessiveFatigueChecked = value!;
                          });
                        },
                        activeColor: const Color(0xFF8A4FE9),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  // Septième option
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: RichText(
                          text: TextSpan(
                            style:
                                TextStyle(fontSize: 18.0, color: Colors.black),
                            children: [
                              TextSpan(
                                text: 'Abnormal Mood: ',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              TextSpan(
                                text:
                                    'Mood changes such as anxiety, depression, or irritability.',
                              ),
                            ],
                          ),
                        ),
                      ),
                      Checkbox(
                        value: _abnormalMoodChecked,
                        onChanged: (bool? value) {
                          setState(() {
                            _abnormalMoodChecked = value!;
                          });
                        },
                        activeColor: const Color(0xFF8A4FE9),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  // Huitième option
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: RichText(
                          text: TextSpan(
                            style:
                                TextStyle(fontSize: 18.0, color: Colors.black),
                            children: [
                              TextSpan(
                                text: 'Sleep Disturbances: ',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              TextSpan(
                                text:
                                    'Difficulty falling asleep, restless sleep, or insomnia.',
                              ),
                            ],
                          ),
                        ),
                      ),
                      Checkbox(
                        value: _sleepDisturbancesChecked,
                        onChanged: (bool? value) {
                          setState(() {
                            _sleepDisturbancesChecked = value!;
                          });
                        },
                        activeColor: const Color(0xFF8A4FE9),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  // Neuvième option
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: RichText(
                          text: TextSpan(
                            style:
                                TextStyle(fontSize: 18.0, color: Colors.black),
                            children: [
                              TextSpan(
                                text: 'Concentration Difficulties: ',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              TextSpan(
                                text:
                                    'Problems with concentration or memory, feeling of confusion or disorientation.',
                              ),
                            ],
                          ),
                        ),
                      ),
                      Checkbox(
                        value: _concentrationDifficultiesChecked,
                        onChanged: (bool? value) {
                          setState(() {
                            _concentrationDifficultiesChecked = value!;
                          });
                        },
                        activeColor: const Color(0xFF8A4FE9),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  // Dixième option
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: RichText(
                          text: TextSpan(
                            style:
                                TextStyle(fontSize: 18.0, color: Colors.black),
                            children: [
                              TextSpan(
                                text: 'Increased Sensitivity: ',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              TextSpan(
                                text:
                                    'Excessive sensitivity to light, sound, or sensory stimuli.',
                              ),
                            ],
                          ),
                        ),
                      ),
                      Checkbox(
                        value: _increasedSensitivityChecked,
                        onChanged: (bool? value) {
                          setState(() {
                            _increasedSensitivityChecked = value!;
                          });
                        },
                        activeColor: const Color(0xFF8A4FE9),
                      ),
                    ],
                  ),
                ],
              ),
            ),
//************************************************************************************ */
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                // Ajouter la logique pour enregistrer les réponses ici
                print(
                    'Took medications as prescribed: $_takenMedicationsAsPrescribed');
              },
              style: ElevatedButton.styleFrom(
                backgroundColor:
                    const Color(0xFF8A4FE9), // Définir la couleur de fond ici
                padding: EdgeInsets.symmetric(
                    vertical: 16.0), // Ajuster la hauteur du bouton ici
              ),
              child: Text(
                'Save Form',
                style: TextStyle(
                  color: Colors.white, // Définir la couleur du texte en blanc
                  fontSize: 18.0, // Ajuster la taille du texte ici
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Méthode pour sélectionner l'heure avec le widget TimePicker
  Future<void> _selectBedTime(BuildContext context) async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: _bedTime,
    );
    if (pickedTime != null && pickedTime != _bedTime) {
      setState(() {
        _bedTime = pickedTime;
      });
    }
  }

  Future<void> _selectWakeUpTime(BuildContext context) async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: _wakeUpTime,
    );
    if (pickedTime != null && pickedTime != _wakeUpTime) {
      setState(() {
        _wakeUpTime = pickedTime;
      });
    }
  }
}
