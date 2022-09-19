import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:loginpage/PatientPage/Ejercicio2/Ejercicio2.dart';
import 'package:loginpage/PatientPage/Ejercicio3/Ejercicio3.dart';
import 'package:loginpage/PatientPage/mqttrecibir.dart';

class CalibrarEspEj3 extends StatefulWidget {
  const CalibrarEspEj3({Key? key}) : super(key: key);

  @override
  State<CalibrarEspEj3> createState() => _CalibrarEspEj3State();
}

class _CalibrarEspEj3State extends State<CalibrarEspEj3>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  Tween<double> _tween = Tween(begin: 0.75, end: 2);
  bool showbutton = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration(seconds: 10), () {
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
      backgroundColor: Color.fromARGB(255, 168, 216, 129),
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
                                    duration: Duration(seconds: 60)),
                                RotateAnimatedText('Relaje el area pelvica',
                                    duration: Duration(seconds: 60)),
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
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => MqttClientEsp()));
                    },
                    child: Text('Iniciar ejercicio'),
                  ))
              : Container(),
        ]),
      ),
    );
  }
}
