import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class TareasTratamientos extends StatefulWidget {
  const TareasTratamientos({ Key? key }) : super(key: key);

  @override
  State<TareasTratamientos> createState() => _TareasTratamientosState();
}

class _TareasTratamientosState extends State<TareasTratamientos> {

  List tareaslista=[];
  //List tareas =[];

  @override
  void initState() {
    super.initState();
    fetchdatabaselist();
  }

  fetchdatabaselist() async {
    dynamic resultant = await DatabaseManage().getTasks();
    if(resultant == null) {
      print('No se puede obtener la informacion');
    } else {
      setState(() {
        tareaslista = resultant;
      });
    }
  }
   onSlide(int index){
      setState(() => tareaslista.removeAt(index));
    }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tareas de HOY'), 
        backgroundColor: Colors.redAccent,
      ),
      body: Container(
        child: ListView.builder(
          itemCount: tareaslista.length,
          itemBuilder: (context, index) {
            final item = tareaslista[index];
            return Slidable(
              startActionPane: ActionPane(
                motion: const ScrollMotion(),
                children: [
                  SlidableAction(
                    onPressed: (context) => onSlide(index),
                    backgroundColor: Color.fromARGB(255, 17, 165, 11),
                    foregroundColor: Colors.white,
                    icon: Icons.check_circle,
                    label: 'Cumplido',
                  )
                ],
              ),
              child: Card(
              child: ListTile(
                title: Text(tareaslista[index]['Nombre'], style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                subtitle: Text(tareaslista[index]['Telefono']),
                leading: Icon(Icons.task_alt),
                onTap: (){},
              ),
            ));
          }
        ),
      ),
    );
  }
}

class DatabaseManage {
  final CollectionReference TareasList = FirebaseFirestore.instance.collection('Usuario');

  Future getTasks () async {
    List tasks= [];
    try {
      await TareasList.get().then((value) {
        value.docs.forEach((element) {
          tasks.add(element.data());
        });
      });
      return tasks;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}