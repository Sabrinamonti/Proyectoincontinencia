import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:loginpage/MedicPage/BottombarMedic.dart';
import 'package:loginpage/MedicPage/homepageMed.dart';
import 'package:loginpage/PatientPage/Homepagepatient.dart';
import 'package:loginpage/TecnicoPage/TecnicoPage.dart';
import 'package:loginpage/signinPage.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final firestoreInstance = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String email = '';
  String password = '';

  Widget createTitleWelcome() {
    return Container(
      decoration: BoxDecoration(color: Colors.white),
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Text(
          'Bienvenido',
          textDirection: TextDirection.ltr,
          style: TextStyle(
            fontSize: 32,
            color: Colors.black87,
          ),
        ),
        Image.asset(
          'assets/imageninicio/imageninicio.jpg',
          width: 700,
          height: 300,
        ),
      ]),
    );
  }

  Widget createUsernameInput(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
          color: Color.fromARGB(255, 141, 188, 212),
          borderRadius: BorderRadius.circular(40)),
      child: TextFormField(
        decoration: InputDecoration(
            icon: Icon(
              Icons.person,
              color: Colors.white,
            ),
            hintText: 'Ingrese su Nombre de usuario'),
        onChanged: (val) {
          email = val;
        },
      ),
    );
  }

  Widget createPasswordInput() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
          color: Colors.blueGrey, borderRadius: BorderRadius.circular(40)),
      child: TextFormField(
        decoration: InputDecoration(
            icon: Icon(Icons.lock, color: Colors.white),
            hintText: 'Ingrese Contraseña'),
        obscureText: true,
        onChanged: (val) {
          password = val;
        },
      ),
    );
  }

  Widget createLoginButton(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 32),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: Colors.blue,
          onPrimary: Colors.white,
          minimumSize: Size(120, 50),
        ),
        child: Text('Iniciar Session'),
        onPressed: () async {
          try {
            await _auth.signInWithEmailAndPassword(
                email: email, password: password);
            ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Se ingreso exitosamente')));
            final Datauser = _auth.currentUser;
            CollectionReference documents =
                FirebaseFirestore.instance.collection('Usuario');
            DocumentSnapshot snapshot =
                await documents.doc(Datauser?.uid).get();
            var data = snapshot.data() as Map;
            var typeuser = data['TipoUsuario'];

            if (Datauser?.email == email && typeuser == "Paciente") {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const TabBarPaciente()));
            } else if (Datauser?.email == email && typeuser == "Medico") {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const BottomBar()));
            } else {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const TecnicoPage()));
            }
          } on FirebaseAuthException catch (e) {
            showDialog(
                context: context,
                builder: (ctx) =>
                    AlertDialog(title: Text('Ingrese los datos correctos')));
          }
        },
      ),
    );
  }

  Widget createAccount(BuildContext context) {
    return Container(
        padding: EdgeInsets.only(top: 30),
        child: Center(
          child: TextButton(
            child: Text(
              'Crear nueva cuenta',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const SignupPage()),
              );
            },
          ),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 30),
          //margin: const EdgeInsets.all(30),
          //decoration: BoxDecoration(color: Colors.white),
          children: [
            Column(children: [
              createTitleWelcome(),
              createUsernameInput(context),
              createPasswordInput(),
              createLoginButton(context),
              createAccount(context),
            ]),
          ]),
    );
  }
}
