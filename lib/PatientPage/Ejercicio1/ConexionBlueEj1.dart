
import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';
// Copyright 2017, Paul DeMarco.
// All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';

import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

class BleController extends GetxController {
  FlutterBlue ble = FlutterBlue.instance;

  Future scanDevices() async {
    if (await Permission.bluetoothScan.request().isGranted) {
      if (await Permission.bluetoothConnect.request().isGranted) {
        ble.startScan(timeout: const Duration(seconds: 10));

        ble.stopScan();
      }
    }
  }

  Stream<List<ScanResult>> get scanResults => ble.scanResults;
}
//class FlutterBlueApp extends StatelessWidget {
//@override
//Widget build(BuildContext context) {
// return MaterialApp(
//  color: Colors.lightBlue,
// home: StreamBuilder<BluetoothState>(
//    stream: FlutterBluePlus.insta,
//   initialData: BluetoothState.unknown,
//  builder: (c, snapshot) {
//   final state = snapshot.data;
//  if (state == BluetoothState.on) {
//return FindDevicesScreen();
//  }
//return BluetoothOffScreen(state: state);
// }),
//);
// }
//}

class BluePage extends StatefulWidget {
  const BluePage({Key? key}) : super(key: key);

  @override
  State<BluePage> createState() => _BluePageState();
}

class _BluePageState extends State<BluePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Dispositivos'),
        ),
        body: GetBuilder<BleController>(
            init: BleController(),
            builder: (BleController controller) {
              return SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    StreamBuilder<List<ScanResult>>(
                        stream: controller.scanResults,
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return SizedBox(
                              height: 400,
                              child: ListView.builder(
                                  itemCount: snapshot.data!.length,
                                  itemBuilder: (context, index) {
                                    final data = snapshot.data![index];
                                    return Card(
                                      elevation: 2,
                                      child: ListTile(
                                        title: Text(data.device.name),
                                        subtitle: Text(data.device.id.id),
                                      ),
                                    );
                                  }),
                            );
                          } else {
                            return const Center(
                              child: Text("No found"),
                            );
                          }
                        }),
                    const SizedBox(
                      height: 10,
                    ),
                    ElevatedButton(
                        onPressed: () => controller.scanDevices(),
                        child: const Text("SCAN"))
                  ],
                ),
              );
            }));
  }
}
