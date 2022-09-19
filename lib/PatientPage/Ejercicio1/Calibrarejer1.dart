import 'dart:async';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:mqtt_client/mqtt_server_client.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:loginpage/PatientPage/Ejercicio1/Ejercicio1.dart';
import 'package:mqtt_client/mqtt_client.dart' as mqtt;

class CalibrarEsp extends StatefulWidget {
  const CalibrarEsp({Key? key}) : super(key: key);

  @override
  State<CalibrarEsp> createState() => _CalibrarEspState();
}

class _CalibrarEspState extends State<CalibrarEsp>
    with SingleTickerProviderStateMixin {
  late mqtt.MqttClient client;
  late mqtt.MqttConnectionState connectionState;
  double _temp = 20;
  late StreamSubscription subscription;

  late AnimationController _controller;
  Tween<double> _tween = Tween(begin: 0.75, end: 2);
  bool showbutton = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration(seconds: 30), () {
      setState(() {
        showbutton = true;
      });
    });
    _controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 2));
    _controller.repeat(reverse: true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text('Calibracion'),
      ),
      backgroundColor: Color.fromARGB(255, 248, 177, 245),
      body: Container(
        alignment: Alignment.center,
        child: Stack(alignment: Alignment.center, children: [
          Positioned(
            top: 160,
            width: 350,
            child: Container(
              alignment: Alignment.center,
              margin: const EdgeInsets.only(left: 20, right: 20),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Color.fromARGB(255, 164, 179, 175)),
              child: Container(
                alignment: Alignment.center,
                child: Center(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      DefaultTextStyle(
                          style: TextStyle(fontSize: 20, color: Colors.black),
                          child: AnimatedTextKit(
                              repeatForever: false,
                              totalRepeatCount: 1,
                              animatedTexts: [
                                RotateAnimatedText('Presione el area pelvica',
                                    duration: Duration(seconds: 15)),
                                RotateAnimatedText('Relaje el area pelvica',
                                    duration: Duration(seconds: 15)),
                              ])),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Positioned(
              top: 300,
              child: Container(
                child: Center(
                    child: ScaleTransition(
                  scale: _tween.animate(CurvedAnimation(
                      parent: _controller, curve: Curves.bounceInOut)),
                  child: Icon(
                    Icons.circle,
                    size: 100,
                    color: Colors.green,
                  ),
                )),
              )),
          showbutton
              ? Positioned(
                  bottom: 180,
                  child: ElevatedButton(
                    onPressed: () async {
                      final DocmentStream = FirebaseFirestore.instance
                          .collection('sensor')
                          .doc('calibrar')
                          .collection('data')
                          .orderBy('emg', descending: true)
                          .limit(1)
                          .get()
                          .then((value) {
                        value.docs.forEach((element) async {
                          DocumentReference anadevalmax =
                              await FirebaseFirestore.instance
                                  .collection('sensor')
                                  .doc('calibrar')
                                  .collection('valormax')
                                  .add({'emg': element.data()['emg']});
                          print(element.data()['emg']);
                        });
                      });
                      DocumentReference docsRef = FirebaseFirestore.instance
                          .collection('sensor')
                          .doc('calibrar');
                      docsRef.update({
                        'STATUS': 'OFF',
                      });
                      DocumentReference valejer1 = FirebaseFirestore.instance
                          .collection('sensor')
                          .doc('Ejercicio1');
                      valejer1.update({
                        'STATUS': 'ON',
                      });
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Ejercicio1()));
                    },
                    child: Text('Iniciar ejercicio'),
                  ))
              : Container(),
        ]),
      ),
    );
  }
}
