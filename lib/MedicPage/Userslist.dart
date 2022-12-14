import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:loginpage/MedicPage/homepageMed.dart';
import 'package:loginpage/backend/Userslistcode.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:rxdart/rxdart.dart';

class UsersList extends StatefulWidget {
  const UsersList({Key? key}) : super(key: key);

  @override
  State<UsersList> createState() => _UsersListState();
}

class _UsersListState extends State<UsersList> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  TextEditingController? _textEditingController = TextEditingController();
  List usuarioslista = [];
  List usersdata = [];
  List filterUsers = [];

  @override
  void initState() {
    super.initState();
    fetchdatabaselist();
  }

  fetchdatabaselist() async {
    dynamic resultant = await DatabaseManagement().gerUsersList();
    if (resultant == null) {
      print('No se puede obtener la informacion');
    } else {
      setState(() {
        usersdata = resultant;
        usuarioslista = usersdata;
      });
    }
  }

  Future onSlide(int index) async {
    final Datauser = _auth.currentUser;
    final ets = usuarioslista[index]['Id'];
    final patsid =
        FirebaseFirestore.instance.collection('Usuario').doc(Datauser?.uid);
    final medsid = FirebaseFirestore.instance.collection('Usuario').doc(ets);
    setState(() {
      usuarioslista.removeAt(index);
      patsid.update({
        'PacsId': FieldValue.arrayUnion([ets])
      }).then((value) => print("UsedAdded"));
      medsid.update({
        'Profs': FieldValue.arrayUnion([Datauser?.uid])
      }).then((value) => print('MedAdded'));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple[300],
        title: Container(
          decoration: BoxDecoration(
            color: Colors.deepPurple[100],
            borderRadius: BorderRadius.circular(25),
          ),
          child: TextField(
            onChanged: (value) {
              setState(() {
                usuarioslista = usersdata
                    .where((element) => element
                        .toString()
                        .toLowerCase()
                        .contains(value.toLowerCase()))
                    .toList();
              });
              print(usuarioslista);
              print(
                  "cantidad de pacientes: " + usuarioslista.length.toString());
              filterUsers = usuarioslista;
            },
            controller: _textEditingController,
            decoration: InputDecoration(hintText: 'Buscar Paciente'),
          ),
        ),
        leading: ElevatedButton(
          style: ElevatedButton.styleFrom(primary: Colors.purple[200]),
          child: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const homePage()));
          },
        ),
      ),
      body: Container(
        child: ListView.builder(
            itemCount: _textEditingController!.text.isNotEmpty
                ? usuarioslista.length
                : usersdata.length,
            itemBuilder: (context, index) {
              final item = usersdata[index];
              return Slidable(
                  startActionPane: ActionPane(
                    motion: const ScrollMotion(),
                    children: [
                      SlidableAction(
                        onPressed: (context) => onSlide(index),
                        backgroundColor: Colors.green,
                        foregroundColor: Colors.white,
                        icon: Icons.plus_one,
                        label: 'Agregar',
                      )
                    ],
                  ),
                  child: Card(
                    child: ListTile(
                      title: Text(usuarioslista[index]['Nombre']),
                      subtitle: Text(usuarioslista[index]['Telefono']),
                      leading: const CircleAvatar(
                        child: Image(
                          image: AssetImage(
                              'assets/imageninicio/imageninicio.jpg'),
                        ),
                      ),
                    ),
                  ));
            }),
      ),
    );
  }
}
