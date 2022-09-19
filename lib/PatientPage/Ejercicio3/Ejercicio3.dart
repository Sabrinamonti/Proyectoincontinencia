import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:loginpage/PatientPage/Ejercicio1/thermometropage.dart';

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
  bool cambioimagen = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //_controller = new AnimationController(vsync: this);
    //_animation = Tween(begin: 0.0, end: 1).animate(_controller);
    Future.delayed(Duration(seconds: 10), () {
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
                cambioimagen
                    ? Positioned(
                        top: 120,
                        child:
                            SizedBox(height: 420, width: 90, child: Center()))
                    : Positioned(
                        top: 120,
                        child: SizedBox(
                          height: 420,
                          width: 90,
                          child: Center(),
                        )),
                showbutton
                    ? Positioned(
                        bottom: 70,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Ejercicio3()));
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
