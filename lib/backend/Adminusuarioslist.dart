import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AdminUsuarios {
  Future getUsers() async {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    final currentuser = _auth.currentUser;
    CollectionReference documents =
        FirebaseFirestore.instance.collection('Usuario');
    QuerySnapshot<Object?> snapshot = await documents.get();

    List itemslist = [];
    try {
      await documents.get().then((value) {
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
