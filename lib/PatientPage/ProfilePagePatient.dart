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
          buildUserInfoDisplay('Sabri', 'Nombre Completo', EditNameFormPage()),
          buildUserInfoDisplay('Ale', 'Telefono', EditPhoneFormPage()),
          buildUserInfoDisplay('correo', 'Email', EditEmailFormPage()),
        ],
      ),
      
    );
  }

  Widget buildUserInfoDisplay(String getValue, String title, Widget editPage) =>
  Padding(
    padding: EdgeInsets.only(bottom: 10),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w500,
          color: Colors.grey,
        )),
        SizedBox(height: 2),
        Container(
          width: 350,
          height: 40,
          decoration: BoxDecoration(
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
              child: Text(getValue, style: TextStyle(fontSize: 16, height: 1.4)),
            )),
            Icon(Icons.keyboard_arrow_right, color: Colors.grey,size: 40)
          ],),
        )
      ],
    ),
  );
}