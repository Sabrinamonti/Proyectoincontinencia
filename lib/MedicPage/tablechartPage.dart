import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:loginpage/MedicPage/CreateEventPage.dart';
import 'package:loginpage/backend/BackendCalendario/event.dart';
import 'package:loginpage/backend/CalendarioMed.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarEvents extends StatefulWidget {
  final String value;
  const CalendarEvents({Key? key, required this.value}) : super(key: key);

  @override
  State<CalendarEvents> createState() => _CalendarEventsState();
}

class _CalendarEventsState extends State<CalendarEvents> {
  GlobalKey<RefreshIndicatorState> refreshKey =
      GlobalKey<RefreshIndicatorState>();
  CalendarFormat format = CalendarFormat.month;
  final todaysDate = DateTime.now();
  DateTime _focusedCalendarDate = DateTime.now();
  final _initialCalendarDate = DateTime(2020);
  final _lastCalendarDate = DateTime(2050);
  DateTime _selectedDay = DateTime.now();
  List EventosDB = [];
  List<EventModel> eve = [];
  final List<dynamic> _selectedEvents = [];
  //DateTime? selectedCalendarDate;

  late LinkedHashMap<DateTime, List> _groupedEvents;

  @override
  void initState() {
    //selectedCalendarDate = _focusedCalendarDate;
    super.initState();
    fetchdatabaselist();
    refreshKey = GlobalKey<RefreshIndicatorState>();
  }

  fetchdatabaselist() async {
    dynamic resultant = await CalendarioMed(value: widget.value).getEvents();
    if (resultant == null) {
      print('No se puede obtener la informacion');
    } else {
      setState(() {
        EventosDB = resultant;
      });
    }
  }

  List<dynamic> _getEventsForDay(DateTime dateTime) {
    return _groupedEvents[dateTime] ?? [];
  }

  int getHashCode(DateTime key) {
    return key.day * 1000000 + key.month * 10000 + key.year;
  }

