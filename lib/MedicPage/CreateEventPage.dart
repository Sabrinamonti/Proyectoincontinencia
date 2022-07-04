import 'package:flutter/material.dart';
import 'package:loginpage/MedicPage/tablechartPage.dart';
import 'package:intl/intl.dart';
import 'package:loginpage/backend/BackendCalendario/event.dart';
import 'package:loginpage/backend/BackendCalendario/event_firebase.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:loginpage/MedicPage/tablechartPage.dart';

class Createevent extends StatefulWidget {
  const Createevent({Key? key}) : super(key: key);

  @override
  State<Createevent> createState() => _CreateeventState();
}

class _CreateeventState extends State<Createevent> {
  CollectionReference event = FirebaseFirestore.instance.collection('Evento');
  final _formkey = GlobalKey<FormState>();
  String titulo = '';
  String Descp = '';
  bool Cumplido = false;
  late DateTime startdate = DateTime.now();
  late DateTime enddate = DateTime(DateTime.now().year + 2);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Nueva Tarea'),
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          Form(
              key: _formkey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  TextFormField(
                    decoration: InputDecoration(
                      hintText: 'Titulo',
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                            color: Colors.lightGreen, width: 1.5),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                            color: Colors.lightGreen, width: 1.5),
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    validator: (val) => val!.isEmpty ? 'Ingrese Titulo' : null,
                    onChanged: (val) => {titulo = val},
                  ),
                  const SizedBox(height: 20.0),
                  TextFormField(
                    maxLines: 6,
                    decoration: InputDecoration(
                      hintText: 'Descripcion',
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                            color: Colors.lightGreen, width: 1.5),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                            color: Colors.lightGreen, width: 1.5),
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    validator: (val) =>
                        val!.isEmpty ? 'Ingrese Descripcion de tarea' : null,
                    onChanged: (val) => {Descp = val},
                  ),
                ],
              )),
          const SizedBox(height: 20.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Expanded(
                  child: buildDateField(
                      text: toDate(startdate),
                      onClicked: () => pickdatestart(PickDate: true),
                      header: 'Desde')),
              Expanded(
                  child: buildDateField(
                      text: toDate(enddate),
                      onClicked: () => pickdatend(PickDate: true),
                      header: 'Hasta')),
            ],
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () async {
            //_formkey.currentState?.save();
            if (_formkey.currentState!.validate()) {
              Map<String, dynamic> res = {
                'id': 'Pacientesopa',
                'titulo': titulo,
                'descripcion': Descp,
                'eventDate': startdate.millisecondsSinceEpoch,
                'cumplido': Cumplido,
              };
              final data = res;
              await eventDBS.create(data);
              print(data);
              Navigator.pop(context);
              return;
            }
          },
          child: const Text('Agregar'),
        ),
      ],
    );
  }

  static String toDate(DateTime datetime) {
    final date = DateFormat.yMMMEd('es_ES').format(datetime);

    return '$date';
  }

  Widget buildDateField({
    required String text,
    required VoidCallback onClicked,
    required String header,
  }) =>
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            header,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          ListTile(
            title: Text(text),
            trailing: Icon(Icons.arrow_drop_down),
            onTap: onClicked,
          ),
        ],
      );
  Future pickdatestart({required bool PickDate}) async {
    final date = await pickDateTime(startdate, pickdate: PickDate);
    if (date != null) {
      setState(() {
        startdate = date;
      });
    }
    print(startdate);
  }

  Future pickdatend({required bool PickDate}) async {
    final date = await pickDateTime(startdate, pickdate: PickDate);
    if (date != null) {
      setState(() {
        enddate = date;
      });
    }
    print(enddate);
  }

  Future<DateTime?> pickDateTime(DateTime initialDate,
      {required bool pickdate, DateTime? firstdate}) async {
    if (pickdate) {
      final date = await showDatePicker(
        context: context,
        initialDate: initialDate,
        firstDate: firstdate ?? DateTime.now(),
        lastDate: DateTime(
            DateTime.now().year + 2, DateTime.now().month, DateTime.now().day),
      );

      if (date == null) return null;

      return date;
    }
  }
}
