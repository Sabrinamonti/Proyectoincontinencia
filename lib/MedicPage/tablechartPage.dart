import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:calendar_view/calendar_view.dart';
import 'package:loginpage/MedicPage/CreateEventPage.dart';
import 'package:loginpage/MedicPage/TablasPageMed.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';

import '../backend/CalendarioMed.dart';

class CalendarEvents extends StatefulWidget {
  const CalendarEvents({ Key? key }) : super(key: key);

  @override
  State<CalendarEvents> createState() => _CalendarEventsState();
}

class _CalendarEventsState extends State<CalendarEvents> {
  CalendarFormat format = CalendarFormat.month;
  DateTime selectedDay = DateTime.now();
  DateTime focusedDay = DateTime.now();
  List eventos = [];

   
  @override
  void initState() {
    super.initState();
    fetchdatabaselist();
  }

  List _getEventsDelDia(DateTime date){
    return eventosBD[date]??[];
  }

  fetchdatabaselist() async {
    dynamic resultant = await CalendarioMed().getEvents();
    if(resultant == null) {
      print('No se puede obtener ls informacion');
    } else {
      setState(() {
        eventos = resultant;
        eventosBD = eventos as Map<DateTime, List>;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: SafeArea(
          child: TableCalendar(
            focusedDay: selectedDay, 
            firstDay: DateTime.utc(2022,01,01), 
            lastDay: DateTime.utc(2023),
            locale: 'es_Es',
            calendarFormat: format,
            onFormatChanged: (CalendarFormat _format){
              setState((){
                format = _format;
              });
            },
            startingDayOfWeek: StartingDayOfWeek.monday,
            onDaySelected: (DateTime selectDay, DateTime focusDay){
              setState((){
                selectedDay = selectDay;
                focusedDay = focusDay;
              });
            },
            selectedDayPredicate: (DateTime date){
            return isSameDay(selectedDay, date);
          },
          eventLoader: _getEventsDelDia,
            calendarStyle: CalendarStyle(
              isTodayHighlighted: true,
              selectedDecoration: BoxDecoration(
                color: Colors.lightBlueAccent,
                shape: BoxShape.circle,
              ),
              selectedTextStyle: TextStyle(color: Colors.white,
            ),
          ),
        ),
      )
      )
    );
  }
  
}