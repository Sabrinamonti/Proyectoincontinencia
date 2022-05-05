import 'package:flutter/material.dart';
import 'package:loginpage/homepageMed.dart';
import 'package:loginpage/medicPage.dart';

class alertaMed extends StatefulWidget {
  const alertaMed({ Key? key }) : super(key: key);

  @override
  State<alertaMed> createState() => _alertaMedState();
}

class _alertaMedState extends State<alertaMed> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Contraseña'),
      actions: [
        ElevatedButton(
          onPressed: () {
            Navigator.push(context, 
            MaterialPageRoute(builder: (context) => const MedicPage())
            );
          }, 
          child: Text('Aceptar'))
      ],
    );
  }
}
