import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../Models/UserModel.dart';
import '../../Services/adminService.dart';
import 'package:epilepto_guard/Models/UserModel.dart';
import '../../Models/feedbacksModel.dart';

class UserDetail extends StatefulWidget {
  final UserModel user;
  const UserDetail({Key? key, required this.user});

  @override
  State<UserDetail> createState() => _UserDetailState();
}

class _UserDetailState extends State<UserDetail> {
  List<FeedbacksModel> feedbacksArray = [];
  String selectedRole = '';

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    try {
      var feedbacks = await AdminService().getFeedback(widget.user.id);
     
      setState(() {

        feedbacksArray = feedbacks;
        selectedRole= widget.user.role ?? '';
        print(feedbacks);
      });
    } catch (error) {
      print('Error getting users: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'User Details',
          style: TextStyle(
            color: Colors.white,
            fontSize: 24.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: const Color(0xFF3B3DE5),
      ),
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Color(0xFF6B6CE3), Color(0xFFFFFFFF)],
              ),
            ),
            width: double.infinity,
            height: double.infinity,
          ),
          Positioned(
            top: 0,
            left: 0,
            child: Container(
              width: MediaQuery.of(context).size.width * .3,
              height: MediaQuery.of(context).size.height * .3,
              child: Opacity(
                opacity: 0.5,
                child: Image.asset(
                  "assets/images/background/drug.png",
                ),
              ),
            ),
          ),
          Positioned(
            top: 150,
            right: 0,
            child: Container(
              width: MediaQuery.of(context).size.width * .3,
              height: MediaQuery.of(context).size.height * .3,
              child: Opacity(
                opacity: 0.5,
                child: Image.asset(
                  "assets/images/background/drug.png",
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            right: 250,
            child: Container(
              width: MediaQuery.of(context).size.width * .3,
              height: MediaQuery.of(context).size.height * .3,
              child: Opacity(
                opacity: 0.5,
                child: Image.asset(
                  "assets/images/background/drug.png",
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Name: ${widget.user.firstName} ${widget.user.lastName}',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  'Email: ${widget.user.email ?? ''}',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0,
                  ),
                ),
                ElevatedButton(onPressed:() async {
                   
       String? selectedRole = await _showSelectionPopup(context, widget.user.role ?? 'patient');
    if (selectedRole != null) {
      // Handle the selected role here, e.g., make API call to update user role
      print('Selected role: $selectedRole');
    }
  
   
                  
                },
                style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(
                                  0xFF8A4FE9), // Set background color here
                            ),
                child: 
                  Text('Modify Role')
                ),

                if (widget.user.role == 'doctor') ...[
                  const SizedBox(height: 20),
                  Text(
                    'Doctor Feedback',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20.0,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Expanded(
                    child: ListView.builder(
                      itemCount: feedbacksArray.length,
                      itemBuilder: (context, index) {
                        final feedback = feedbacksArray[index];
                        return ListTile(
                          title: Text(
                            '${feedback}',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          // subtitle: Text('${feedback.description}'),
                        );
                      },
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

Future<String?> _showSelectionPopup(BuildContext context, String selectedRole ) async {
  return await showModalBottomSheet<String>(
    context: context,
    builder: (BuildContext context) {
      return Container(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              title: Text('Select Role'),
              trailing: DropdownButton<String>(
                value: selectedRole,
                onChanged: (newValue) {
                  setState(() {
                    selectedRole = newValue!;
                  });
                },
                items: <String>['patient', 'doctor', 'admin']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
            ),
            ButtonBar(
              alignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () async{
                    // Handle confirm button action
                     final storage = FlutterSecureStorage();

    String? token = await storage.read(key: "token");
                    AdminService().updateUserRoleAndNotify(widget.user.id!, selectedRole, token!,context);
                    Navigator.of(context).pop(selectedRole);
                    
                     // Return selected role
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green, // Confirm button color
                  ),
                  child: Text('Confirm'),
                ),
                ElevatedButton(
                  onPressed: () {
                    // Handle cancel button action
                    Navigator.of(context).pop(); // Close the bottom sheet without returning anything
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red, // Cancel button color
                  ),
                  child: Text('Cancel'),
                ),
              ],
            ),
          ],
        ),
      );
    },
  );
}


}
