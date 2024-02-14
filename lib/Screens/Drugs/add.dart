import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AddMedicineScreen extends StatefulWidget {
  const AddMedicineScreen({Key? key}) : super(key: key);

  @override
  _AddMedicineScreenState createState() => _AddMedicineScreenState();
}

class _AddMedicineScreenState extends State<AddMedicineScreen> {
  DateTime? _selectedDate;
  TimeOfDay? _selectedTime;

  Future<void> _selectDate() async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime(2022),
      lastDate: DateTime(2030),
    );

    if (pickedDate != null) {
      setState(() {
        _selectedDate = pickedDate;
      });
    }
  }

  Future<void> _selectTime() async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: _selectedTime ?? TimeOfDay.now(),
    );

    if (pickedTime != null) {
      setState(() {
        _selectedTime = pickedTime;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    String dateText = _selectedDate != null
        ? DateFormat('dd/MM/yyyy').format(_selectedDate!)
        : 'Date';
    String timeText =
        _selectedTime != null ? _selectedTime!.format(context) : 'Time';

    return Scaffold(
        appBar: AppBar(
          title: Text('Add Drug'),
        ),
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("images/background/login.png"),
              fit: BoxFit.cover,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ElevatedButton.icon(
                  onPressed: () {
                    // Add image upload functionality
                  },
                  icon: Icon(Icons.upload),
                  label: Text('Upload Image'),
                ),
                SizedBox(height: 20),
                AnimatedTextField(
                  hintText: 'Title',
                ),
                SizedBox(height: 20),
                AnimatedTextField(
                  hintText: 'Description',
                ),
                SizedBox(height: 20),
                AnimatedTextField(
                  hintText: 'Dose',
                ),
                SizedBox(height: 20),
                TextButton(
                  onPressed: _selectTime,
                  child: Text(
                    timeText,
                    style: TextStyle(color: Colors.black),
                  ),
                ),
                SizedBox(height: 20),
                TextButton(
                  onPressed: _selectDate,
                  child: Text(
                    dateText,
                    style: TextStyle(color: Colors.black),
                  ),
                ),
                SizedBox(height: 20),
                AnimatedDropdownFormField(
                  hintText: 'Frequency of intake',
                  items: ['Daily', 'Weekly', 'Monthly'],
                  onChanged: (String? newValue) {
                    // Handle frequency selection
                  },
                ),
                Expanded(
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          // Add login functionality
                        },
                        style: ElevatedButton.styleFrom(
                          primary: const Color(0xFF8A4FE9),
                        ),
                        child: Padding(
                          padding: EdgeInsets.symmetric(vertical: 16.0),
                          child: Text('Add',
                              style: TextStyle(
                                  fontSize: 18.0, color: Colors.white)),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}

class AnimatedTextField extends StatefulWidget {
  final String hintText;

  const AnimatedTextField({Key? key, required this.hintText}) : super(key: key);

  @override
  _AnimatedTextFieldState createState() => _AnimatedTextFieldState();
}

class _AnimatedTextFieldState extends State<AnimatedTextField> {
  bool _isFocused = false;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 300),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50.0),
        color: _isFocused ? Colors.white : Colors.white.withOpacity(0.7),
      ),
      child: TextField(
        decoration: InputDecoration(
          hintText: widget.hintText,
          border: InputBorder.none,
          contentPadding:
              EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
        ),
        style: TextStyle(color: Colors.black),
        cursorColor: Colors.black,
        onTap: () {
          setState(() {
            _isFocused = true;
          });
        },
        onChanged: (value) {
          if (value.isEmpty) {
            setState(() {
              _isFocused = false;
            });
          }
        },
        onSubmitted: (value) {
          setState(() {
            _isFocused = false;
          });
        },
      ),
    );
  }
}

class AnimatedDropdownFormField extends StatefulWidget {
  final String hintText;
  final List<String> items;
  final ValueChanged<String?> onChanged;

  const AnimatedDropdownFormField({
    Key? key,
    required this.hintText,
    required this.items,
    required this.onChanged,
  }) : super(key: key);

  @override
  _AnimatedDropdownFormFieldState createState() =>
      _AnimatedDropdownFormFieldState();
}

class _AnimatedDropdownFormFieldState extends State<AnimatedDropdownFormField> {
  String? _selectedItem;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 300),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50.0),
        color: _selectedItem != null
            ? Colors.white
            : Colors.white.withOpacity(0.7),
      ),
      child: DropdownButtonFormField<String>(
        decoration: InputDecoration(
          hintText: widget.hintText,
          border: InputBorder.none,
          contentPadding:
              EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
        ),
        value: _selectedItem,
        items: widget.items.map((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
        onChanged: (String? newValue) {
          setState(() {
            _selectedItem = newValue;
          });
          widget.onChanged(newValue);
        },
      ),
    );
  }
}
