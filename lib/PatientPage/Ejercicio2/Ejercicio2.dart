import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:loginpage/PatientPage/Homepagepatient.dart';

class Ejercicio2 extends StatefulWidget {
  const Ejercicio2({Key? key}) : super(key: key);

  @override
  State<Ejercicio2> createState() => _Ejercicio2State();
}

class _Ejercicio2State extends State<Ejercicio2> {
  bool showbutton = false;
  double progress = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration(seconds: 10), () {
      setState(() {
        showbutton = true;

        //progress= valor / valor maximo;
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
                                    totalRepeatCount: 3,
                                    animatedTexts: [
                                      FadeAnimatedText(
                                          'Presione el area pelvica',
                                          duration: Duration(seconds: 20)),
                                      FadeAnimatedText('Relaje el area pelvica',
                                          duration: Duration(seconds: 20)),
                                    ])),
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
                        child: Stack(fit: StackFit.expand, children: [
                          Builder(builder: (BuildContext context) {
                            final documentStream = FirebaseFirestore.instance
                                .collection('sensor')
                                .snapshots()
                                .listen((event) {
                              event.docs.forEach((element) {
                                setState(() {
                                  progress = element.data()['valorej1'];
                                  //double progmax =
                                  //  element.data()['valormaxej1'];
                                  progress = (progress / 100) / (56 / 100);
                                });
                              });
                            });
                            return CircularProgressIndicator(
                              backgroundColor: Colors.grey,
                              color: Colors.green,
                              strokeWidth: 30,
                              value: progress,
                            );
                          }),
                          Center(child: buildProgress())
                        ]))),
                showbutton
                    ? Positioned(
                        bottom: 70,
                        child: ElevatedButton(
                          onPressed: () {
                            final DocmentStream = FirebaseFirestore.instance
                                .collection('sensor')
                                .doc('Ejercicio1')
                                .collection('data')
                                .orderBy('emg', descending: true)
                                .limit(1)
                                .get()
                                .then((value) {
                              value.docs.forEach((element) async {
                                DocumentReference anadevalmax =
                                    await FirebaseFirestore.instance
                                        .collection('sensor')
                                        .doc('Ejercicio1')
                                        .collection('valormaxej1')
                                        .add({'emg': element.data()['emg']});
                                print(element.data()['emg']);
                              });
                            });
                            DocumentReference stopej1 = FirebaseFirestore
                                .instance
                                .collection('sensor')
                                .doc('Ejercicio1');
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
