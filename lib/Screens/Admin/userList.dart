import 'dart:convert';

import 'package:epilepto_guard/Screens/Admin/userDetail.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
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
  bool isLoading = true; // Added a isLoading flag

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    try {
      final storage = FlutterSecureStorage();

      String? token = await storage.read(key: "token");
      var users = await AdminService().getUsers(token!);
      setState(() {
        usersArray = users;
        isLoading = false; // Update isLoading to false after data is fetched
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
          isLoading
              ? Center(
                  child:
                      CircularProgressIndicator()) // Added a loading indicator
              : Positioned.fill(
                  top: 100,
                  child: ListView.builder(
                    itemCount: showPatients
                        ? getPatients().length
                        : getDoctors().length,
                    itemBuilder: (context, index) {
                      final user = showPatients
                          ? getPatients()[index]
                          : getDoctors()[index];
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
