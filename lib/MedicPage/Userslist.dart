import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:loginpage/backend/Userslistcode.dart';

class UsersList extends StatefulWidget {
  const UsersList({ Key? key }) : super(key: key);

  @override
  State<UsersList> createState() => _UsersListState();
}

class _UsersListState extends State<UsersList> {
  TextEditingController? _textEditingController = TextEditingController();
  List usuarioslista=[];
  List usersdata =[];

  @override
  void initState() {
    super.initState();
    fetchdatabaselist();
  }

  fetchdatabaselist() async {
    dynamic resultant = await DatabaseManagement().gerUsersList();
    if(resultant == null) {
      print('No se puede obtener ls informacion');
    } else {
      setState(() {
        usersdata = resultant;
      });
    }
  }
  bool press= false;

  void Press (int index) {
      setState(() {
        press =!press;
        press? Text('Eliminar') : Text('Agregar');
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
            onChanged: (value){
              setState(() {
                usuarioslista = usersdata.where((element) 
                => element.toString().toLowerCase().contains(value.toLowerCase())).toList();
              });
              print(usuarioslista);
            },
            controller: _textEditingController,
            decoration: InputDecoration(
              hintText: 'Buscar Paciente'
            ),
          ),
        ),
      ),
      body: Container(
        child: ListView.builder(
          itemCount: _textEditingController!.text.isNotEmpty ? usuarioslista.length : usersdata.length,
          itemBuilder: (context, index) {
            final item = usersdata[index];
            return Card(
              child: ListTile(
                title: Text(usersdata[index]['Nombre']),
                subtitle: Text(usersdata[index]['Telefono']),
                leading: const CircleAvatar(
                  child: Image(
                    image: AssetImage('assets/imageninicio/imageninicio.jpg'),
                  ),
                ),
                //trailing: ElevatedButton(
                  //onPressed: () => Press(index), 
                  //child: Text(''),
                //),
              ),
            );
          }
        ),
      ),
    );
  }
}