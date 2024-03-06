import 'package:epilepto_guard/Models/postCriseForm.dart';
import 'package:epilepto_guard/Services/postFormService.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_picker/flutter_picker.dart';
import 'package:http/http.dart' as http;

class PostCriseFormulaire extends StatefulWidget {
  final String id;
  const PostCriseFormulaire({Key? key, required this.id}) : super(key: key);

  @override
  _PostCriseFormulaireState createState() => _PostCriseFormulaireState();
}

class _PostCriseFormulaireState extends State<PostCriseFormulaire> {
  //** VARIABLES **//

  late String _id;

  @override
  void initState() {
    super.initState();
    _id = widget.id;
  }

  List<bool> _triggerFactorsSelection = List.generate(11, (index) => false);

  // Variables pour stocker les heures et les minutes sélectionnées
  int _selectedHours = 0;
  int _selectedMinutes = 0;

  //  option de réponse pour les auras
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

  //boolean variable medication
  bool? _regularMedication;

  //boolean variable injured
  bool? _injured;

  //boolean variable conscious
  bool? _conscious;

  //boolean variable episodes
  bool? _episodes;

  //boolean variable memoryDisturbances
  bool? _memoryDisturbances;

  //boolean variable assistance
  bool? _assistance;

  //boolean variable advice
  bool? _advice;

  // rate variable
  double _emotionalStateRating = 0;
  double _recoveryRating = 0;
  double _stressAnxietyRating = 0;
  double _medicalCareRating = 0;

//text field area
  TextEditingController _signsresponseController = TextEditingController();
  TextEditingController _symptomsresponseController = TextEditingController();
  TextEditingController _addresponseController = TextEditingController();

// Déclarez une instance du service PostFormService
  final PostFormService _postFormService = PostFormService();

//*********************************************************** */
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Post Seizure Form',
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

