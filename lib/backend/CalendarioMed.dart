import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class CalendarioMed{
  final Query<Map<String, dynamic>> eventsList = FirebaseFirestore.instance.collection('Evento');

  Future getEvents () async {
    List events= [];
    try {
      await eventsList.get().then((value) {
        value.docs.forEach((element) {
          events.add(element.data());
        });
      });
      return events;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}