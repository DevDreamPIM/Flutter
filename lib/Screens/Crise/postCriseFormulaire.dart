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
  late String _id;

  @override
  void initState() {
    super.initState();
    _id = widget.id;
  }

  List<bool> _triggerFactorsSelection = List.generate(11, (index) => false);
  int _selectedHours = 0;
  int _selectedMinutes = 0;
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
  bool? _regularMedication;
  bool? _injured;
  bool? _conscious;
  bool? _episodes;
  bool? _memoryDisturbances;
  bool? _assistance;
  bool? _advice;
  double _emotionalStateRating = 0;
  double _recoveryRating = 0;
  double _stressAnxietyRating = 0;
  double _medicalCareRating = 0;
  TextEditingController _signsresponseController = TextEditingController();
  TextEditingController _symptomsresponseController = TextEditingController();
  TextEditingController _addresponseController = TextEditingController();
  final PostFormService _postFormService = PostFormService();

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
        child: ListView(
          children: [
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
            _buildQuestionWithResponse(
              'Did you experience any specific symptoms after the seizure, such as headaches, nausea, or dizziness?',
              TextFormField(
                controller: _symptomsresponseController,
                maxLines: null,
                decoration: InputDecoration(
                  hintText: 'Réponse...',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
              ),
            ),
            _buildQuestionWithResponse(
              'Did you receive medical assistance or advice after the seizure?',
              Column(
                children: [
                  RadioListTile<bool>(
                    title: Text('Assistance'),
                    value: true,
                    groupValue: _assistance,
                    onChanged: (bool? value) {
                      setState(() {
                        _assistance = value;
                      });
                    },
                  ),
                  RadioListTile<bool>(
                    title: Text('Advice'),
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
            _buildQuestionWithResponse(
              'What additional measures did you take after the seizure?',
              TextFormField(
                controller: _addresponseController,
                maxLines: null,
                decoration: InputDecoration(
                  hintText: 'Réponse...',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
              ),
            ),
           ElevatedButton(
  onPressed: () {
    _postFormService.sendDataToBackend(
      PostCriseFormData(
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
        response1: _signsresponseController.text,
        response2: _symptomsresponseController.text,
        response3: _addresponseController.text,
      ),
    );
  },
              child: Text('Submit'),
            ),
  
          ],
        ),
      ),
    );
  }

  Widget _buildQuestionWithResponse(String question, Widget responseWidget) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            question,
            style: TextStyle(
              color: const Color(0xFF8A4FE9),
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 8.0),
          responseWidget,
        ],
      ),
    );
  }

  Widget _buildCheckboxQuestion(
      String title, bool value, ValueChanged<bool?> onChanged) {
    return Row(
      children: [
        Checkbox(
          value: value,
          onChanged: onChanged,
        ),
        Text(title),
      ],
    );
  }

  Future<void> _showTimePicker() async {
    Picker(
      adapter: NumberPickerAdapter(
        data: [
          NumberPickerColumn(begin: 0, end: 23),
          NumberPickerColumn(begin: 0, end: 59),
        ],
      ),
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
      title: Text('Select Time'),
      selectedTextStyle: TextStyle(color: Colors.blue),
      onConfirm: (Picker picker, List<int> value) {
        setState(() {
          _selectedHours = value[0];
          _selectedMinutes = value[1];
        });
      },
    ).showModal(context);
  }
}