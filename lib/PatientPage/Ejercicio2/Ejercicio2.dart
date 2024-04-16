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

class _Ejercicio2State extends State<Ejercicio2> {
  bool showbutton = false;
  late double progress = 0;
  late double valormax = 1;

  final FirebaseAuth _auth = FirebaseAuth.instance;
  late final currentuser = _auth.currentUser;

  late Stream<DocumentSnapshot> _stream;

  @override
  void initState() {
    super.initState();
    // Establecer el stream para escuchar los cambios en la colección de Firestore
    _stream = FirebaseFirestore.instance
        .collection('sensor')
        .doc(currentuser?.uid)
        .collection('Ejercicio')
        .doc('sensor')
        .snapshots();

    // Iniciar temporizador para mostrar el botón después de un cierto tiempo
    Future.delayed(Duration(seconds: 120), () {
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
                    color: Colors.transparent,
                  ),
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
                              fontWeight: FontWeight.bold,
                            ),
                            child: AnimatedTextKit(
                              repeatForever: false,
                              totalRepeatCount: 4,
                              animatedTexts: [
                                FadeAnimatedText(
                                  'Presione el area pelvica',
                                  duration: Duration(seconds: 15),
                                ),
                                FadeAnimatedText(
                                  'Relaje el area pelvica',
                                  duration: Duration(seconds: 15),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 200,
                child: SizedBox(
                  height: 250,
                  width: 250,
                  child: StreamBuilder<DocumentSnapshot>(
                    stream: _stream,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const CircularProgressIndicator(
                          backgroundColor: Colors.grey,
                          color: Colors.green,
                          strokeWidth: 30,
                        );
                      }
                      if (!snapshot.hasData || snapshot.data == null) {
                        return Text('No hay datos disponibles');
                      }

                      final DateTime now = DateTime.now();
                      final String formatter = DateFormat.yMd().format(now);
                      final valmax = FirebaseFirestore.instance
                          .collection('sensor')
                          .doc(currentuser?.uid)
                          .collection('calibrar')
                          .doc('sensor')
                          .collection('valormax')
                          .limit(1)
                          .where('fecha', isEqualTo: formatter)
                          .get()
                          .then((value) => {
                                value.docs.forEach((element) {
                                  setState(() {
                                    valormax = element.data()['emg'];
                                  });
                                })
                              });

                      progress =
                          (snapshot.data!['valor'] / 1024) / (valormax / 1024);

                      return Stack(
                        fit: StackFit.expand,
                        children: [
                          CircularProgressIndicator(
                            backgroundColor: Colors.grey,
                            color: Colors.green,
                            strokeWidth: 30,
                            value: progress,
                          ),
                          Center(
                            child: Text(
                              '${(progress * 100).toStringAsFixed(1)}',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                                fontSize: 24,
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ),
              showbutton
                  ? Positioned(
                      bottom: 70,
                      child: ElevatedButton(
                        onPressed: () {
                          final DateTime now = DateTime.now();
                          final String formatter = DateFormat.yMd().format(now);
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
                          DocumentReference stopej1 = FirebaseFirestore.instance
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
                                builder: (context) => TabBarPaciente()),
                          );
                        },
                        child: Text('Finalizar'),
                      ),
                    )
                  : Container(),
            ],
          ),
        ),
      ),
    );
  }
}
