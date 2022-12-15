import 'dart:async';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:loginpage/PatientPage/Ejercicio1/thermometropage.dart';
import 'package:loginpage/PatientPage/Homepagepatient.dart';

class Ejercicio1 extends StatefulWidget {
  const Ejercicio1({Key? key}) : super(key: key);

  @override
  State<Ejercicio1> createState() => _Ejercicio1State();
}

class _Ejercicio1State extends State<Ejercicio1> {
  bool showbutton = false;
  late double _temp = 0.10;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration(seconds: 600), () {
      setState(() {
        showbutton = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Ejercicio'),
        ),
        body: Center(
          child: Container(
            alignment: Alignment.center,
            child: Stack(
              alignment: Alignment.center,
              children: [
                Positioned(
                  top: 50,
                  width: 350,
                  child: Container(
                    alignment: Alignment.center,
                    margin: const EdgeInsets.only(left: 20, right: 20),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.transparent),
                    child: Container(
                      alignment: Alignment.center,
                      child: Center(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            DefaultTextStyle(
                                style: const TextStyle(
                                    fontSize: 28,
                                    color: Color.fromARGB(255, 1, 175, 152),
                                    fontWeight: FontWeight.bold),
                                child: AnimatedTextKit(
                                    repeatForever: false,
                                    totalRepeatCount: 20,
                                    animatedTexts: [
                                      FadeAnimatedText(
                                          'Presione el area pelvica',
                                          duration: Duration(seconds: 15)),
                                      FadeAnimatedText('Relaje el area pelvica',
                                          duration: Duration(seconds: 15)),
                                    ])),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Positioned(
                    top: 120,
                    child: SizedBox(
                      height: 420,
                      width: 350,
                      child: Image.asset(
                          'assets/imageninicio/ImagenEjercicio1.jpg'),
                    )),
                showbutton
                    ? Positioned(
                        bottom: 70,
                        child: ElevatedButton(
                          onPressed: () async {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => TabBarPaciente()));
                          },
                          child: Text('Finalizar'),
                        ))
                    : Container(),
              ],
            ),
          ),
        ));
  }
}
