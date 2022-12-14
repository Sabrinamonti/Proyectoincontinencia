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
  late AnimationController _controller;
  late Animation _animation;
  bool showbutton = false;
  double valor = 0;
  double valormax = 0;
  bool cambioimagen = false;

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
                Positioned(
                  top: 120,
                  child: Builder(builder: (BuildContext context) {
                    final DateTime now = DateTime.now();
                    final String formatter = DateFormat.yMd().format(now);
                    final FirebaseAuth _auth = FirebaseAuth.instance;
                    final currentuser = _auth.currentUser;
                    final valmax = FirebaseFirestore.instance
                        .collection('sensor')
                        .doc(currentuser?.uid)
                        .collection('calibrar')
                        .doc('sensor')
                        .collection('valormax')
                        .where('fecha', isEqualTo: formatter)
                        .limit(1)
                        .get()
                        .then((value) => {
                              value.docs.forEach((element) {
                                setState(() {
                                  valormax = element.data()['emg'];
                                  valormax = valormax / 1024;
                                });
                              })
                            });
                    final DocsSens = FirebaseFirestore.instance
                        .collection('sensor')
                        .doc(currentuser?.uid)
                        .collection('Ejercicio')
                        .snapshots()
                        .listen((event) {
                      event.docs.forEach((element) {
                        setState(() {
                          valor = element.data()['valor'];
                          valor = (valor / 1024);
                        });
                      });
                    });
                    return Container(
                        alignment: Alignment.center,
                        height: 300,
                        //decoration: BoxDecoration(
                        //borderRadius: BorderRadius.circular(20),
                        //image: DecorationImage(
                        //  image: AssetImage(
                        //    'assets/imageninicio/imagenrosaabierta.jpg')),
                        //color: Color.fromARGB(255, 37, 36, 36),
                        //),
                        child: Builder(builder: (BuildContext context) {
                          String imagen = "assets/imageninicio/Rosacerrada.jpg";
                          if ((valor / valormax) <= 0.30) {
                            imagen = "assets/imageninicio/Rosaabierta.jpg";
                          } else if ((valor / valormax) > 0.3 &&
                              (valor / valormax) <= 0.60) {
                            imagen = "assets/imageninicio/Rosasemiabierta.jpg";
                          } else if ((valor / valormax) > 0.60 &&
                              (valor / valormax) <= 0.90) {
                            imagen = "assets/imageninicio/Rosasemicerrada.jpg";
                          }
                          return Image.asset(imagen);
                        }));
                  }),
                ),
                showbutton
                    ? Positioned(
                        bottom: 70,
                        child: ElevatedButton(
                          onPressed: () {
                            print(valor);
                            final DateTime now = DateTime.now();
                            final String formatter =
                                DateFormat.yMd().format(now);
                            final FirebaseAuth _auth = FirebaseAuth.instance;
                            final currentuser = _auth.currentUser;
                            final DocmentStream = FirebaseFirestore.instance
                                .collection('sensor')
                                .doc(currentuser?.uid)
                                .collection('Ejercicio')
                                .doc('sensor')
                                .collection('data')
                                .orderBy('emg', descending: true)
                                .where('fechamax', isEqualTo: formatter)
                                .where('emg', isNotEqualTo: 1024)
                                .limit(1)
                                .get()
                                .then((value) {
                              value.docs.forEach((element) async {
                                DocumentReference anadevalmax =
                                    await FirebaseFirestore.instance
                                        .collection('sensor')
                                        .doc(currentuser?.uid)
                                        .collection('Ejercicio')
                                        .doc('sensor')
                                        .collection('valormax')
                                        .add({
                                  'emg': element.data()['emg'],
                                  'fecha': element.data()['fechamax']
                                });
                              });
                            });
                            DocumentReference stopej1 = FirebaseFirestore
                                .instance
                                .collection('sensor')
                                .doc(currentuser?.uid)
                                .collection('Ejercicio')
                                .doc('sensor');
                            stopej1.update({
                              'STATUS': 'OFF',
                            });
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
