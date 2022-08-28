import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';

class CalibrarEsp extends StatefulWidget {
  const CalibrarEsp({Key? key}) : super(key: key);

  @override
  State<CalibrarEsp> createState() => _CalibrarEspState();
}

class _CalibrarEspState extends State<CalibrarEsp> {
  Tween<double> _scaleTween = Tween<double>(begin: 1, end: 4);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text('Calibracion'),
      ),
      backgroundColor: Color.fromARGB(255, 248, 177, 245),
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
                              onFinished: () {
                                ElevatedButton(
                                  onPressed: () {},
                                  child: Text('Inicair ejercicio'),
                                );
                              },
                              repeatForever: false,
                              totalRepeatCount: 1,
                              animatedTexts: [
                                RotateAnimatedText('Presione el area pelvica',
                                    duration: Duration(seconds: 60)),
                                RotateAnimatedText('Relaje el area pelvica',
                                    duration: Duration(seconds: 60)),
                              ])),
                      SizedBox(
                        height: 400,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Positioned(
              top: 230,
              child: Container(
                child: Center(
                  child: TweenAnimationBuilder(
                    tween: _scaleTween,
                    duration: Duration(seconds: 180),
                    curve: Curves.bounceOut,
                    builder: (context, double _scale, child) {
                      return Transform.scale(
                        scale: _scale,
                        child: child,
                      );
                    },
                    child: Container(
                      width: 50,
                      height: 50,
                      color: Colors.lightBlue[200],
                      child: Text(
                        'Tomando datos',
                        style: Theme.of(context).textTheme.headline5,
                      ),
                    ),
                  ),
                ),
              ))
        ]),
      ),
    );
  }
}