  _groupEvents(List events) {
    _groupedEvents = LinkedHashMap(equals: isSameDay, hashCode: getHashCode);
    for (var event in events) {
      var fecha =
          DateTime.fromMillisecondsSinceEpoch((event["eventDate"] as int));
      DateTime date = DateTime.utc(fecha.year, fecha.month, fecha.day, 12);
      if (_groupedEvents[date] == null) _groupedEvents[date] = [];
      _groupedEvents[date]?.add(event);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => Createevent(value: widget.value))),
          label: const Text('Agregar Evento'),
        ),
        body: SingleChildScrollView(
            child: RefreshIndicator(
          key: refreshKey,
          onRefresh: () async {
            fetchdatabaselist();
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Card(
                  margin: const EdgeInsets.all(8.0),
                  elevation: 5.0,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                    side: BorderSide(color: Colors.brown, width: 2.0),
                  ),
                  child: TableCalendar(
                    focusedDay: _focusedCalendarDate,
                    // today's date
                    firstDay: _initialCalendarDate,
                    // earliest possible date
                    lastDay: _lastCalendarDate,
                    // latest allowed date
                    calendarFormat: format,
                    onFormatChanged: (CalendarFormat _format) {
                      setState(() {
                        format = _format;
                      });
                    },
                    startingDayOfWeek: StartingDayOfWeek.monday,
                    // height between the day row and 1st date row, default is 16.0
                    daysOfWeekHeight: 40.0,
                    // height between the date rows, default is 52.0
                    rowHeight: 60.0,
                    // this property needs to be added if we want to show events
                    eventLoader: _getEventsForDay,
                    locale: 'es_ES',
                    // Calendar Header Styling
                    headerStyle: const HeaderStyle(
                      titleTextStyle: TextStyle(
                          color: Color.fromARGB(255, 12, 83, 235),
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold),
                      decoration: BoxDecoration(
                          color: Color.fromARGB(255, 236, 171, 233),
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(10),
                              topRight: Radius.circular(10))),
                      formatButtonTextStyle: TextStyle(
                          color: Color.fromARGB(255, 91, 137, 236),
                          fontSize: 16.0),
                      formatButtonDecoration: BoxDecoration(
                        color: Color.fromARGB(255, 237, 195, 243),
                        borderRadius: BorderRadius.all(
                          Radius.circular(5.0),
                        ),
                      ),
                      leftChevronIcon: Icon(
                        Icons.chevron_left,
                        color: Color.fromARGB(255, 19, 18, 19),
                        size: 28,
                      ),
                      rightChevronIcon: Icon(
                        Icons.chevron_right,
                        color: Color.fromARGB(255, 19, 18, 19),
                        size: 28,
                      ),
                    ),
                    // Calendar Days Styling
                    calendarStyle: const CalendarStyle(
                      todayDecoration: BoxDecoration(
                        color: Color.fromARGB(255, 115, 114, 226),
                        shape: BoxShape.circle,
                      ),
                      // highlighted color for selected day
                      selectedDecoration: BoxDecoration(
                        color: Color.fromARGB(255, 214, 158, 192),
                        shape: BoxShape.circle,
                      ),
                      markerDecoration: BoxDecoration(
                          color: Color.fromARGB(255, 15, 15, 15),
                          shape: BoxShape.circle),
                    ),
                    selectedDayPredicate: (currentSelectedDate) {
                      // as per the documentation 'selectedDayPredicate' needs to determine
                      // current selected day
                      return (isSameDay(_selectedDay, currentSelectedDate));
                    },
                    onDaySelected: (DateTime selectedDay, DateTime focusedDay) {
                      setState(() {
                        _selectedDay = selectedDay;
                        _focusedCalendarDate = focusedDay;
                      });
                      //}
                    },
                  )),
              SingleChildScrollView(
                child: Builder(builder: (BuildContext context) {
                  //fetchdatabaselist();
                  _groupEvents(EventosDB);
                  DateTime selectedDate = _selectedDay;
                  final _selectedEvents = _groupedEvents[selectedDate] ?? [];
                  return ListView.builder(
                    shrinkWrap: true,
                    itemCount: _selectedEvents.length,
                    itemBuilder: (context, index) {
                      final item = _selectedEvents[index];
                      return Slidable(
                          startActionPane: ActionPane(
                            motion: const ScrollMotion(),
                            children: [
                              SlidableAction(
                                onPressed: (context) {
                                  //print(_selectedEvents.length);
                                  //setState(() {
                                  _selectedEvents.removeAt(index);
                                  //});
                                  //print(_selectedEvents);
                                },
                                backgroundColor: Colors.red,
                                foregroundColor: Colors.white,
                                icon: Icons.delete,
                                label: 'Eliminar',
                              )
                            ],
                          ),
                          child: Card(
                            child: ListTile(
                              leading: _selectedEvents[index]['cumplido'] ==
                                      false
                                  ? const Icon(Icons.cancel, color: Colors.red)
                                  : const Icon(
                                      Icons.done,
                                      color: Colors.green,
                                    ),
                              title: Text(_selectedEvents[index]["titulo"]),
                              subtitle:
                                  Text(_selectedEvents[index]["descripcion"]),
                              //trailing: IconButton(
                              //icon: Icon(Icons.delete),
                              //onPressed: () async {
                              // setState(() {
                              //_selectedEvents.removeAt(index);
                              //});
                              // },
                              // ),
                            ),
                          ));
                    },
                    //),
                  );
                }),
              )
            ],
          ),
        )));
  }
}

class MyEvents {
  //final String id;
  final String title;
  final String description;
  final DateTime eventDate;
  final bool Cumplido;

  MyEvents(
      {required this.title,
      required this.description,
      required this.eventDate,
      required this.Cumplido});

  @override
  String toString() => title;
}
