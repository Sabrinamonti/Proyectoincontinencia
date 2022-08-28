import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DBtareas {
  final _now =
      DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day)
          .millisecondsSinceEpoch;
  //final DateTime _start = DateTime(_now.year, _now.month, _now.day, 0, 0);

  final Query<Map<String, dynamic>> tareaslist =
      FirebaseFirestore.instance.collection('Evento');

  Future getTasks() async {
    List tasks = [];
    try {
      await tareaslist.get().then((value) {
        value.docs.forEach((element) {
          tasks.add(element.data());
        });
      });
      return tasks;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
