import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class DatabaseManagement {
  Future gerUsersList() async {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    final currentuser = _auth.currentUser;
    CollectionReference documents =
        FirebaseFirestore.instance.collection('Usuario');
    DocumentSnapshot snapshot = await documents.doc(currentuser?.uid).get();
    var data = snapshot.data() as Map;
    var idpats = data['PacsId'] as List<dynamic>;
    List ids = [];
    idpats.forEach((element) {
      ids.add(element);
    });

    Query<Map<String, dynamic>> userslist = FirebaseFirestore.instance
        .collection('Usuario')
        .where('TipoUsuario', isEqualTo: "Paciente");

    for (int i = 0; i < idpats.length; i++) {
      userslist = userslist.where('Id', isNotEqualTo: idpats[i]);
    }

    List itemslist = [];
    try {
      await userslist.get().then((value) {
        value.docs.forEach((element) {
          itemslist.add(element.data());
        });
      });
      return itemslist;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
