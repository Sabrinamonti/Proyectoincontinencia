import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class PacientesList{
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future GetUserId () async {
    final currentuser = _auth.currentUser;
    CollectionReference documents= FirebaseFirestore.instance.collection('Usuario');
    DocumentSnapshot snapshot = await documents.doc(currentuser?.uid).get();
    var data= snapshot.data() as Map;
    var idpatuser = data['PacsId'] as List<dynamic>;
    List ids = [];
    idpatuser.forEach((element) {
      ids.add(element);
    });

    Query<Map<String, dynamic>> patientelist = FirebaseFirestore.instance.collection('Usuario');
    for (int i=0; i< idpatuser.length; i++){
      patientelist = patientelist.where('Id', isEqualTo: idpatuser[i]);
    }
    List itemslist= [];
    try {
      await patientelist.get().then((value) {
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
