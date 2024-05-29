import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:loginpage/PatientPage/Ejercicio1/ConexionBlueEj1.dart';

class inicioEjer1 extends StatelessWidget {
  const inicioEjer1({Key? key}) : super(key: key);

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
              padding: const EdgeInsets.all(10),
              decoration: const BoxDecoration(
                  gradient: LinearGradient(
                colors: [Colors.indigo, Colors.black],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              )),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Text(
                      "Prepare la piel para lograr una correcta conduccion entre la piel y el electrodo. Limpie la piel con agua templada. No utilice alcohol",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 16,
                          color: Color.fromARGB(187, 255, 255, 255),
                          fontWeight: FontWeight.bold)),
                  Text(
                    'Coloquese los sensores como se muestra en la siguiente imagen',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                  Image(
                    alignment: Alignment.centerRight,
                    image: AssetImage('assets/imageninicio/Electrodos.jpg'),
                    height: 230,
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
              DocumentReference docsRef = FirebaseFirestore.instance
                  .collection('sensor')
                  .doc(currentuser?.uid)
                  .collection('Ejercicio')
                  .doc('sensor');
              docsRef.update({
                'STATUS': 'ON',
              });
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => const BluePage()));
            },
            child: const Text('Iniciar Ejercicio'),
          )
        ],
      ),
    );
  }
}
