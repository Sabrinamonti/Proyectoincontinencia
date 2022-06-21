import 'package:flutter/material.dart';
import 'package:loginpage/MedicPage/BottombarMedic.dart';
import 'package:loginpage/MedicPage/LinechartsPage.dart';
import 'package:loginpage/MedicPage/homepageMed.dart';
import 'package:loginpage/MedicPage/tablechartPage.dart';


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
            title: const Text('Resultados'),
            automaticallyImplyLeading: false,
            backgroundColor: const Color(0xff5808e5),
            leading: 
            IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.push(context, 
                MaterialPageRoute(builder: (context) => const BottomBar()));
              },
            ),
            bottom: const TabBar(
              indicatorColor: Colors.white,
              tabs: [
                Tab(text: 'EMG', icon: Icon(Icons.table_chart)),
                Tab(text: 'Tratamientos Comp.', icon: Icon(Icons.graphic_eq_rounded)),
              ],
            ),
          ),
          body:  TabBarView(
            children:  [ 
              LineCharts(),
              CalendarEvents(),
            ],
          ),
        )
      ),
    ); 
  }
}

