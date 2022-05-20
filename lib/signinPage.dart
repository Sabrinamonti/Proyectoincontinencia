import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:loginpage/backend/logincode.dart';
import 'package:loginpage/loginPage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

enum caracter {paciente, medico, tecnico}
 


class SignupPage extends StatefulWidget {
  const SignupPage({ Key? key }) : super(key: key);

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  caracter? _character = null;
//final AuthService auth = AuthService();
final FirebaseAuth _auth = FirebaseAuth.instance;
final _formKey = GlobalKey<FormState>(); 

String username = '';
var telef = '';
String email = '';
String password= '';
String tipoUsuario = '';

  @override
  Widget build(BuildContext context) {
    CollectionReference users= FirebaseFirestore.instance.collection('Usuario');
    print(_character);
    return Scaffold(
      backgroundColor: Colors.green[200],
      appBar: AppBar(
        backgroundColor: Colors.green[400],
        title: const Text('Registro Nuevos Usuarios', style: TextStyle(color: Colors.white),),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.push(context, 
            MaterialPageRoute(builder: (context) => const LoginPage())
            );
          },
        ),
      ),
      body: ListView(
        
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        //margin: const EdgeInsets.all(10),
        children: [Form( 
          key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
          padding: const EdgeInsets.only(top: 0),
          child: const Text('Ingrese los datos', 
          style: TextStyle(fontWeight: FontWeight.bold, 
          color: Colors.black,
          fontSize: 25),
          textAlign: TextAlign.center,
          ),
        ),
        const SizedBox(height:20),
          Container(
            child: Row(
              children: [
                Expanded(child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.only(top: 1, bottom: 8),
                      child: Text('Nombre Completo', style: TextStyle(fontWeight: FontWeight.bold),),
                    ),
                    TextFormField(
                    decoration: 
                      const InputDecoration(
                        icon: Icon(
                          Icons.person, color: Colors.blueGrey,
                          ),
                        hintText: 'Ingrese Nombre de usuario'
                        ),
                        validator: (val) => val!.isEmpty ? 'Ingrese nombre' : null,
                        onChanged: (val) {
                          username = val;
                        },
                      ),
                    ],
                  ))
                ],
              )
            ),
        const SizedBox(height: 15),
          Container(
            child: Row(
              children: [
                Expanded(child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.only(top: 1, bottom: 8),
                      child: Text('Numero Telefónico', style: TextStyle(fontWeight: FontWeight.bold),),
                    ),
                    TextFormField(
                    decoration: 
                      const InputDecoration(
                        icon: Icon(
                          Icons.phone, color: Colors.blueGrey,
                          ),
                        hintText: 'Ingrese su numero de telefono'
                        ),
                        validator: (val) => val!.isEmpty ? 'Ingrese telefono' : null,
                        onChanged: (val) {
                          telef = val;
                        },
                      ),
                    ],
                  ))
                ],
              )
            ),
        const SizedBox(height: 15),
          Container(
            child: Row(
              children: [
                Expanded(child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.only(top: 1, bottom: 5),
                      child: Text('Email', style: TextStyle(fontWeight: FontWeight.bold),),
                    ),
                    TextFormField(
                    decoration: const InputDecoration(
                      icon: Icon(Icons.email, 
                      color: Colors.blueGrey
                      ),
                      hintText: 'Ingrese su Correo Electronico'
                      ),
                      validator: (val) => val!.isEmpty ? 'Ingrese email' : null,
                      onChanged: (val){
                        email= val;
                      },
                    ),
                  ],
                ))
              ],
            )
          ),
          const SizedBox(height: 15),
          Container(
            child: Row(
              children: [
                Expanded(child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.only(top: 1, bottom: 8),
                      child: Text('Contraseña', style: TextStyle(fontWeight: FontWeight.bold),),
                    ),
                    TextFormField(
                    decoration: const InputDecoration(
                      icon: Icon(Icons.lock, 
                      color: Colors.blueGrey
                      ),
                      hintText: 'Ingrese Contraseña'
                      ),
                    obscureText: true,
                    validator: (val) => val!.length < 6 ? 'Ingrese contraseña mayor a 6 valores' : null,
                    onChanged: (val){
                      password= val;
                    },
                    ),
                  ],
                ))
              ],
            )
          ),
          const SizedBox(height: 15),
          Container(
            child: Row(
              children: [
                Expanded(child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.only(top: 1, bottom: 0),
                      child: const Text('Marcar el tipo de Usuario', style: TextStyle(fontWeight: FontWeight.bold),),
                    ),
                    ListTile(
                      title: const Text('Paciente'),
                      leading: Radio(
                        value: caracter.paciente, 
                        groupValue: _character, 
                        onChanged: (caracter? value) {
                          setState(() {
                            _character= value;
                            tipoUsuario = 'Paciente';
                          });
                        },
                      ),
                    ),
                  ListTile(
                  title: const Text('Medico'),
                  leading: Radio(
                    value: caracter.medico, 
                    groupValue: _character, 
                    onChanged: (caracter? value) {
                      setState(() {
                      _character = value;
                      tipoUsuario = 'Medico';
                      });
                    }
                  )),
                ],
              ))
            ],
          ),
        ),
        const SizedBox(height: 20),
          Container(
            child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              primary: Colors.blue,
              onPrimary: Colors.white,
              minimumSize: Size(120, 50),
            ),
            child: const Text('Registrar'), 
            onPressed: () async {
              if(_formKey.currentState!.validate()) {
                //Store all data
                users
                .add({'Nombre': username, 'Telefono': telef, 'Email': email, 'Contrasena': password, 'TipoUsuario': tipoUsuario})
                .then((value) => print('Usuario Registrado'))
                .catchError((error)=> print('Ocurrio un error'));
                //firebaseautenticate
                try {
                  await _auth.createUserWithEmailAndPassword(email: email, password: password);
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Se registro exitosamente'),));
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const LoginPage()));
                } catch(e) {
                  print(e);
                }
              }
              },
            )
          )
        ])
        ),
      ]),
    );
  }

}

