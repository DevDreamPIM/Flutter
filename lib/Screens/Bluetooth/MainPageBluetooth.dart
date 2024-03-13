import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

import 'package:epilepto_guard/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'package:epilepto_guard/Services/criseService.dart';
import 'package:http/http.dart' as http;
import 'package:epilepto_guard/Models/seizure.dart';

import './DiscoveryPage.dart';

class MainPageBluetooth extends StatefulWidget {
  @override
  _MainPageBluetooth createState() => new _MainPageBluetooth();
}

class _Message {
  int whom;
  String text;

  _Message(this.whom, this.text);
}

class _MainPageBluetooth extends State<MainPageBluetooth> {
  BluetoothState _bluetoothState = BluetoothState.UNKNOWN;

  String BtWatchName = "DevDream-SmartWatch-BT";
  var connection; //BluetoothConnection
  List<_Message> messages = [];
  String _messageBuffer = '';

  bool isConnecting = true;
  bool isDisconnecting = false;

  bool liveMonitoringEnabled;
  _MainPageBluetooth() : liveMonitoringEnabled = true;

  late Seizure _newCrise;
  final storage = FlutterSecureStorage();

  @override
  void initState() {
    super.initState();

    // Get current state
    FlutterBluetoothSerial.instance.state.then((state) {
      setState(() {
        _bluetoothState = state;
      });
    });

    // Listen for futher state changes
    FlutterBluetoothSerial.instance
        .onStateChanged()
        .listen((BluetoothState state) {
      setState(() {
        _bluetoothState = state;
      });
    });

    // Request location permission
    Permission.location.request();

    // Request Bluetooth scan permission
    Permission.bluetoothScan.request();

    // Request Bluetooth connect permission
    Permission.bluetoothConnect.request();
  }

  @override
  void dispose() {
    FlutterBluetoothSerial.instance.setPairingRequestHandler(null);
    // Avoid memory leak (`setState` after dispose) and disconnect
    if (isConnected()) {
      isDisconnecting = true;
      connection.dispose();
      connection = null;
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('DevDream Connectivity Settings'),
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
                'assets/images/background/login.png'), // Replace 'background.jpg' with your image path
            fit: BoxFit.cover,
          ),
        ),
        child: ListView(
          children: <Widget>[
            Divider(),
            const ListTile(
              title: Text(
                'General',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: AppColors.purple,
                ),
              ),
            ),
            SwitchListTile(
              title: const Text('Enable Bluetooth'),
              value: _bluetoothState.isEnabled,
              onChanged: (bool value) {
                // Do the request and update with the true value then
                future() async {
                  // async lambda seems to not working
                  if (value)
                    await FlutterBluetoothSerial.instance.requestEnable();
                  else
                    await FlutterBluetoothSerial.instance.requestDisable();
                }

                future().then((_) {
                  setState(() {});
                });
              },
            ),
            ListTile(
              title: const Text('Smartwatch device name'),
              subtitle: Text(BtWatchName),
            ),
            SwitchListTile(
              title: const Text('Enable Live Seizure Monitoring'),
              value: liveMonitoringEnabled,
              onChanged: (bool value) {
                setState(() {
                  liveMonitoringEnabled = value;
                  _sendMessage(value.toString());
                });
              },
            ),
            Divider(),
            ListTile(
              title: TextButton(
                  child: Text('Pair and connect to $BtWatchName'),
                  onPressed: () async {
                    final BluetoothDevice selectedDevice =
                        await Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) {
                          return DiscoveryPage();
                        },
                      ),
                    );

                    if (selectedDevice != null) {
                      print('Discovery -> selected ' + selectedDevice.address);
                      _connectionSuccess(context, selectedDevice);
                    } else {
                      print('Discovery -> no device selected');
                    }
                  }),
            ),
          ],
        ),
      ),
    );
  }

  // The code below will be executed after the connection to the bt device

  void _connectionSuccess(
      BuildContext context, BluetoothDevice selectedDevice) {
    final snackBar = SnackBar(
      content: Text("Successfully connected to ${selectedDevice.name}"),
      duration: Duration(seconds: 3),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);

    BluetoothConnection.toAddress(selectedDevice.address).then((_connection) {
      print('Connected to the device');
      connection = _connection;
      setState(() {
        isConnecting = false;
        isDisconnecting = false;
      });

      connection.input.listen(_onDataReceived).onDone(() {
        if (isDisconnecting) {
          print('Disconnecting locally!');
        } else {
          print('Disconnected remotely!');
        }
        if (this.mounted) {
          setState(() {});
        }
      });
    }).catchError((error) {
      print('Cannot connect, exception occured');
      print(error);
    });

    // Call the external method to send a message
  }

  void _onDataReceived(Uint8List data) {
    String receivedData = utf8.decode(data);
    print("Received data: $receivedData");

    // Use switch-case to handle different types of messages
    if (receivedData.startsWith("emg")) {
      // Handle message starting with "emg"
    } else if (receivedData.startsWith("bmp")) {
      // Handle message starting with "bmp"
    } else if (receivedData.startsWith("imu")) {
      // Handle message starting with "imu"
    } else if (receivedData.startsWith("cri")) {
      // ajouter une crise
      _addCrise();
    } else {
      print("message inconnu !");
    }
  }

  void _sendMessage(String text) async {
    try {
      connection.output.add(utf8.encode("$text\r\n"));
      await connection.output.allSent;
    } catch (e) {
      // Ignore error, but notify state
      setState(() {});
    }
  }

  bool isConnected() {
    return connection != null && connection.isConnected;
  }

  Future<void> _addCrise() async {
    try {
      String? userId = await storage.read(key: 'id');
      _newCrise = Seizure(
        userId: userId ?? "",
        date: DateTime.now().toString(),
        startTime: DateTime.now().toString(),
        endTime: DateTime.now().toString(),
        duration: 30,
        location: "Tunis",
        type: "generalized",
        emergencyServicesCalled: true,
        medicalAssistance: true,
        severity: "moderate",
      );
      print(_newCrise.toJson().toString());
      await CriseService().createSeizure(_newCrise);
    } catch (e) {
      print('Failed to add drug: $e');
    }
  }
}