        //********************FORM************************* */
        child: ListView(
          children: [
            //*******************************1******************** */

            _buildQuestionWithResponse(
              'How long did the seizure last?',
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      readOnly: true,
                      controller: TextEditingController(
                          text:
                              '$_selectedHours hours $_selectedMinutes minutes'),
                      onTap: () {
                        _showTimePicker();
                      },
                      decoration: InputDecoration(
                        hintText: 'Réponse...',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            //***********************2************************************** */
            _buildQuestionWithResponse(
              'When did you first feel the initial signs of the seizure?',
              TextFormField(
                controller: _signsresponseController,
                decoration: InputDecoration(
                  hintText: 'Réponse...',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                /*  // Définissez une fonction de rappel pour mettre à jour la valeur de réponse 1
                onChanged: (value) {
                 
                },*/
              ),
            ),
            //*************3*********************************** */
            _buildQuestionWithResponse(
              'Did you experience an aura before the seizure?',
              Column(
                children: [
                  _buildCheckboxQuestion(
                    'Visual Aura',
                    _visualAuraChecked,
                    (value) {
                      setState(() {
                        _visualAuraChecked = value!;
                      });
                    },
                  ),
                  _buildCheckboxQuestion(
                    'Sensory Aura',
                    _sensoryAuraChecked,
                    (value) {
                      setState(() {
                        _sensoryAuraChecked = value!;
                      });
                    },
                  ),
                  _buildCheckboxQuestion(
                    'Auditory Aura',
                    _auditoryAuraChecked,
                    (value) {
                      setState(() {
                        _auditoryAuraChecked = value!;
                      });
                    },
                  ),
                  _buildCheckboxQuestion(
                    'Gustatory or Olfactory Aura',
                    _gustatoryOrOlfactoryAuraChecked,
                    (value) {
                      setState(() {
                        _gustatoryOrOlfactoryAuraChecked = value!;
                      });
                    },
                  ),
                  _buildCheckboxQuestion(
                    'Headaches',
                    _headachesChecked,
                    (value) {
                      setState(() {
                        _headachesChecked = value!;
                      });
                    },
                  ),
                  _buildCheckboxQuestion(
                    'Excessive Fatigue',
                    _excessiveFatigueChecked,
                    (value) {
                      setState(() {
                        _excessiveFatigueChecked = value!;
                      });
                    },
                  ),
                  _buildCheckboxQuestion(
                    'Abnormal Mood',
                    _abnormalMoodChecked,
                    (value) {
                      setState(() {
                        _abnormalMoodChecked = value!;
                      });
                    },
                  ),
                  _buildCheckboxQuestion(
                    'Sleep Disturbances',
                    _sleepDisturbancesChecked,
                    (value) {
                      setState(() {
                        _sleepDisturbancesChecked = value!;
                      });
                    },
                  ),
                  _buildCheckboxQuestion(
                    'Concentration Difficulties',
                    _concentrationDifficultiesChecked,
                    (value) {
                      setState(() {
                        _concentrationDifficultiesChecked = value!;
                      });
                    },
                  ),
                  _buildCheckboxQuestion(
                    'Increased Sensitivity',
                    _increasedSensitivityChecked,
                    (value) {
                      setState(() {
                        _increasedSensitivityChecked = value!;
                      });
                    },
                  ),
                ],
              ),
            ),
            //****************4********************************************* */
            _buildQuestionWithResponse(
              'Are identifiable triggering factors present ?',
              Column(
                children: [
                  _buildCheckboxQuestion(
                    'Emotional or psychological stress, such as anxiety or fear, or physical stress',
                    _triggerFactorsSelection[0],
                    (value) {
                      setState(() {
                        _triggerFactorsSelection[0] = value!;
                      });
                    },
                  ),
                  _buildCheckboxQuestion(
                    'Lack of sleep or sleep disruption',
                    _triggerFactorsSelection[1],
                    (value) {
                      setState(() {
                        _triggerFactorsSelection[1] = value!;
                      });
                    },
                  ),
                  _buildCheckboxQuestion(
                    'Excessive alcohol or drug consumption',
                    _triggerFactorsSelection[2],
                    (value) {
                      setState(() {
                        _triggerFactorsSelection[2] = value!;
                      });
                    },
                  ),
                  _buildCheckboxQuestion(
                    'Bright flashes or stroboscopic lights',
                    _triggerFactorsSelection[3],
                    (value) {
                      setState(() {
                        _triggerFactorsSelection[3] = value!;
                      });
                    },
                  ),
                  _buildCheckboxQuestion(
                    'Omission or interruption of anticonvulsant medication',
                    _triggerFactorsSelection[4],
                    (value) {
                      setState(() {
                        _triggerFactorsSelection[4] = value!;
                      });
                    },
                  ),
                  _buildCheckboxQuestion(
                    'Hormones',
                    _triggerFactorsSelection[5],
                    (value) {
                      setState(() {
                        _triggerFactorsSelection[5] = value!;
                      });
                    },
                  ),
                  _buildCheckboxQuestion(
                    'Extreme fatigue or lack of rest',
                    _triggerFactorsSelection[6],
                    (value) {
                      setState(() {
                        _triggerFactorsSelection[6] = value!;
                      });
                    },
                  ),
                  _buildCheckboxQuestion(
                    'Consumption of certain foods or drinks (caffeine, aspartame, certain food additives)',
                    _triggerFactorsSelection[7],
                    (value) {
                      setState(() {
                        _triggerFactorsSelection[7] = value!;
                      });
                    },
                  ),
                  _buildCheckboxQuestion(
                    'Changes in body temperature',
                    _triggerFactorsSelection[8],
                    (value) {
                      setState(() {
                        _triggerFactorsSelection[8] = value!;
                      });
                    },
                  ),
                  _buildCheckboxQuestion(
                    'Certain physical activities or specific sports',
                    _triggerFactorsSelection[9],
                    (value) {
                      setState(() {
                        _triggerFactorsSelection[9] = value!;
                      });
                    },
                  ),
                  _buildCheckboxQuestion(
                    'Illness',
                    _triggerFactorsSelection[10],
                    (value) {
                      setState(() {
                        _triggerFactorsSelection[10] = value!;
                      });
                    },
                  ),
                ],
              ),
            ),

//********************************************************** */

            _buildQuestionWithResponse(
              'Were you injured during the seizure?',
              Column(
                children: [
                  RadioListTile<bool>(
                    title: Text('Yes'),
                    value: true,
                    groupValue: _injured,
                    onChanged: (bool? value) {
                      setState(() {
                        _injured = value;
                      });
                    },
                  ),
                  RadioListTile<bool>(
                    title: Text('No'),
                    value: false,
                    groupValue: _injured,
                    onChanged: (bool? value) {
                      setState(() {
                        _injured = value;
                      });
                    },
                  ),
                ],
              ),
            ),

            //**************************************************************
            _buildQuestionWithResponse(
              'Did you notice any changes in your emotional state after the seizure?',
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
                    _emotionalStateRating = rating;
                  });
                },
              ),
            ),
            //************************************************* */
            _buildQuestionWithResponse(
              'How would you describe the post-seizure recovery in terms of fatigue and the time required to regain normal capabilities?',
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
                    _recoveryRating = rating;
                  });
                },
              ),
            ),
