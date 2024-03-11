import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

import 'package:epilepto_guard/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import './DiscoveryPage.dart';

class MainPageBluetooth extends StatefulWidget {
  @override
  _MainPageBluetooth createState() => new _MainPageBluetooth();
}

class _MainPageBluetooth extends State<MainPageBluetooth> {
  BluetoothState _bluetoothState = BluetoothState.UNKNOWN;

  String BtWatchName = "DevDream-SmartWatch-BT";

  bool liveMonitoringEnabled;
  _MainPageBluetooth() : liveMonitoringEnabled = true;

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
  }
}
