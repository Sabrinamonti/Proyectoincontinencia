import 'package:flutter/material.dart';
import 'package:loginpage/loginPage.dart';

class Informacion {
  List<int> id = [1, 2, 3, 4];
  List<String> nombres = ['Sabrina', 'Luzi', 'Alejandra', 'Sophia'];
  List<String> Apellidos = ['Montaño', 'Tapia', 'Garcia', 'Amador'];
  List<int> numeroCel = [23454654, 2435435, 545433, 43432432];
  List<String> contrasena = ['S443gdd', 'T9382sjf', 'akkdur4', 'gjdhduvn88'];

}

class TecnicoPage extends StatefulWidget {
  const TecnicoPage({ Key? key }) : super(key: key);

  @override
  State<TecnicoPage> createState() => _TecnicoPageState();
}

class _TecnicoPageState extends State<TecnicoPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bienvenido'),
        backgroundColor: Colors.blue,
        leading: 
        IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.push(context, 
            MaterialPageRoute(builder: (context) => const LoginPage()));
          },
        ),
      ),
      body: Center(
        child: ListView(
          children: [
            Center(
              child: DataTable(
                sortAscending: true,
                columns:
                [
                  DataColumn(label: Text('Id')),
                  DataColumn(label: Text('Nombre')),
                  DataColumn(label: Text('Apellido')),
                  DataColumn(label: Text('Telefono')),
                  DataColumn(label: Text('Contrasena')),
                ], 
                rows: [
                  DataRow(
                    selected: true,
                    cells: [
                    DataCell(
                      Text('Sabri'),
                    ),

                  ])
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}