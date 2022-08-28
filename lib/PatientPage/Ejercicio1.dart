import 'package:flutter/material.dart';

class Ejercicio1 extends StatefulWidget {
  const Ejercicio1({Key? key}) : super(key: key);

  @override
  State<Ejercicio1> createState() => _Ejercicio1State();
}

class _Ejercicio1State extends State<Ejercicio1>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    late final AnimationController _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 20),
    )..repeat();
    late Animation _animation;

    return Scaffold(
      appBar: AppBar(
        title: Text('Ejercicio'),
      ),
      body: Center(
        child: Column(
          children: [
            Stack(
              children: [
                TweenAnimationBuilder<double>(
                    tween: Tween(begin: 0, end: 200),
                    duration: Duration(seconds: 20),
                    builder: (context, value, _) {
                      setState(() {
                        if (value <= 100) {
                          AnimatedOpacity(
                            opacity: 0,
                            duration: Duration(seconds: 2),
                            child: Text('Presione el area'),
                          );
                        } else {
                          AnimatedOpacity(
                            opacity: 0,
                            duration: Duration(seconds: 2),
                            child: Text('DESCANSE'),
                          );
                        }
                      });
                      return Stack(
                        children: [
                          if (value <= 100)
                            Opacity(
                              opacity: 100 - value,
                              child: Text('Presione el area'),
                            ),
                        ],
                      );
                    })
              ],
            ),
          ],
        ),
      ),
    );
  }
}
