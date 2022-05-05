import 'package:flutter/material.dart';
import 'package:loginpage/LinechartsPage.dart';
import 'package:loginpage/medicPage.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:loginpage/tablechartPage.dart';


class tablaspageMed extends StatefulWidget {
  const tablaspageMed({ Key? key }) : super(key: key);

  @override
  State<tablaspageMed> createState() => _tablaspageMedState();
}

class _tablaspageMedState extends State<tablaspageMed> {



  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            title: const Text('Fixed Tabs'),
            automaticallyImplyLeading: false,
            backgroundColor: const Color(0xff5808e5),
            bottom: const TabBar(
              indicatorColor: Colors.white,
              tabs: [
                Tab(text: 'Tablas', icon: Icon(Icons.table_chart)),
                Tab(text: 'Graficos', icon: Icon(Icons.graphic_eq_rounded)),
              ],
            ),
          ),
          body: const TabBarView(
            children:  [ 
              LineChartSample2(),
              ShowCalendarEventPage(),
            ],
          ),
        )
      ),
    ); 
  }
}

