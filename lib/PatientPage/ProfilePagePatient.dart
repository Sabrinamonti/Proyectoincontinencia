import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:loginpage/PatientPage/EditProfilePatientPage.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ProfilePatient extends StatefulWidget {
  const ProfilePatient({ Key? key }) : super(key: key);

  @override
  State<ProfilePatient> createState() => _ProfilePatientState();
}

class _ProfilePatientState extends State<ProfilePatient> {
  final FirebaseAuth auth = FirebaseAuth.instance;
  String inputData() {
    String usuario = "";
    final User? user = auth.currentUser;
    final uemail = user?.email;
    usuario = uemail.toString();
    return usuario;
    // here you write the codes to input the data into firestore
  }

  @override
  Widget build(BuildContext context) {

  final Datauser= auth.currentUser;
  final CollectionReference InfoPat = FirebaseFirestore.instance.collection('Usuario');

    return Scaffold(
      body: Column(
        children: [
          AppBar(
            backgroundColor: Colors.transparent,
            toolbarHeight: 10,
          ),
          const Center(
            child: Padding(
              padding: EdgeInsets.only(bottom: 20),
              child: Text('Perfil', 
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.w700, color: Color.fromRGBO(64, 105, 225, 1))),
            ),
          ),
          InkWell(
            onTap:() {

            },
            child: DisplayImage(
              imagePath: 'Assets/imageninicio/imageninicio.jpg',
              onPressed: () { print("el usuario es:" + inputData()); },
            ),
          ),
          FutureBuilder(
            future: InfoPat.doc(Datauser?.uid).get(),
            builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
              if(snapshot.connectionState == ConnectionState.done) {
                Map<String , dynamic> data = snapshot.data!.data() as Map<String, dynamic>;
                return buildUserInfoDisplay(data['Nombre'], 'Nombre Completo', EditNameFormPage());
              }
              return Text('Loading');
            }
          ),
          FutureBuilder(
            future: InfoPat.doc(Datauser?.uid).get(),
            builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
              if(snapshot.connectionState == ConnectionState.done) {
                Map<String , dynamic> data = snapshot.data!.data() as Map<String, dynamic>;
                return buildUserInfoDisplay(data['Telefono'], 'Telefono', EditNameFormPage());
              }
              return Text('Loading');
            }
          ),
          FutureBuilder(
            future: InfoPat.doc(Datauser?.uid).get(),
            builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
              if(snapshot.connectionState == ConnectionState.done) {
                Map<String , dynamic> data = snapshot.data!.data() as Map<String, dynamic>;
                return buildUserInfoDisplay(data['Email'], 'Email', EditNameFormPage());
              }
              return Text('Loading');
            }
          ),
        ],
      ),
      
    );
  }

  Widget buildUserInfoDisplay(String getValue, String title, Widget editPage) =>

  Padding(
    padding: const EdgeInsets.only(bottom: 10),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: const TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w500,
          color: Colors.grey,
        )),
        const SizedBox(height: 2),
        Container(
          width: 350,
          height: 40,
          decoration: const BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: Colors.grey,
                width: 1,
              )
            )
          ),
          child: Row(children: [
            Expanded(child: TextButton(
              onPressed: (){print("el usuario es:" + inputData());},
              child: Text(getValue, style: const TextStyle(fontSize: 16, height: 1.4)),
            )),
            Icon(Icons.keyboard_arrow_right, color: Colors.grey,size: 40)
          ],),
        )
      ],
    ),
  );
}
