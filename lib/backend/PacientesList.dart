import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class PacientesList {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future GetUserId() async {
    final currentuser = _auth.currentUser;
    CollectionReference documents =
        FirebaseFirestore.instance.collection('Usuario');
    DocumentSnapshot snapshot = await documents.doc(currentuser?.uid).get();
    var data = snapshot.data() as Map;
    var idpatuser = data['PacsId'] as List<dynamic>;
    List ids = [];
    for (var element in idpatuser) {
      ids.add(element);
    }

    final patientelist = FirebaseFirestore.instance
        .collection('Usuario')
        .where('Id', whereIn: ids);
    List itemslist = [];
    try {
      await patientelist.get().then((value) {
        for (var element in value.docs) {
          itemslist.add(element.data());
        }
      });
      return itemslist;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
