import 'package:flutter/material.dart';
import 'package:loginpage/PatientPage/AccesoEjer1.dart';

class Ejerciciospage extends StatefulWidget {
  const Ejerciciospage({Key? key}) : super(key: key);

  @override
  State<Ejerciciospage> createState() => _EjerciciospageState();
}

class _EjerciciospageState extends State<Ejerciciospage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      padding: EdgeInsets.all(15),
      child: Center(
        child: Material(
          color: Color.fromARGB(255, 108, 165, 100),
          elevation: 5,
          borderRadius: BorderRadius.circular(25),
          child: Center(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  children: [
                    bottonejercicio(
                        'assets/imageninicio/imageninicio.jpg', 'Ejercicio1'),
                    bottonejercicio2(
                        'assets/imageninicio/imageninicio.jpg', 'Ejercicio2'),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    ));
  }

  Widget bottonejercicio(String imagen, String text) {
    return InkWell(
        splashColor: Colors.black26,
        onTap: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const inicioEjer1()));
        },
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          Ink.image(
            image: AssetImage(imagen),
            height: 150,
            width: 150,
            fit: BoxFit.cover,
          ),
          SizedBox(height: 6),
          Text(
            text,
            style: TextStyle(fontSize: 28, color: Colors.white),
          ),
          SizedBox(height: 6),
        ]));
  }

  Widget bottonejercicio2(String imagen, String text) {
    return InkWell(
        splashColor: Colors.black26,
        onTap: () {},
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          Ink.image(
            image: AssetImage(imagen),
            height: 150,
            width: 150,
            fit: BoxFit.cover,
          ),
          SizedBox(height: 6),
          Text(
            text,
            style: TextStyle(fontSize: 28, color: Colors.white),
          ),
          SizedBox(height: 6),
        ]));
  }
}
