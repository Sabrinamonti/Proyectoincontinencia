import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:loginpage/PatientPage/Homepagepatient.dart';

class Ejercicio2 extends StatefulWidget {
  const Ejercicio2({Key? key}) : super(key: key);

  @override
  State<Ejercicio2> createState() => _Ejercicio2State();
}

class _Ejercicio2State extends State<Ejercicio2> with TickerProviderStateMixin {
  late final AnimationController _controller =
      AnimationController(vsync: this, duration: const Duration(seconds: 16))
        ..repeat(reverse: true);

  late Animation<Offset> _animationvertical =
      Tween(begin: Offset(0.1, 2.5), end: Offset.zero).animate(_controller);

  bool showbutton = false;
  late double progress = 0;
  late double valormax = 1;

  final FirebaseAuth _auth = FirebaseAuth.instance;
  late final currentuser = _auth.currentUser;

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
  void dispose() {
    // TODO: implement dispose
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const double smallLogo = 100;
    const double bigLogo = 200;
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
                        top: 200,
                        child: Column(
                          children: [
                            SlideTransition(
                                position: _animationvertical,
                                child: Container(
                                  width: 100,
                                  height: 100,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.blue[200],
                                  ),
                                ))
                          ],
                        ))
              ],
            ),
          ),
        ));
  }

  Widget buildProgress() {
    return Text(
      '${(progress * 100).toStringAsFixed(1)}',
      style: TextStyle(
        fontWeight: FontWeight.bold,
        color: Colors.black,
        fontSize: 24,
      ),
    );
  }
}
