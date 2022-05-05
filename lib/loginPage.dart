import 'package:flutter/material.dart';
import 'package:loginpage/medicPage.dart';
import 'package:loginpage/signinPage.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({ Key? key }) : super(key: key);

  Widget createTitleWelcome() {
    return Container(
      decoration: BoxDecoration(color: Colors.white),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Bienvenido',
          textDirection: TextDirection.ltr,
          style: TextStyle(
            fontSize: 32,
            color: Colors.black87,
          ),
        ),
         Image.asset(
            'assets/imageninicio/imageninicio.jpg',
            width:700,
            height: 300,
          ),
      ]),
    );
  }
  
  Widget createUsernameInput(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return  Container(
            margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 141, 188, 212),
              borderRadius: BorderRadius.circular(40)
            ),
            child: TextFormField(
              decoration: 
                InputDecoration(
                  icon: Icon(
                    Icons.person, color: Colors.white,
                    ),
                  hintText: 'Ingrese Nombre de usuario'
                  ),
            ),
          );
  }

  Widget createPasswordInput() {
    return Container(
            margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            decoration: BoxDecoration(
              color: Colors.blueGrey,
              borderRadius: BorderRadius.circular(40)
            ),
            child: TextFormField(
              decoration: InputDecoration(
                icon: Icon(Icons.lock, 
                color: Colors.white),
                hintText: 'Ingrese Contraseña'
                ),
              obscureText: true,
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
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const MedicPage()),
          );
        },
    ));
  }


  Widget createAccount (BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 30),
      child: Center(
        child: TextButton( child: Text('Crear nueva cuenta', 
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
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 30),
        margin: const EdgeInsets.all(30),
        decoration: BoxDecoration(color: Colors.white),
        child: Column(children: [
          createTitleWelcome(),     
          createUsernameInput(context),
          createPasswordInput(),
          createLoginButton(context),
          createAccount(context),
        ]),
      ),
    );
  }
}

