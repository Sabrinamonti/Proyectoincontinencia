import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class fechaval {
  Future Getvals() async {
    Query<Map<String, dynamic>> dayslist = FirebaseFirestore.instance
        .collection('sensor')
        .doc('1HLQ1EncUCX8aNYsUXnS7HpKv963')
        .collection('Ejercicio')
        .doc('sensor')
        .collection('valormax');
    for (int i = 0; i <= 30; i++) {
      var today = DateTime(
          DateTime.now().year, DateTime.now().month, DateTime.now().day - i);
      String formatted = DateFormat.yMd().format(today);
      dayslist = dayslist.where('fecha', isEqualTo: formatted);
    }
    List itemslist = [];
    try {
      await dayslist.get().then((value) => {
            value.docs.forEach((element) {
              itemslist.add(element.data());
            })
          });
      return itemslist;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
