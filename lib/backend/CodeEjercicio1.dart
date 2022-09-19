import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Datosemg {
  static var emg;
  Future getsensorData() async {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    final currentuser = _auth.currentUser;
    CollectionReference documents =
        FirebaseFirestore.instance.collection('sensor');
    DocumentSnapshot snapshot = await documents.doc(currentuser?.uid).get();
    var data = snapshot.data() as Map;
    emg = data['valor'];
  }
}
