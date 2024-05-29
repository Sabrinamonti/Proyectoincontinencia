import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DBtareas {
  final _now =
      DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day)
          .millisecondsSinceEpoch;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  //final DateTime _start = DateTime(_now.year, _now.month, _now.day, 0, 0);

  Future getTasks() async {
    final currentuser = _auth.currentUser;
    final Query<Map<String, dynamic>> tareaslist = FirebaseFirestore.instance
        .collection('Evento')
        .where('cumplido', isEqualTo: false)
        .where('id', isEqualTo: currentuser?.uid);
    List tasks = [];
    try {
      await tareaslist.get().then((value) {
        for (var element in value.docs) {
          tasks.add(element.data());
        }
      });
      return tasks;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
