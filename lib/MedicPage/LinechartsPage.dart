import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:intl/intl.dart';
import 'package:collection/collection.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

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
  List<dynamic> itemslist = [];
  List<Datapoints> _charData = <Datapoints>[];
  TooltipBehavior _tooltipBehavior = TooltipBehavior(enable: true);

  @override
  void initState() {
    getDataFB().then((value) {
      SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
        setState(() {});
      });
    });
    //_charData = getcharData();
    _tooltipBehavior = TooltipBehavior(enable: true);
    super.initState();
  }

  List<Datapoints> get _data {
    final data = <double>[2, 9, 6, 1, 10];
    final DocmentStream = FirebaseFirestore.instance
        .collection('sensor')
        .doc('lHLQ1EncUCX8aNYsUXnS7HpKv963')
        .collection('calibrar')
        .doc('sensor')
        .collection('data')
        .where('fechamax', isEqualTo: "10/6/2022")
        .limit(5)
        .get()
        .then((value) {
      for (var element in value.docs) async {
        itemslist.add(element.data()['emg']);
      }
    });
    return itemslist
        .mapIndexed(
            (index, element) => Datapoints(val: index.toDouble(), dia: element))
        .toList();
  }

  Future<void> getDataFB() async {
    List fechas = [];
    String dates;
    final DateTime now = DateTime.now();
    final String formatter = DateFormat.yMd().format(now);
    for (int i = 0; i < 10; i++) {
      dates = DateFormat.yMd().format(DateTime(
          DateTime.now().year, DateTime.now().month, DateTime.now().day - i));
      fechas.add(dates);
    }
    print(fechas);
    print(widget.value);
    var snapShotValue = await FirebaseFirestore.instance
        .collection('sensor')
        .doc(widget.value)
        .collection('Ejercicio')
        .doc('sensor')
        .collection('valormax')
        .where('fecha', whereIn: fechas)
        //.limit(5)
        .get();
    List<Datapoints> list = snapShotValue.docs
        .map((e) => Datapoints(val: e.data()['emg'], dia: e.data()['fecha']))
        .toList();
    setState(() {
      _charData = list;
    });
  }

  /*List<Datapoints> getcharData() {
    final List<Datapoints> charData = [
      Datapoints(val: 50, dia: '10/14/2022'),
      Datapoints(val: 78, dia: '10/15/2022'),
      Datapoints(val: 65, dia: '10/16/2022'),
      Datapoints(val: 84, dia: '10/17/2022'),
      Datapoints(val: 23, dia: '10/18/2022'),
      Datapoints(val: 23, dia: '10/19/2022'),
      Datapoints(val: 23, dia: '10/20/2022'),
      Datapoints(val: 23, dia: '10/21/2022'),
      Datapoints(val: 23, dia: '10/22/2022')
    ];
    return charData;
  }*/

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(20),
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(45)),
        ),
        child: PageView(
          scrollDirection: Axis.horizontal,
          children: [
            //Text("Se mostraran los resultados"),
            AspectRatio(
              aspectRatio: 20,
              child: SfCartesianChart(
                title: ChartTitle(text: "Tabla de Resultados"),
                tooltipBehavior: _tooltipBehavior,
                primaryXAxis: CategoryAxis(labelRotation: 45),
                series: <ChartSeries<Datapoints, String>>[
                  ColumnSeries<Datapoints, String>(
                      name: 'EMG',
                      dataSource: _charData,
                      xValueMapper: (Datapoints sales, _) => sales.dia,
                      yValueMapper: (Datapoints sales, _) => sales.val,
                      dataLabelSettings: const DataLabelSettings(isVisible: true),
                      enableTooltip: true)
                ],
                primaryYAxis: NumericAxis(labelFormat: '{value}V'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /*Widget content() {
    return charts.LineChart(
      charts.LineChartData(
          backgroundColor: const Color.fromARGB(255, 15, 32, 47),
          gridData: charts.FlGridData(
            show: true,
            getDrawingHorizontalLine: (value) {
              return charts.FlLine(
                color: const Color(0xff37434d),
                strokeWidth: 1,
              );
            },
            drawVerticalLine: false,
          ),
          titlesData: charts.FlTitlesData(
            show: true,
            rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
            topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
            bottomTitles: AxisTitles(
                sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 30,
              interval: 1,
              getTitlesWidget: bottomTitleWidgets,
            )),
          ),
          borderData: charts.FlBorderData(
              show: true,
              border: Border.all(color: const Color(0xff37434d), width: 1)),
          lineBarsData: [
            charts.LineChartBarData(
                spots: _data
                    .map((point) => charts.FlSpot(point.val, point.dia))
                    .toList(),
                isCurved: false,
                barWidth: 5,
                belowBarData: charts.BarAreaData(
                  show: true,
                  //color: gradientColors.withOpacity(0.3),
                ))
          ]),
    );
  }*/
}

class Datapoints {
  final double val;
  final String dia;
  Datapoints({required this.val, required this.dia});
  //factory Datapoints.fromMap(Map data) =>
  //new Datapoints(val: data['emg'], dia: data['fecha']);

  /*Datapoints.fromMap(Map<String, dynamic> map)
      : assert(map['val'] != null),
        assert(map['dia'] != null),
        val = map['val'],
        dia = map['dia'];

  @override
  String toString() => "Record<$val:$dia>";*/
}

Widget bottomTitleWidgets(double value, TitleMeta meta) {
  const style = TextStyle(
    color: Color(0xff68737d),
    fontWeight: FontWeight.bold,
    fontSize: 16,
  );
  List fechas = [
    "1/10/22",
    "3/10/2022",
    "5/10/2022",
  ];
  int largo = fechas.length;
  Widget text = Container();
  for (int i = 0; i <= largo + 1; i++) {
    text = Text("HOLA $i", style: style);
  }

  return SideTitleWidget(
    axisSide: meta.axisSide,
    space: 8.0,
    child: text,
  );
}

Widget leftTitleWidgets(double value, TitleMeta meta) {
  const style = TextStyle(
    color: Color(0xff67727d),
    fontWeight: FontWeight.bold,
    fontSize: 15,
  );
  String text;
  switch (value.toInt()) {
    case 1:
      text = '10K';
      break;
    case 3:
      text = '30k';
      break;
    case 5:
      text = '50k';
      break;
    default:
      return Container();
  }

  return Text(text, style: style, textAlign: TextAlign.left);
}
