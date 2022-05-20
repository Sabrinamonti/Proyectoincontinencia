import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:loginpage/MedicPage/BottombarMedic.dart';
import 'package:loginpage/MedicPage/Userslist.dart';
import 'package:loginpage/MedicPage/TablasPageMed.dart';
import 'package:loginpage/MedicPage/Userslist.dart';
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
  final _auth = FirebaseAuth.instance.currentUser;
  var items = [];

  void buscarnombre (String value) {
    setState(() {
      
    });
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
          onChanged: (value) => buscarnombre(value),
        ),
        Expanded(
          child: 
          ListView.builder(
          itemCount: names.length,
          shrinkWrap: true,
          itemBuilder: (BuildContext context, int index) => 
          Container(
           // width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            child: 
            Listitem(context, index),
            ),
          )
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


Widget Listitem (BuildContext context, int index) {

  return Card (
    child:  ListTile(
            shape: RoundedRectangleBorder(
               borderRadius: BorderRadius.circular(10),
              ),
              title:Text(
                names[index], 
                style: const TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold)
              ),
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

class MySearch extends SearchDelegate {

  final List<String> names;
  List<String> _filter =[];
  MySearch(this.names);

  @override 
  Widget? buildLeading(BuildContext context) {
    return
    IconButton(
    onPressed: () => close(context, null), 
    icon: const Icon(Icons.arrow_back));
  }

  @override 
  List<Widget>? buildActions(BuildContext context) {
    return [
    IconButton(
      onPressed: () {
        if(query.isEmpty) {
          close(context, null);
        } else {
        query = '';
        }
      }, 
      icon: const Icon(Icons.clear))
    ];
  }

  @override 
  Widget buildResults(BuildContext context) { 
    final List<String> nombres = names.where((Nombre) => Nombre.toLowerCase().contains(
      query.toLowerCase(),
      ),
    ).toList();

    return ListView.builder(
      itemCount: nombres.length,
      itemBuilder: (context, index) => ListTile(title: Text(nombres[index]),)
      );
  }

  @override 
  Widget buildSuggestions(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      child: Text('Busca el nombre del paciente', 
      ),
    );
  }

}