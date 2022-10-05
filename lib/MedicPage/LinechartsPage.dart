import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fl_chart/fl_chart.dart' as charts;
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:intl/intl.dart';
import 'package:loginpage/MedicPage/LineBar.dart';
import 'package:loginpage/MedicPage/statcontroller.dart';
import 'package:loginpage/backend/CodeEjercicio1.dart';
import 'package:collection/collection.dart';

class LineCharts extends StatefulWidget {
  final String value;
  const LineCharts({
    Key? key,
    required this.value,
  }) : super(key: key);

  @override
  State<LineCharts> createState() => _LineChartsState();
}

class _LineChartsState extends State<LineCharts> {
  final fromDate = DateTime(2022, 09, 22);
  final toDate = DateTime.now();
  List usersdata = [];
  List itemslist = [];

  Future Getvals() async {
    Query<Map<String, dynamic>> dayslist = FirebaseFirestore.instance
        .collection('sensor')
        .doc('lHLQ1EncUCX8aNYsUXnS7HpKv963')
        .collection('Ejercicio')
        .doc('sensor')
        .collection('valormax');
    //for (int i = 0; i <= 30; i++) {
    var today =
        DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);
    String formatted = DateFormat.yMd().format(today);
    dayslist = dayslist.where('fecha', isEqualTo: "9/29/2022");
    //}
    try {
      await dayslist.get().then((value) => {
            value.docs.forEach((element) {
              itemslist.add(element.data());
            })
          });
      return itemslist;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  List<Datapoints> get _data {
    final data = <double>[2, 4, 6, 8, 10];
    return data
        .mapIndexed(
            (index, element) => Datapoints(val: index.toDouble(), dia: element))
        .toList();
  }

  _generatedata() {
    var lineData = [
      //Datapoints(val: 34.8, dia: "Lunes"),
      //Datapoints(val: 54.2, dia: "Martes"),
      //Datapoints(val: 98.45, dia: "Miercoles"),
      //Datapoints(val: 35.12, dia: "Jueves"),
      //Datapoints(val: 64.75, dia: "Viernes"),
    ];
  }

  @override
  void initState() {
    super.initState();
    fetchdatabaselist();
    _generatedata();
  }

  fetchdatabaselist() async {
    dynamic resultant = await fechaval().Getvals();
    if (resultant == null) {
      print('No se puede obtener la informacion');
    } else {
      setState(() {
        //usersdata = resultant;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    List x = [1, 2, 3, 4, 5, 6, 7];
    List y = [2, 4, 6, 8, 10, 12, 14];
    return Scaffold(
        body: Container(
            child: PageView(
      children: <Widget>[
        Text("Se mostraran las tablas"),
        SizedBox(
          height: 10,
        ),
        Container(
            child: charts.LineChart(
          charts.LineChartData(
              minX: 0,
              maxX: 11,
              minY: 0,
              maxY: 5,
              lineBarsData: [
                charts.LineChartBarData(spots: [
                  charts.FlSpot(0, 3),
                  charts.FlSpot(2.6, 6),
                  charts.FlSpot(3.2, 2.5),
                  charts.FlSpot(4.3, 4),
                  charts.FlSpot(5, 1),
                ])
              ]),
        ))
      ],
    )));
  }
}

class Datapoints {
  double val;
  double dia;
  Datapoints({required this.val, required this.dia});

  /*Datapoints.fromMap(Map<String, dynamic> map)
      : assert(map['val'] != null),
        assert(map['dia'] != null),
        val = map['val'],
        dia = map['dia'];

  @override
  String toString() => "Record<$val:$dia>";*/
}
