import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class CalendarioMed {
  final String value;
  const CalendarioMed({
    Key? key,
    required this.value,
  });
  Future getEvents() async {
    final Query<Map<String, dynamic>> eventsList = FirebaseFirestore.instance
        .collection('Evento')
        .where('id', isEqualTo: value);
    List events = [];
    try {
      await eventsList.get().then((value) {
        for (var element in value.docs) {
          events.add(element.data());
        }
      });
      return events;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
