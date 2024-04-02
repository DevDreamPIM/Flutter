import 'dart:convert';

import 'package:epilepto_guard/Screens/Admin/userDetail.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../Models/UserModel.dart';
import '../../Services/adminService.dart';

class UserList extends StatefulWidget {
  const UserList({Key? key}) : super(key: key);

  @override
  State<UserList> createState() => _UserListState();
}

class _UserListState extends State<UserList> {
  List<UserModel> usersArray = [];
  bool showPatients = false;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    try {
      var users = await AdminService().getUsers();
      setState(() {
        usersArray = users;
      });
    } catch (error) {
      print('Error getting users: $error');
    }
  }

  List<UserModel> getPatients() {
    return usersArray.where((user) => user.role == 'patient').toList();
  }

  List<UserModel> getDoctors() {
    return usersArray.where((user) => user.role == 'doctor').toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Users List',
          style: TextStyle(
            color: Colors.white,
            fontSize: 24.0,
            fontWeight: FontWeight.bold,
          ),
        ),
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
          Positioned(
            top: 20,
            left: 20,
            child: Row(
              children: [
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      showPatients = true;
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    primary: !showPatients ? Colors.white : Colors.lightBlue,
                  ),
                  child: const Text(
                    'Patients',
                    style: TextStyle(color: Colors.black),
                  ),
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      showPatients = false;
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    primary: showPatients ? Colors.white : Colors.lightBlue,
                  ),
                  child: const Text(
                    'Doctors',
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ],
            ),
          ),
          Positioned.fill(
            top: 100,
            child: ListView.builder(
              itemCount:
                  showPatients ? getPatients().length : getDoctors().length,
              itemBuilder: (context, index) {
                final user =
                    showPatients ? getPatients()[index] : getDoctors()[index];
                return Card(
                  elevation: 3,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  child: ListTile(
                    title: Text(
                      '${user.firstName} ${user.lastName}',
                      style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 18.0),
                    ),
                    subtitle: Text(user.email ?? ''),
                    trailing: Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.grey[700],
                      size: 30.0,
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => UserDetail(user: user)),
                      );
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
