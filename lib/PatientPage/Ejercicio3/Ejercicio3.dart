import 'dart:async';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:loginpage/PatientPage/Homepagepatient.dart';

class Ejercicio3 extends StatefulWidget {
  const Ejercicio3({Key? key}) : super(key: key);

  @override
  State<Ejercicio3> createState() => _Ejercicio3State();
}

class _Ejercicio3State extends State<Ejercicio3>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller =
      AnimationController(vsync: this, duration: Duration(seconds: 15))
        ..repeat(reverse: true);

  late Animation<double> _animation =
      Tween(begin: 0.0, end: 1.0).animate(_controller);

  bool showbutton = false;
  double valor = 0;
  double valormax = 0;
  bool cambioimagen = false;

  static const seconds = 16;
  double secs = 30;
  Timer? timer;

  void startTimer() {
    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        secs--;
      });
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //_controller = new AnimationController(vsync: this);
    //_animation = Tween(begin: 0.0, end: 1).animate(_controller);
    Future.delayed(Duration(seconds: 600), () {
      setState(() {
        showbutton = true;
      });
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controller.dispose();
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
                showbutton
                    ? Positioned(
                        bottom: 70,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => TabBarPaciente()));
                          },
                          child: Text('Finalizar'),
                        ))
                    : Positioned(
                        top: 250,
                        child: Container(
                          height: 250,
                          width: 250,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage(
                                      'assets/imageninicio/Rosaabierta.jpg'))),
                          child: FadeTransition(
                            opacity: _animation,
                            child: Image.asset(
                                'assets/imageninicio/Rosacerrada.jpg'),
                          ),
                        ))
              ],
            ),
          ),
        ));
  }
}
