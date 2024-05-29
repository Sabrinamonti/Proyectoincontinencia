import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:loginpage/MedicPage/EditprofileMed.dart';

class MyproInfoMed extends StatefulWidget {
  const MyproInfoMed({Key? key}) : super(key: key);

  @override
  State<MyproInfoMed> createState() => _MyproInfoMedState();
}

class _MyproInfoMedState extends State<MyproInfoMed> {
  final FirebaseAuth auth = FirebaseAuth.instance;
  String inputData() {
    String usuario = "";
    final User? user = auth.currentUser;
    final uemail = user?.email;
    usuario = uemail.toString();
    return usuario;
    // here you write the codes to input the data into firestore
  }

  @override
  Widget build(BuildContext context) {
    final Datauser = auth.currentUser;
    final CollectionReference InfoPat =
        FirebaseFirestore.instance.collection('Usuario');

    return Scaffold(
      body: Column(
        children: [
          AppBar(
            backgroundColor: Colors.transparent,
            toolbarHeight: 10,
          ),
          const Center(
            child: Padding(
              padding: EdgeInsets.only(bottom: 20),
              child: Text('Perfil',
                  style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.w700,
                      color: Color.fromRGBO(64, 105, 225, 1))),
            ),
          ),
          InkWell(
            onTap: () {},
            child: DisplayImage(
              imagePath: 'Assets/imageninicio/imageninicio.jpg',
              onPressed: () {
                print("el usuario es:" + inputData());
              },
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          const Divider(),
          FutureBuilder(
              future: InfoPat.doc(Datauser?.uid).get(),
              builder: (BuildContext context,
                  AsyncSnapshot<DocumentSnapshot> snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  Map<String, dynamic> data =
                      snapshot.data!.data() as Map<String, dynamic>;
                  return buildUserInfoDisplay(
                      data['Nombre'], 'Nombre Completo', const EditNameFormPage());
                }
                return const Text('Loading');
              }),
          const SizedBox(
            height: 15,
          ),
          FutureBuilder(
              future: InfoPat.doc(Datauser?.uid).get(),
              builder: (BuildContext context,
                  AsyncSnapshot<DocumentSnapshot> snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  Map<String, dynamic> data =
                      snapshot.data!.data() as Map<String, dynamic>;
                  return buildUserInfoDisplay(
                      data['Telefono'], 'Telefono', const EditPhoneFormPage());
                }
                return const Text('Loading');
              }),
          const SizedBox(
            height: 15,
          ),
          FutureBuilder(
              future: InfoPat.doc(Datauser?.uid).get(),
              builder: (BuildContext context,
                  AsyncSnapshot<DocumentSnapshot> snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  Map<String, dynamic> data =
                      snapshot.data!.data() as Map<String, dynamic>;
                  return buildUserInfoDisplay(
                      data['Email'], 'Nombre de Usuario', const EditEmailFormPage());
                }
                return const Text('Loading');
              }),
        ],
      ),
    );
  }

  Widget buildUserInfoDisplay(String getValue, String title, Widget editPage) =>
      Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey,
                )),
            const SizedBox(height: 2),
            Container(
              width: 350,
              height: 40,
              decoration: const BoxDecoration(
                  border: Border(
                      bottom: BorderSide(
                color: Colors.grey,
                width: 1,
              ))),
              child: Row(
                children: [
                  Expanded(
                      child: TextButton(
                    onPressed: () {
                      navigateSecondPage(editPage);
                    },
                    child: Text(getValue,
                        style: const TextStyle(fontSize: 16, height: 1.4)),
                  )),
                  const Icon(Icons.keyboard_arrow_right, color: Colors.grey, size: 40)
                ],
              ),
            )
          ],
        ),
      );

  void navigateSecondPage(Widget editForm) {
    Route route = MaterialPageRoute(builder: (context) => editForm);
    Navigator.push(context, route).then(onGoBack);
  }

  FutureOr onGoBack(dynamic value) {
    setState(() {});
  }
}
