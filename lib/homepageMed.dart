import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:loginpage/TablasPageMed.dart';
import 'package:loginpage/loginPage.dart';
import 'package:loginpage/medicPage.dart'; 

 List<String> names = ['Sabrina', 'Luzi', 'Alejandra', 'Sophia'];

class homePage extends StatefulWidget {
  const homePage({ Key? key }) : super(key: key);

  @override
  State<homePage> createState() => _homePageState();
}

class _homePageState extends State<homePage> {

  var items = [];

  @override
  //Void initState() {
    //items.addAll(names);
    //super.initState();
  //}
  void filterSearchResults(String query) {
    List<String> dummySearchList = [];
    dummySearchList.addAll(names);
    if(query.isNotEmpty) {
      List<String> dummyListData = [];
      dummySearchList.forEach((item) {
        if(item.contains(query)) {
          dummyListData.add(item);
        }
      });
      setState(() {
        items.clear();
        items.addAll(dummyListData);
      });
      return;
    } else {
      setState(() {
        items.clear();
        items.addAll(names);
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
        IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.push(context, 
            MaterialPageRoute(builder: (context) => const LoginPage()));
          },
        ),
      ),
      body:
      Column(
        children: [
          SizedBox(width: 10, height: 10,),
        TextField(
          decoration: InputDecoration(
            hintText: 'Buscar el Nombre del Paciente',
            prefixIcon: Icon(Icons.search),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(29))
            )
          ),
          onChanged: (value) {
           filterSearchResults(value);
          },
        ),
        Expanded(
          child:
          ListView.builder(
          itemCount: names.length,
          shrinkWrap: true,
          itemBuilder: (BuildContext context, int index) => Container(
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            child: 
            Listitem(context, index),
            ),
          )
        )
        ],
      )
    );
  }
}


Widget Listitem (BuildContext context, int index) {

  return Container(
    child:  Card(
            elevation: 5,
            shape: RoundedRectangleBorder(
               borderRadius: BorderRadius.circular(10),
              ),
              child: Container(
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: 55,
                      height: 55,
                      child: CircleAvatar(
                        backgroundColor: CupertinoColors.systemPurple,
                        foregroundColor: Colors.white,
                        //backgroundImage: ,
                      ),
                    ),
                    SizedBox(width: 5,),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(names[index], style: const TextStyle(color: Colors.black,
                        fontSize: 18, fontWeight: FontWeight.bold)
                        ),
                      ],
                    ),
                    Container(
                      alignment: Alignment.center,
                      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                        primary: Color.fromARGB(255, 20, 136, 78),
                        onPrimary: Colors.white,
                        minimumSize: Size(50, 50),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      child: const Text('Ver informacion'), 
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const tablaspageMed()),
                          );
                        },
                      ),
                    )
                  ],
                ),
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