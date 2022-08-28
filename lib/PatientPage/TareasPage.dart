import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:loginpage/backend/Tareaslist.dart';

class TareasTratamientos extends StatefulWidget {
  const TareasTratamientos({Key? key}) : super(key: key);

  @override
  State<TareasTratamientos> createState() => _TareasTratamientosState();
}

class _TareasTratamientosState extends State<TareasTratamientos> {
  List tareaslista = [];
  //List tareas =[];

  @override
  void initState() {
    super.initState();
    fetchdatabaselist();
  }

  fetchdatabaselist() async {
    dynamic resultant = await DBtareas().getTasks();
    if (resultant == null) {
      print('No se puede obtener la informacion');
    } else {
      setState(() {
        tareaslista = resultant;
      });
    }
  }

  onSlide(int index) async {
    final check = tareaslista[index]['idEvento'];
    bool completado = true;
    final cambioevento =
        FirebaseFirestore.instance.collection("Evento").doc(check);
    setState(() {
      tareaslista.removeAt(index);
      cambioevento.update({'cumplido': completado});
    });
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
                  child: Builder(builder: (BuildContext context) {
                    final fecha = tareaslista[index]['eventDate'];
                    DateTime fechadt =
                        DateTime.fromMillisecondsSinceEpoch(fecha);
                    DateTime fechahoy = DateTime(DateTime.now().year,
                        DateTime.now().month, DateTime.now().day);
                    if (fechadt == fechahoy) {
                      return Card(
                        child: ListTile(
                          title: Text(tareaslista[index]['titulo'],
                              style: const TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold)),
                          subtitle: Text(tareaslista[index]['descripcion']),
                          leading: Icon(Icons.task_alt),
                          onTap: () {},
                        ),
                      );
                    }
                    return Column();
                  }));
            }),
      ),
    );
  }
}
