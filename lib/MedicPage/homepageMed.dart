import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:loginpage/MedicPage/BottombarMedic.dart';
import 'package:loginpage/MedicPage/Userslist.dart';
import 'package:loginpage/MedicPage/TablasPageMed.dart';
import 'package:loginpage/MedicPage/Userslist.dart';
import 'package:loginpage/backend/PacientesList.dart';
import 'package:loginpage/loginPage.dart'; 
import 'package:firebase_auth/firebase_auth.dart';
import 'package:loginpage/MedicPage/profileinfoMed.dart';

 List<String> names = ['Sabrina', 'Luzi', 'Alejandra', 'Sophia'];

class homePage extends StatefulWidget {
  const homePage({ Key? key }) : super(key: key);

  @override
  State<homePage> createState() => _homePageState();
}

class _homePageState extends State<homePage> {
  TextEditingController? _textEditingController = TextEditingController();
  List Pacienteslista=[];
  final _auth = FirebaseAuth.instance.currentUser;
  List items = [];
  List datospacientes = [];

  @override
  void initState() {
    super.initState();
    fetchdatabaselist();
  }

  fetchdatabaselist() async {
    dynamic resultant = await PacientesList().GetUserId();
    if(resultant == null) {
      print('No se puede obtener ls informacion');
    } else {
      setState(() {
        items = resultant;
        datospacientes = items;
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bienvenido'),
        backgroundColor: Colors.blue,
        leading: 
        ElevatedButton(
          child: const Icon(Icons.logout),
          onPressed: (){
            FirebaseAuth.instance.signOut();
            Navigator.push(context, 
            MaterialPageRoute(builder: (context) => const LoginPage()));
          }, 
        )
      ),
      body:
      Column(
        children: [
          SizedBox(height: 10),
        TextField(
          decoration: const InputDecoration(
            hintText: 'Buscar el Nombre del Paciente',
            prefixIcon: Icon(Icons.search),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(29))
            )
          ),
          onChanged: (value){
              setState(() {
                datospacientes = items.where((element) 
                => element.toString().toLowerCase().contains(value.toLowerCase())).toList();
              });
              //filterUsers = usuarioslista;
            },
          controller: _textEditingController,
        ),
        Expanded(
          child: 
          ListView.builder(
          itemCount: _textEditingController!.text.isNotEmpty ? datospacientes.length : items.length,
          shrinkWrap: true,
          itemBuilder: (BuildContext context, int index) {
            return Card(
              child: ListTile(
                shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
                ),
                title:Text(
                  datospacientes[index]['Nombre'], 
                  style: const TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold)
                ),
                subtitle: Text(datospacientes[index]['Telefono']),
                leading: const CircleAvatar(
                  backgroundColor: CupertinoColors.systemPurple,
                  foregroundColor: Colors.white,
                  //backgroundImage: ,
                ),
                trailing: ElevatedButton(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: ((context) => tablaspageMed())));
                  }, 
                  child: Text('Ver informacion'), 
                ),
              ),
            );
          }
        ),
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.push(context, 
            MaterialPageRoute(builder: (context) => const UsersList()));
          }, 
          child: Text('Agregar Paciente')
        ),
        //BottomBar(),
        ],
      )
    );
  }
}
