import 'package:flutter/material.dart';
import 'package:loginpage/PatientPage/Ejercicio1/AccesoEjer1.dart';
import 'package:loginpage/PatientPage/Ejercicio2/AccesoEjer2.dart';
import 'package:loginpage/PatientPage/Ejercicio3/AccesoEjer3.dart';

import 'Ejercicio1/AccesoEjer1.dart';

class Ejerciciospage extends StatefulWidget {
  const Ejerciciospage({Key? key}) : super(key: key);

  @override
  State<Ejerciciospage> createState() => _EjerciciospageState();
}

class _EjerciciospageState extends State<Ejerciciospage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromARGB(255, 170, 184, 172),
        body: SingleChildScrollView(
          padding: EdgeInsets.all(15),
          child: Center(
            child: Material(
              color: Colors.transparent,
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
                            'assets/imageninicio/ImagenEjercicio1.jpg',
                            'Ejercicio1'),
                        bottonejercicio2(
                            'assets/imageninicio/ImagenEjercicio2.jpg',
                            'Ejercicio2'),
                        bottonejercicio3(
                            'assets/imageninicio/ImagenEjercicio3.jpg',
                            'Ejercicio3')
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
            style: TextStyle(fontSize: 28, color: Colors.black),
          ),
          SizedBox(height: 6),
        ]));
  }

  Widget bottonejercicio2(String imagen, String text) {
    return InkWell(
        splashColor: Colors.black26,
        onTap: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const inicioEjer2()));
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
            style: TextStyle(fontSize: 28, color: Colors.black),
          ),
          SizedBox(height: 6),
        ]));
  }

  Widget bottonejercicio3(String imagen, String text) {
    return InkWell(
        splashColor: Colors.black26,
        onTap: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const inicioEjer3()));
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
            style: TextStyle(fontSize: 28, color: Colors.black),
          ),
          SizedBox(height: 6),
        ]));
  }
}
