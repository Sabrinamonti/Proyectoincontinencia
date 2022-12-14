import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:loginpage/TecnicoPage/TecnicoPage.dart';
import 'package:loginpage/TecnicoPage/funcionEdituser.dart';

class Editpage extends StatefulWidget {
  final String value;
  final String email;
  final String pass;
  const Editpage(
      {Key? key, required this.value, required this.email, required this.pass})
      : super(key: key);

  @override
  State<Editpage> createState() => _EditpageState();
}

class _EditpageState extends State<Editpage> {
  @override
  Widget build(BuildContext context) {
    final CollectionReference InfoPat =
        FirebaseFirestore.instance.collection('Usuario');

    return Scaffold(
      appBar: AppBar(
          title: const Text('Pagina Perfil'),
          backgroundColor: Colors.blue,
          leading: ElevatedButton(
            child: const Icon(Icons.arrow_back),
            onPressed: () {
              //FirebaseAuth.instance.signOut();
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const TecnicoPage()));
            },
          )),
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
                print("Cambio de imagen");
              },
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Divider(),
          FutureBuilder(
              future: InfoPat.doc(widget.value).get(),
              builder: (BuildContext context,
                  AsyncSnapshot<DocumentSnapshot> snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  Map<String, dynamic> data =
                      snapshot.data!.data() as Map<String, dynamic>;
                  return buildUserInfoDisplay(data['Nombre'], 'Nombre Completo',
                      EditName(value: widget.value));
                }
                return Text('Loading');
              }),
          SizedBox(
            height: 15,
          ),
          FutureBuilder(
              future: InfoPat.doc(widget.value).get(),
              builder: (BuildContext context,
                  AsyncSnapshot<DocumentSnapshot> snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  Map<String, dynamic> data =
                      snapshot.data!.data() as Map<String, dynamic>;
                  return buildUserInfoDisplay(data['Telefono'], 'Telefono',
                      EditPhoneFormPage(value: widget.value));
                }
                return Text('Loading');
              }),
          SizedBox(
            height: 15,
          ),
          FutureBuilder(
              future: InfoPat.doc(widget.value).get(),
              builder: (BuildContext context,
                  AsyncSnapshot<DocumentSnapshot> snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  Map<String, dynamic> data =
                      snapshot.data!.data() as Map<String, dynamic>;
                  return buildUserInfoDisplay(
                      data['Email'],
                      'Nombre de Usuario',
                      EditEmailFormPage(value: widget.value));
                }
                return Text('Loading');
              }),
          FutureBuilder(
              future: InfoPat.doc(widget.value).get(),
              builder: (BuildContext context,
                  AsyncSnapshot<DocumentSnapshot> snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  Map<String, dynamic> data =
                      snapshot.data!.data() as Map<String, dynamic>;
                  return buildUserInfoDisplay(data['Contrasena'], 'Contrasena',
                      EditPassword(value: widget.value));
                }
                return Text('Loading');
              })
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
                  Icon(Icons.keyboard_arrow_right, color: Colors.grey, size: 40)
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
