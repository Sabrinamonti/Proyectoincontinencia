import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class PacientesList{
final Query<Map<String, dynamic>> userslist = FirebaseFirestore.instance.collection('Usuario').where("TipoUsuario", isEqualTo: "Paciente");

Future getUsersList () async {
    List itemslist= [];
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
