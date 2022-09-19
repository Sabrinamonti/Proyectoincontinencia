import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:loginpage/PatientPage/EjerciciosPage.dart';
import 'package:loginpage/PatientPage/ProfilePagePatient.dart';
import 'package:loginpage/PatientPage/TareasPage.dart';
import 'package:loginpage/loginPage.dart';

class TabBarPaciente extends StatefulWidget {
  const TabBarPaciente({Key? key}) : super(key: key);

  @override
  State<TabBarPaciente> createState() => _TabBarPacienteState();
}

class _TabBarPacienteState extends State<TabBarPaciente> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            title: const Text('Bienvenido'),
            automaticallyImplyLeading: false,
            backgroundColor: Color.fromARGB(255, 58, 112, 86),
            leading: IconButton(
              icon: Icon(Icons.logout),
              onPressed: () async {
                await FirebaseAuth.instance.signOut();
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => LoginPage()));
              },
            ),
            bottom: const TabBar(tabs: [
              Tab(text: 'Ejercicios', icon: Icon(Icons.emoji_people_outlined)),
              Tab(text: 'Lista de Tareas', icon: Icon(Icons.checklist_rounded)),
              Tab(text: 'Perfil', icon: Icon(Icons.account_circle)),
            ]),
          ),
          body: const TabBarView(children: [
            Ejerciciospage(),
            TareasTratamientos(),
            ProfilePatient(),
          ]),
        ),
      ),
    );
  }
}
