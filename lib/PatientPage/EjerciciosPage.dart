import 'package:flutter/material.dart';

class Ejerciciospage extends StatefulWidget {
  const Ejerciciospage({ Key? key }) : super(key: key);

  @override
  State<Ejerciciospage> createState() => _EjerciciospageState();
}

class _EjerciciospageState extends State<Ejerciciospage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.all(5),
        child: Center(
        child: Material(
          color: Colors.blueAccent,
          elevation: 5,
          borderRadius: BorderRadius.circular(25),
          child: Column(
            children: [
              bottonejercicio('assets/imageninicio/imageninicio.jpg', 'Ejercicio1'),
              SizedBox(height: 10),
              bottonejercicio2('assets/imageninicio/imageninicio.jpg', 'Ejercicio2'),
              SizedBox(height: 10),
              bottonejercicio('assets/imageninicio/imageninicio.jpg', 'Ejercicio3'),
            ],
          ),
        ),
      ),
      )
    );
  }

  Widget bottonejercicio (String imagen, String text){
    return InkWell(
          splashColor: Colors.black26,
          onTap: (){},
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
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
          ])
        );
  }

  Widget bottonejercicio2 (String imagen, String text){
    return InkWell(
          splashColor: Colors.black26,
          onTap: (){},
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
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
          ])
        );
  }
}