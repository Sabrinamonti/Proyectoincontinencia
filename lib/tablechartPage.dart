import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:calendar_view/calendar_view.dart';
import 'package:loginpage/TablasPageMed.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ShowCalendarEventPage extends StatefulWidget {
  const ShowCalendarEventPage({ Key? key }) : super(key: key);

  @override
  State<ShowCalendarEventPage> createState() => _ShowCalendarEventPageState();
}

class _ShowCalendarEventPageState extends State<ShowCalendarEventPage> {
  
  late Map<DateTime, List<Event>> selectedEvents;
  
  CalendarFormat format= CalendarFormat.month;
  DateTime selectedDay= DateTime.now();
  DateTime focusedDay= DateTime.now();

  @override
  void initState() {
    selectedEvents= {};
    super.initState();
  }

  List<Event> _getEventsfromDay(DateTime date){
    return selectedEvents [date] ?? [];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TableCalendar(
        focusedDay: selectedDay, 
        firstDay: DateTime(2022, 1, 1), 
        lastDay: DateTime(2035, 12, 30),
        calendarFormat: format,
        onFormatChanged: (CalendarFormat _format){
          setState(() {
            format= _format;
          });
        },
        startingDayOfWeek: StartingDayOfWeek.monday,
        onDaySelected: (DateTime selectDay, DateTime focusDay){
          setState(() {
            selectedDay = selectDay;
            focusedDay = focusDay;
          });
          print(focusedDay);
        },
        selectedDayPredicate: (DateTime date){
          return isSameDay(selectedDay, date);
        },

        eventLoader: _getEventsfromDay,

        //CalendarStyle
        calendarStyle: CalendarStyle(
          isTodayHighlighted: true,
          selectedDecoration: BoxDecoration(
            color: Colors.deepPurpleAccent, 
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(5),
          ),
          selectedTextStyle: const TextStyle(
            color: Colors.white,),
          todayDecoration: BoxDecoration(
            color: Colors.blue, 
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(5.0),
          ),
          defaultDecoration: BoxDecoration( 
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(5),
          ),
          weekendDecoration: BoxDecoration( 
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(5),
          ),
        ),
        headerStyle: HeaderStyle(
          formatButtonVisible: true, 
          titleCentered: true,
          formatButtonShowsNext: false,
          formatButtonDecoration: BoxDecoration(
            color: Colors.amberAccent, borderRadius: BorderRadius.circular(5),
          ),
          formatButtonTextStyle: TextStyle(color: Colors.white),
          headerPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        ),
      ),
      
    );   
  }
}

class Event{
  final String title;
  Event({required this.title});

  String toString() => this.title;
}