//****************************************************************************** */
            _buildQuestionWithResponse(
              'Are you regular in your medication intake?',
              Column(
                children: [
                  RadioListTile<bool>(
                    title: Text('Yes'),
                    value: true,
                    groupValue: _regularMedication,
                    onChanged: (bool? value) {
                      setState(() {
                        _regularMedication = value;
                      });
                    },
                  ),
                  RadioListTile<bool>(
                    title: Text('No'),
                    value: false,
                    groupValue: _regularMedication,
                    onChanged: (bool? value) {
                      setState(() {
                        _regularMedication = value;
                      });
                    },
                  ),
                ],
              ),
            ),
//****************************************************************************** */

            _buildQuestionWithResponse(
              'Were you conscious during the seizure, or did you lose consciousness?',
              Column(
                children: [
                  RadioListTile<bool>(
                    title: Text('Conscious'),
                    value: true,
                    groupValue: _conscious,
                    onChanged: (bool? value) {
                      setState(() {
                        _conscious = value;
                      });
                    },
                  ),
                  RadioListTile<bool>(
                    title: Text('unconscious'),
                    value: false,
                    groupValue: _conscious,
                    onChanged: (bool? value) {
                      setState(() {
                        _conscious = value;
                      });
                    },
                  ),
                ],
              ),
            ),

            //*********************************************** */
            _buildQuestionWithResponse(
              'Did the seizure involve repeated episodes without fully regaining consciousness in between?',
              Column(
                children: [
                  RadioListTile<bool>(
                    title: Text('Yes'),
                    value: true,
                    groupValue: _episodes,
                    onChanged: (bool? value) {
                      setState(() {
                        _episodes = value;
                      });
                    },
                  ),
                  RadioListTile<bool>(
                    title: Text('No'),
                    value: false,
                    groupValue: _episodes,
                    onChanged: (bool? value) {
                      setState(() {
                        _episodes = value;
                      });
                    },
                  ),
                ],
              ),
            ),

            //*********************************************** */

            _buildQuestionWithResponse(
              'Did you experience any memory disturbances after the seizure?',
              Column(
                children: [
                  RadioListTile<bool>(
                    title: Text('Yes'),
                    value: true,
                    groupValue: _memoryDisturbances,
                    onChanged: (bool? value) {
                      setState(() {
                        _memoryDisturbances = value;
                      });
                    },
                  ),
                  RadioListTile<bool>(
                    title: Text('No'),
                    value: false,
                    groupValue: _memoryDisturbances,
                    onChanged: (bool? value) {
                      setState(() {
                        _memoryDisturbances = value;
                      });
                    },
                  ),
                ],
              ),
            ),
            //*********************************************** */
            _buildQuestionWithResponse(
              'How would you assess your level of stress or anxiety before and after the seizure?',
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
                    _stressAnxietyRating = rating;
                  });
                },
              ),
            ),
