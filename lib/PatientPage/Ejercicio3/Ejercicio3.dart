import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';
import 'package:loginpage/PatientPage/Homepagepatient.dart';
import 'dart:math' as math;

class Ejercicio3 extends StatefulWidget {
  const Ejercicio3({Key? key}) : super(key: key);

  @override
  State<Ejercicio3> createState() => _Ejercicio3State();
}

class _Ejercicio3State extends State<Ejercicio3> with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animatable _animation;
  bool showbutton = false;
  double valor = 0;
  double valormax = 0;

  final FirebaseAuth _auth = FirebaseAuth.instance;
  late final currentuser = _auth.currentUser;

  late Stream<DocumentSnapshot> _stream;

  static const modulo = -math.pi / 2;

  final angle1 = math.pi + modulo;
  final angle2 = 5 * math.pi / 4 + modulo;
  //CENTER
  final angle3 = 3 * math.pi / 2 + modulo;

  final angle4 = 7 * math.pi / 4 + modulo;
  final angle5 = 2 * math.pi + modulo;

  double maxangle = math.pi / 6;
  double minangle = -math.pi / 6;

  AnimationController? animationController;

  Animation? angle1Animation;
  Animation? angle2Animation;
  Animation? angle4Animation;
  Animation? angle5Animation;

  Animation? color1Animation;
  Animation? color2Animation;

  static const color1 = Color(0xFF35C4E4);
  static const color2 = Color(0xFF57ECAF);
  static const color3 = Color.fromARGB(255, 234, 8, 114);
  static const color4 = Colors.orange;

  String breathText = '';
  Color textColor = color4;

  @override
  void initState() {
    animationController = AnimationController(
        vsync: this,
        duration: const Duration(seconds: 6),
        lowerBound: 0.1,
        upperBound: 0.8);
    angle1Animation = Tween<double>(begin: angle3, end: angle1).animate(
        CurvedAnimation(parent: animationController!, curve: Curves.ease));
    angle2Animation = Tween<double>(begin: angle3, end: angle2).animate(
        CurvedAnimation(parent: animationController!, curve: Curves.ease));
    angle4Animation = Tween<double>(begin: angle3, end: angle4).animate(
        CurvedAnimation(parent: animationController!, curve: Curves.ease));
    angle5Animation = Tween<double>(begin: angle3, end: angle5).animate(
        CurvedAnimation(parent: animationController!, curve: Curves.ease));

    animationController!.addListener(() {
      setState(() {});
    });

    color1Animation = ColorTween(begin: color1, end: color2).animate(
        CurvedAnimation(parent: animationController!, curve: Curves.ease));
    color2Animation = ColorTween(begin: color3, end: color4).animate(
        CurvedAnimation(parent: animationController!, curve: Curves.ease));

    animationController!.repeat(reverse: true);
    super.initState();

    _stream = FirebaseFirestore.instance
        .collection('sensor')
        .doc(currentuser?.uid)
        .collection('Ejercicio')
        .doc('sensor')
        .snapshots();

    Future.delayed(const Duration(seconds: 120), () {
      setState(() {
        showbutton = true;
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black26,
          title: const Text('Ejercicio'),
        ),
        backgroundColor: const Color(0xFF531A93),
        body: Stack(
          alignment: Alignment.center,
          children: [
            StreamBuilder<DocumentSnapshot>(
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
                  valor = snapshot.data!['valor'] / 1024;
                  //double percent = valor / valormax;
                  double percent = valormax != 0 ? valor / valormax : 0.0;

                  double Angle1 = (angle3 + maxangle * (1.3 - percent));
                  double Angle2 = (angle3 - maxangle * (1.3 - percent));
                  double Angle4 = (angle3 + minangle * (2 - percent));
                  double Angle5 = (angle3 - minangle * (2 - percent));

                  Color color;
                  if (percent > 0.8) {
                    color = color1Animation!.value;
                  } else {
                    color = color2Animation!.value;
                  }

                  return Container(
                      child: Stack(
                    children: [
                      Petal(angle: Angle1, color1: color, color2: color),
                      Petal(angle: Angle2, color1: color, color2: color),
                      Petal(angle: angle3, color1: color, color2: color),
                      Petal(angle: Angle4, color1: color, color2: color),
                      Petal(angle: Angle5, color1: color, color2: color),
                      Positioned(
                        bottom: 190,
                        right: 130,
                        child: Text(
                            ((valor / valormax) * 100).toStringAsFixed(1) '%',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                              fontSize: 35,
                            )),
                      )
                    ],
                  ));
                }),
            Positioned(
                top: 120,
                width: 350,
                right: 30,
                child: Center(
                    child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    AnimatedTextKit(
                        repeatForever: false,
                        totalRepeatCount: 4,
                        animatedTexts: [
                          FadeAnimatedText('Presione el area pelvica',
                              duration: const Duration(seconds: 15),
                              textStyle: const TextStyle(
                                  color: Color(0xFF57ECAF),
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold)),
                          FadeAnimatedText('Relaje el area pelvica',
                              duration: const Duration(seconds: 15),
                              textStyle: const TextStyle(
                                  color: Colors.orange,
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold))
                        ])
                  ],
                ))),
            showbutton
                ? Positioned(
                    bottom: 70,
                    child: ElevatedButton(
                      onPressed: () {
                        final DateTime now = DateTime.now();
                        final String formatter = DateFormat.yMd().format(now);
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
                          for (var element in value.docs) async {
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
                          }
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
                                builder: (context) => const TabBarPaciente()));
                      },
                      child: const Text('Finalizar'),
                    ))
                : Container(),
          ],
        ));
  }
}

class Petal extends StatelessWidget {
  final double angle;
  final Color? color1;
  final Color? color2;
  const Petal(
      {Key? key,
      required this.angle,
      required this.color1,
      required this.color2})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Positioned(
        top: 50 * math.cos(angle),
        right: 50 * math.sin(angle),
        child: Transform.translate(
            offset: Offset(-size.width / 4, size.height / 3),
            child: Transform.rotate(
                angle: angle,
                child: ClipPath(
                  clipper: PetalClipper(),
                  child: Container(
                    height: 200,
                    width: 200,
                    decoration: BoxDecoration(
                        gradient: RadialGradient(colors: [color1!, color2!])),
                  ),
                ))));
  }
}

class PetalClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final centerX = size.width / 2;
    final centerY = size.height / 2;

    double controlY = 60;
    double controlX = 50;
    Path path = Path();
    path.moveTo(centerX, centerY - controlY);
    path.relativeQuadraticBezierTo(controlX, controlY, 0, controlY * 2);
    path.relativeQuadraticBezierTo(-controlX, -controlY, 0, -controlY * 2);

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}
