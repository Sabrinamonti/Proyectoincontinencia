import 'package:flutter/material.dart';
import 'package:loginpage/MedicPage/TablasPageMed.dart';
import 'package:loginpage/MedicPage/homepageMed.dart';
import 'package:loginpage/MedicPage/tablechartPage.dart';
import 'package:intl/intl.dart';
import 'package:loginpage/backend/BackendCalendario/event.dart';
import 'package:loginpage/backend/BackendCalendario/event_firebase.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:loginpage/MedicPage/tablechartPage.dart';

class Createevent extends StatefulWidget {
  final String value;
  const Createevent({Key? key, required this.value}) : super(key: key);

  @override
  State<Createevent> createState() => _CreateeventState();
}

class _CreateeventState extends State<Createevent> {
  CollectionReference event = FirebaseFirestore.instance.collection('Evento');
  final _formkey = GlobalKey<FormState>();
  String titulo = '';
  String Descp = '';
  bool Cumplido = false;
  DateTimeRange dateRange = DateTimeRange(
      start: DateTime.now(), end: DateTime(DateTime.now().year + 2));

  @override
  Widget build(BuildContext context) {
    DateTime startdate = dateRange.start;
    DateTime enddate = dateRange.end;
    final duration = dateRange.duration;

    return AlertDialog(
      title: const Text('Nueva Tarea'),
      content: SingleChildScrollView(
        child: Column(
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
                      validator: (val) =>
                          val!.isEmpty ? 'Ingrese Titulo' : null,
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
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Expanded(
                    child: ElevatedButton(
                  onPressed: () => pickDateTime(),
                  child: const Text("Escoger Fechas"),
                  style: ElevatedButton.styleFrom(
                      primary: Color.fromARGB(255, 75, 131, 11)),
                )),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Expanded(
                    child: buildDateField(
                        text: toDate(startdate), header: 'Desde')),
                Expanded(
                    child:
                        buildDateField(text: toDate(enddate), header: 'Hasta')),
              ],
            ),
          ],
        ),
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
              CollectionReference ref =
                  await FirebaseFirestore.instance.collection('Evento');
              String docId = ref.doc().id;
              await ref.doc(docId).set({
                'id': widget.value,
                'titulo': titulo,
                'descripcion': Descp,
                'eventDate': startdate.millisecondsSinceEpoch,
                'cumplido': Cumplido,
                'idEvento': docId
              });
              final a = duration.inDays;
              for (var i = 0; i < a; i++) {
                final A = DateTime(
                    startdate.year, startdate.month, startdate.day + 1);
                CollectionReference refs =
                    await FirebaseFirestore.instance.collection('Evento');
                String docsId = refs.doc().id;
                await ref.doc(docsId).set({
                  'id': widget.value,
                  'titulo': titulo,
                  'descripcion': Descp,
                  'eventDate': A.millisecondsSinceEpoch,
                  'cumplido': Cumplido,
                  'idEvento': docsId
                });
                startdate = A;
              }
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          tablaspageMed(value: widget.value)));
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
          ),
        ],
      );

  Future<DateTime?> pickDateTime() async {
    DateTimeRange? date = await showDateRangePicker(
      context: context,
      firstDate: DateTime.now(),
      lastDate: DateTime(
          DateTime.now().year + 2, DateTime.now().month, DateTime.now().day),
    );

    if (date == null) return null;

    setState(() {
      dateRange = date;
    });
  }
}
