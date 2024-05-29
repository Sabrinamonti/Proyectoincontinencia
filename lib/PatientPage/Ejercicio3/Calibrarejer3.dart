import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:loginpage/PatientPage/Ejercicio3/Ejercicio3.dart';

class CalibrarEspEj3 extends StatefulWidget {
  const CalibrarEspEj3({Key? key}) : super(key: key);

  @override
  State<CalibrarEspEj3> createState() => _CalibrarEspEj3State();
}

class _CalibrarEspEj3State extends State<CalibrarEspEj3>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late double progress = 0;
  bool showbutton = false;

  final FirebaseAuth _auth = FirebaseAuth.instance;
  late final currentuser = _auth.currentUser;

  late Stream<DocumentSnapshot> _stream;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _stream = FirebaseFirestore.instance
        .collection('sensor')
        .doc(currentuser?.uid)
        .collection('calibrar')
        .doc('sensor')
        .snapshots();

    Future.delayed(const Duration(seconds: 30), () {
      setState(() {
        showbutton = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text('Calibracion'),
      ),
      backgroundColor: const Color.fromARGB(255, 168, 216, 129),
      body: Container(
        alignment: Alignment.center,
        child: Stack(alignment: Alignment.center, children: [
          Positioned(
            top: 150,
            width: 300,
            child: Container(
              alignment: Alignment.center,
              margin: const EdgeInsets.only(left: 20, right: 20),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: const Color.fromARGB(255, 164, 179, 175)),
              child: Container(
                alignment: Alignment.center,
                child: Center(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      DefaultTextStyle(
                          style: const TextStyle(fontSize: 20, color: Colors.black),
                          child: AnimatedTextKit(
                              repeatForever: false,
                              totalRepeatCount: 1,
                              animatedTexts: [
                                RotateAnimatedText('Presione el area pelvica',
                                    duration: const Duration(seconds: 20)),
                                RotateAnimatedText('Relaje el area pelvica',
                                    duration: const Duration(seconds: 15)),
                              ])),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Positioned(
              top: 300,
              child: SizedBox(
                height: 230,
                width: 230,
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
                      return const Text('No hay datos disponibles');
                    }

                    final DateTime now = DateTime.now();
                    final String formatter = DateFormat.yMd().format(now);
                    progress = (snapshot.data!['valor']);

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
                          (progress * 100).toStringAsFixed(1),
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                            fontSize: 24,
                          ),
                        ))
                      ],
                    );
                  },
                ),
              )),
          showbutton
              ? Positioned(
                  bottom: 100,
                  child: ElevatedButton(
                    onPressed: () async {
                      final FirebaseAuth _auth = FirebaseAuth.instance;
                      final currentuser = _auth.currentUser;
                      final DateTime now = DateTime.now();
                      final String formatter = DateFormat.yMd().format(now);

                      final DocmentStream = FirebaseFirestore.instance
                          .collection('sensor')
                          .doc(currentuser?.uid)
                          .collection('calibrar')
                          .doc('sensor')
                          .collection('data')
                          .orderBy('emg', descending: true)
                          .where('fechamax', isEqualTo: formatter)
                          .where('emg', isEqualTo: 1024)
                          .limit(1)
                          .get()
                          .then((value) {
                        for (var element in value.docs) async {
                          DocumentReference anadevalmax =
                              await FirebaseFirestore.instance
                                  .collection('sensor')
                                  .doc(currentuser?.uid)
                                  .collection('calibrar')
                                  .doc('sensor')
                                  .collection('valormax')
                                  .add({
                            'emg': element.data()['emg'],
                            'fecha': element.data()['fechamax']
                          });
                        }
                      });
                      DocumentReference docsRef = FirebaseFirestore.instance
                          .collection('sensor')
                          .doc(currentuser?.uid)
                          .collection('calibrar')
                          .doc('sensor');
                      docsRef.update({
                        'STATUS': 'OFF',
                      });
                      DocumentReference valejer1 = FirebaseFirestore.instance
                          .collection('sensor')
                          .doc(currentuser?.uid)
                          .collection('Ejercicio')
                          .doc('sensor');
                      valejer1.update({
                        'STATUS': 'ON',
                      });
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const Ejercicio3()));
                    },
                    child: const Text('Iniciar ejercicio'),
                  ))
              : Container(),
        ]),
      ),
    );
  }
}
