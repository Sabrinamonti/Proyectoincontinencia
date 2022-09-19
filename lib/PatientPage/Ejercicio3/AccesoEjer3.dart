import 'package:flutter/material.dart';
import 'package:loginpage/PatientPage/Ejercicio2/Calibrarejer2.dart';
import 'package:loginpage/PatientPage/Ejercicio3/Calibrarejer3.dart';

class inicioEjer3 extends StatelessWidget {
  const inicioEjer3({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 4, 165, 149),
        title: const Text('Instrucciones'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Column(
        children: [
          Card(
            shadowColor: Colors.black,
            elevation: 8,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: Container(
              padding: EdgeInsets.all(15),
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                colors: [Colors.indigo, Colors.black],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              )),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    'Coloquese los sensores como se muestra en la siguiente imagen',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 21,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 6),
                  Image(
                    alignment: Alignment.center,
                    image: NetworkImage(
                        'https://www.yourtrainingedge.com/wp-content/uploads/2019/05/background-calm-clouds-747964.jpg'),
                    height: 255,
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Card(
            color: Color.fromARGB(255, 160, 159, 159),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            child: Padding(
              padding: EdgeInsets.all(18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    'El ejercicio durara 10 minutos, debe acomodarse en un lugar comodo para realizar este ejericcio',
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
                  ),
                  SizedBox(height: 6),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Card(
            color: Color.fromARGB(255, 214, 114, 114),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            child: Padding(
              padding: EdgeInsets.all(18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    'A continuacion presione el boton para comemzar con la calibracón',
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
                  ),
                  SizedBox(height: 6),
                ],
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const CalibrarEspEj3()));
            },
            child: Text('Iniciar Calibración'),
          )
        ],
      ),
    );
  }
}
