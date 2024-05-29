import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:loginpage/PatientPage/Ejercicio3/Calibrarejer3.dart';

class inicioEjer3 extends StatelessWidget {
  const inicioEjer3({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 4, 165, 149),
        title: const Text('Instrucciones'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
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
              padding: const EdgeInsets.all(15),
              decoration: const BoxDecoration(
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
                    image: AssetImage('assets/imageninicio/Electrodos.jpg'),
                    height: 255,
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Card(
            color: const Color.fromARGB(255, 160, 159, 159),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            child: Padding(
              padding: const EdgeInsets.all(18),
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
          const SizedBox(
            height: 10,
          ),
          Card(
            color: const Color.fromARGB(255, 214, 114, 114),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            child: Padding(
              padding: const EdgeInsets.all(18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    'A continuacion presione el boton para comenzar con la calibracón',
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
              final FirebaseAuth _auth = FirebaseAuth.instance;
              final currentuser = _auth.currentUser;

              DocumentReference docCal = FirebaseFirestore.instance
                  .collection('sensor')
                  .doc(currentuser?.uid)
                  .collection('calibrar')
                  .doc('sensor');
              docCal.update({
                'STATUS': 'ON',
              });
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const CalibrarEspEj3()));
            },
            child: const Text('Iniciar Calibración'),
          )
        ],
      ),
    );
  }
}
