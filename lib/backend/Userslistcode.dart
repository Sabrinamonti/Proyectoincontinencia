import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

class DatabaseManagement {
  Stream<List<Object?>> getList(
      {required String uid, required List<String> ids}) {
    var ref = FirebaseFirestore.instance.collection('Usuario');
    return CombineLatestStream.list<QuerySnapshot>([
      for (int i = 0; i < ids.length; i += 10)
        ref
            .where(FieldPath.documentId,
                whereNotIn: ids
                    .getRange(
                        i, i + 10 > ids.length ? i + (ids.length % 10) : i + 10)
                    .toList())
            .snapshots()
    ]).map((event) => event
        .expand((qDocument) =>
            qDocument.docs.map((DocumentSnapshot doc) => doc.data()))
        .toList());
  }

  Future gerUsersList() async {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    final currentuser = _auth.currentUser;
    CollectionReference documents =
        FirebaseFirestore.instance.collection('Usuario');
    DocumentSnapshot snapshot = await documents.doc(currentuser?.uid).get();
    var data = snapshot.data() as Map;
    var idpatuser = data['PacsId'] as List<dynamic>;
    List ids = [];
    idpatuser.forEach((element) {
      ids.add(element);
    });

    final patientelist = FirebaseFirestore.instance
        .collection('Usuario')
        .where('TipoUsuario', isEqualTo: "Paciente")
        .where('Id', whereNotIn: ids);
    List itemslist = [];
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
