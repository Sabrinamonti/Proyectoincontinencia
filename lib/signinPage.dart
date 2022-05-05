import 'package:flutter/material.dart';
import 'package:loginpage/loginPage.dart';

enum caracter {paciente, medico, tecnico}

class MyUtypeWidget extends StatefulWidget {
  const MyUtypeWidget({ Key? key }) : super(key: key);

  @override
  State<MyUtypeWidget> createState() => _MyUtypeWidgetState();
}

class _MyUtypeWidgetState extends State<MyUtypeWidget> {
  caracter? _character = caracter.paciente;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 10, bottom: 10),
      child: Row(
        children: [
          Expanded(child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.only(top: 1, bottom: 5),
                child: const Text('Marcar el tipo de Usuario'),
              ),
              ListTile(
          title: const Text('Paciente'),
          leading: Radio(
            value: caracter.paciente, 
            groupValue: _character, 
            onChanged: (caracter? value) {
              setState(() {
                _character= value;
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
              });
            }
          ),
        ),
        ListTile(
         title: const Text('Tecnico'),
          leading: Radio(
            value: caracter.tecnico, 
            groupValue: _character, 
            onChanged: (caracter? value) {
              setState(() {
                _character = value;
              });
            }
          ),
        ),
            ],
          ))
        ],
      ),
    );
  }
}

class SignupPage extends StatelessWidget {
  const SignupPage({ Key? key }) : super(key: key);

  Widget createtitle() {
    return Container(
      padding: EdgeInsets.only(top: 10),
      child: Text('Registro de nuevos usuarios', 
      style: TextStyle(fontWeight: FontWeight.bold, 
      color: Colors.black, 
      fontSize: 25),
      textAlign: TextAlign.center,
      ),
    );
  }

  Widget createnombre() {
    return Container(
      padding: const EdgeInsets.only(top: 10, bottom: 5),
      margin: const EdgeInsets.only(top: 30, bottom: 15),
      child: Row(
        children: [
          Expanded(child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.only(top: 1, bottom: 10),
                child: Text('Nombre Completo'),
              ),
              TextFormField(
              decoration: 
                InputDecoration(
                  icon: Icon(
                    Icons.person, color: Colors.lightBlueAccent,
                    ),
                  hintText: 'Ingrese Nombre de usuario'
                  ),
            ),
            ],
          ))
        ],
      ) 
    );
  }

  Widget createnumero() {
    return Container(
      padding: const EdgeInsets.only(top: 3, bottom: 15),
      margin: const EdgeInsets.symmetric(horizontal: 1, vertical: 0),
      decoration: BoxDecoration(
      color: Color.fromARGB(255, 120, 132, 138),
        //borderRadius: BorderRadius.circular(29)
      ),
      child: Row(
        children: [
          Expanded(child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.only(top: 1, bottom: 8),
                child: Text('Numero Telefónico',),
              ),
              TextFormField(
              decoration: 
                InputDecoration(
                  icon: Icon(
                    Icons.phone, color: Colors.lightBlueAccent,
                    ),
                  hintText: 'Ingrese su numero de telefono'
                  ),
            ),
            ],
          ))
        ],
      )
    );
  }

  Widget createcontra() {
    return Container(
      padding: const EdgeInsets.only(top: 5, bottom: 15),
      child: Row(
        children: [
          Expanded(child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.only(top: 1, bottom: 5),
                child: Text('Contraseña'),
              ),
              TextFormField(
              decoration: InputDecoration(
                icon: Icon(Icons.lock, 
                color: Colors.blueGrey
                ),
                hintText: 'Ingrese Contraseña'
                ),
              obscureText: true,
            ),
            ],
          ))
        ],
      )
    );
  }

  Widget createrecontra() {
    return Container(
      padding: const EdgeInsets.only(top: 5, bottom: 10),
      child: Row(
        children: [
          Expanded(child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.only(top: 1, bottom: 8),
                child: Text('Confirmar Contraseña'),
              ),
              TextFormField(
              decoration: InputDecoration(
                icon: Icon(Icons.lock, 
                color: Colors.blueGrey
                ),
                hintText: 'Ingrese Contraseña'
                ),
              obscureText: true,
            ),
            ],
          ))
        ],
      )
    );
  }
  
  Widget createbuttonsign(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 30),
      margin: const EdgeInsets.symmetric(horizontal: 1, vertical: 10),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: Colors.blue,
          onPrimary: Colors.white,
          minimumSize: Size(120, 50),
        ),
        child: const Text('Crear'), 
        onPressed: () {
          Navigator.push(context, 
            MaterialPageRoute(builder: (context) => const LoginPage())
            );
        },
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.push(context, 
            MaterialPageRoute(builder: (context) => const LoginPage())
            );
          },
        ),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        //margin: const EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
        children: [
          createtitle(),
          createnombre(),
          createnumero(),
          createcontra(),
          MyUtypeWidget(),
          createbuttonsign(context)
        ]),
      ),
    );
  }
}