//*********************************************** */
            _buildQuestionWithResponse(
              'Did you experience any specific symptoms after the seizure, such as headaches, nausea, or dizziness?',
              TextFormField(
                controller: _symptomsresponseController,
                maxLines: null, // Allow user to input multiple lines
                decoration: InputDecoration(
                  hintText: 'Your response...',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
              ),
            ),
            //***************************************************** */

            _buildQuestionWithResponse(
              'Did you require medical assistance or emergency intervention?',
              Column(
                children: [
                  RadioListTile<bool>(
                    title: Text('Yes'),
                    value: true,
                    groupValue: _assistance,
                    onChanged: (bool? value) {
                      setState(() {
                        _assistance = value;
                      });
                    },
                  ),
                  RadioListTile<bool>(
                    title: Text('No'),
                    value: false,
                    groupValue: _assistance,
                    onChanged: (bool? value) {
                      setState(() {
                        _assistance = value;
                      });
                    },
                  ),
                ],
              ),
            ),

            //************************************************* */
            _buildQuestionWithResponse(
              'How do you assess the medical care or assistance you received during the seizure?',
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
                    _medicalCareRating = rating;
                  });
                },
              ),
            ),

            //*************************************************

            _buildQuestionWithResponse(
              'Do you want additional advice on managing your epilepsy?',
              Column(
                children: [
                  RadioListTile<bool>(
                    title: Text('Yes'),
                    value: true,
                    groupValue: _advice,
                    onChanged: (bool? value) {
                      setState(() {
                        _advice = value;
                      });
                    },
                  ),
                  RadioListTile<bool>(
                    title: Text('No'),
                    value: false,
                    groupValue: _advice,
                    onChanged: (bool? value) {
                      setState(() {
                        _advice = value;
                      });
                    },
                  ),
                ],
              ),
            ),

            //***************************************************** */
            _buildQuestionWithResponse(
              'Do you have anything to add?',
              TextFormField(
                controller: _addresponseController,
                maxLines: null, // Allow user to input multiple lines
                decoration: InputDecoration(
                  hintText: 'Your response...',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
              ),
            ),
            //*****************************************************

            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: _saveForm,
              style: ElevatedButton.styleFrom(
                backgroundColor:
                    const Color(0xFF8A4FE9), // Set background color here
                padding: EdgeInsets.symmetric(
                    vertical: 16.0), // Adjust button height here
              ),
              child: Text(
                'Submit Form',
                style: TextStyle(
                  color: Colors.white, // Set text color to white
                  fontSize: 18.0, // Adjust text size here
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

// fonction pour gérer l'action lorsque le bouton "Save" est pressé
  void _saveForm() {
    // Récupérer les valeurs des champs texte
    String response1 = _signsresponseController.text;
    String response2 = _symptomsresponseController.text;
    String response3 = _addresponseController.text;

    // Créer une instance de PostCriseFormData
    PostCriseFormData formData = PostCriseFormData(
      idCrise: _id,
      selectedHours: _selectedHours,
      selectedMinutes: _selectedMinutes,
      visualAuraChecked: _visualAuraChecked,
      sensoryAuraChecked: _sensoryAuraChecked,
      auditoryAuraChecked: _auditoryAuraChecked,
      gustatoryOrOlfactoryAuraChecked: _gustatoryOrOlfactoryAuraChecked,
      headachesChecked: _headachesChecked,
      excessiveFatigueChecked: _excessiveFatigueChecked,
      abnormalMoodChecked: _abnormalMoodChecked,
      sleepDisturbancesChecked: _sleepDisturbancesChecked,
      concentrationDifficultiesChecked: _concentrationDifficultiesChecked,
      increasedSensitivityChecked: _increasedSensitivityChecked,
      triggerFactorsSelection: _triggerFactorsSelection,
      injured: _injured,
      conscious: _conscious,
      episodes: _episodes,
      memoryDisturbances: _memoryDisturbances,
      assistance: _assistance,
      advice: _advice,
      emotionalStateRating: _emotionalStateRating,
      recoveryRating: _recoveryRating,
      stressAnxietyRating: _stressAnxietyRating,
      medicalCareRating: _medicalCareRating,
      response1: response1,
      response2: response2,
      response3: response3,
    );

    // Envoyer les données au backend
    _postFormService.sendDataToBackend(formData);
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

  // Méthode pour afficher le sélecteur de temps
  void _showTimePicker() {
    Picker(
      adapter: NumberPickerAdapter(data: [
        NumberPickerColumn(begin: 0, end: 23, suffix: Text(' hours')),
        NumberPickerColumn(begin: 0, end: 59, suffix: Text(' minutes')),
      ]),
      delimiter: [
        PickerDelimiter(
          child: Container(
            width: 30.0,
            alignment: Alignment.center,
            child: Text(':'),
          ),
        ),
      ],
      hideHeader: true,
      confirmText: 'OK',
      cancelText: 'Cancel',
      onConfirm: (Picker picker, List<int> value) {
        setState(() {
          _selectedHours = value[0];
          _selectedMinutes = value[1];
        });
      },
    ).showDialog(context);
  }

  // Méthode pour construire une question avec cases à cocher
  Widget _buildCheckboxQuestion(
      String question, bool value, Function(bool?) onChanged) {
    return CheckboxListTile(
      title: Text(
        question,
        style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
      ),
      value: value,
      onChanged: onChanged,
      controlAffinity: ListTileControlAffinity.leading,
      activeColor: const Color(0xFF8A4FE9),
    );
  }
}
