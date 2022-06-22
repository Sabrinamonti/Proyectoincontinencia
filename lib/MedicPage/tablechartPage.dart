import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';

class CalendarEvents extends StatefulWidget {
  const CalendarEvents({Key? key}) : super(key: key);

  @override
  State<CalendarEvents> createState() => _CalendarEventsState();
}

class _CalendarEventsState extends State<CalendarEvents> {
  final todaysDate = DateTime.now();
  var _focusedCalendarDate = DateTime.now();
  final _initialCalendarDate = DateTime(2000);
  final _lastCalendarDate = DateTime(2050);
  DateTime? selectedCalendarDate;
  final titleController = TextEditingController();
  final descpController = TextEditingController();
  DateTimeRange dateRange = DateTimeRange(
      start: DateTime.now(), end: DateTime.now().add(Duration(days: 7)));

  late Map<DateTime, List<MyEvents>> mySelectedEvents;

  @override
  void initState() {
    selectedCalendarDate = _focusedCalendarDate;
    mySelectedEvents = {};
    super.initState();
  }

  @override
  void dispose() {
    titleController.dispose();
    descpController.dispose();
    super.dispose();
  }

  List<MyEvents> _listOfDayEvents(DateTime dateTime) {
    return mySelectedEvents[dateTime] ?? [];
  }

  _showAddEventDialog() async {
    await showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: const Text('New Event'),
              content: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.min,
                children: [
                  buildTextField(
                      controller: titleController, hint: 'Enter Title'),
                  const SizedBox(
                    height: 20.0,
                  ),
                  buildTextField(
                      controller: descpController, hint: 'Enter Description'),
                  const SizedBox(
                    height: 20.0,
                  ),
                  TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Enter a search term',
                    ),
                  ),
                  ElevatedButton(
                      onPressed: () async {
                        await pickDateRange(context);
                      },
                      child: Text("Seleccionar Fechas")),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Text(
                          "Desde: ${DateFormat('dd/MM/yyyy').format(dateRange.start).toString()}"),
                      Text(
                          "Hasta: ${DateFormat('dd/MM/yyyy').format(dateRange.end).toString()}")
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
                  onPressed: () {
                    if (titleController.text.isEmpty &&
                        descpController.text.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Please enter title & description'),
                          duration: Duration(seconds: 3),
                        ),
                      );
                      //Navigator.pop(context);
                      return;
                    } else {
                      setState(() {
                        if (mySelectedEvents[selectedCalendarDate] != null) {
                          mySelectedEvents[selectedCalendarDate]?.add(MyEvents(
                              eventTitle: titleController.text,
                              eventDescp: descpController.text));
                        } else {
                          mySelectedEvents[selectedCalendarDate!] = [
                            MyEvents(
                                eventTitle: titleController.text,
                                eventDescp: descpController.text)
                          ];
                        }
                      });

                      titleController.clear();
                      descpController.clear();

                      Navigator.pop(context);
                      return;
                    }
                  },
                  child: const Text('Add'),
                ),
              ],
            ));
  }

  Future pickDateRange(BuildContext context) async {
    DateTimeRange? selectedFormDate = await showDateRangePicker(
        context: context,
        firstDate: dateRange.start,
        lastDate: new DateTime(DateTime.now().year + 2));
    if (selectedFormDate == null) {
      return;
    }
    setState(() {
      dateRange = selectedFormDate;
    });
  }

  Widget buildTextField(
      {String? hint, required TextEditingController controller}) {
    return TextField(
      controller: controller,
      textCapitalization: TextCapitalization.words,
      decoration: InputDecoration(
        labelText: hint ?? '',
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.lightGreen, width: 1.5),
          borderRadius: BorderRadius.circular(
            10.0,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.lightGreen, width: 1.5),
          borderRadius: BorderRadius.circular(
            10.0,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Custom Calendar'),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _showAddEventDialog(),
        label: const Text('Add Event'),
      ),
      body: SingleChildScrollView(
        child: Column(
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
                calendarFormat: CalendarFormat.month,
                // default view when displayed
                // default is Saturday & Sunday but can be set to any day.
                // instead of day number can be mentioned as well.
                weekendDays: const [DateTime.sunday, 6],
                // default is Sunday but can be changed according to locale
                startingDayOfWeek: StartingDayOfWeek.monday,
                // height between the day row and 1st date row, default is 16.0
                daysOfWeekHeight: 40.0,
                // height between the date rows, default is 52.0
                rowHeight: 60.0,
                // this property needs to be added if we want to show events
                eventLoader: _listOfDayEvents,
                // Calendar Header Styling
                headerStyle: const HeaderStyle(
                  titleTextStyle: TextStyle(
                      color: Color.fromARGB(255, 237, 195, 243),
                      fontSize: 20.0),
                  decoration: BoxDecoration(
                      color: Colors.lightGreen,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10),
                          topRight: Radius.circular(10))),
                  formatButtonTextStyle: TextStyle(
                      color: Color.fromARGB(255, 163, 69, 69), fontSize: 16.0),
                  formatButtonDecoration: BoxDecoration(
                    color: Color.fromARGB(255, 237, 195, 243),
                    borderRadius: BorderRadius.all(
                      Radius.circular(5.0),
                    ),
                  ),
                  leftChevronIcon: Icon(
                    Icons.chevron_left,
                    color: Color.fromARGB(255, 237, 195, 243),
                    size: 28,
                  ),
                  rightChevronIcon: Icon(
                    Icons.chevron_right,
                    color: Color.fromARGB(255, 237, 195, 243),
                    size: 28,
                  ),
                ),
                // Calendar Days Styling
                daysOfWeekStyle: const DaysOfWeekStyle(
                  // Weekend days color (Sat,Sun)
                  weekendStyle: TextStyle(color: Colors.red),
                ),
                // Calendar Dates styling
                calendarStyle: const CalendarStyle(
                  // Weekend dates color (Sat & Sun Column)
                  weekendTextStyle: TextStyle(color: Colors.red),
                  // highlighted color for today
                  todayDecoration: BoxDecoration(
                    color: Colors.lightGreen,
                    shape: BoxShape.circle,
                  ),
                  // highlighted color for selected day
                  selectedDecoration: BoxDecoration(
                    color: Colors.brown,
                    shape: BoxShape.circle,
                  ),
                  markerDecoration:
                      BoxDecoration(color: Colors.red, shape: BoxShape.circle),
                ),
                selectedDayPredicate: (currentSelectedDate) {
                  // as per the documentation 'selectedDayPredicate' needs to determine
                  // current selected day
                  return (isSameDay(
                      selectedCalendarDate!, currentSelectedDate));
                },
                onDaySelected: (selectedDay, focusedDay) {
                  // as per the documentation
                  if (!isSameDay(selectedCalendarDate, selectedDay)) {
                    setState(() {
                      selectedCalendarDate = selectedDay;
                      _focusedCalendarDate = focusedDay;
                    });
                  }
                },
              ),
            ),
            ..._listOfDayEvents(selectedCalendarDate!).map(
              (myEvents) => ListTile(
                leading: const Icon(
                  Icons.done,
                  color: Colors.lightGreen,
                ),
                title: Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Text('Event Title:   ${myEvents.eventTitle}'),
                ),
                subtitle: Text('Description:   ${myEvents.eventDescp}'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MyEvents {
  final String eventTitle;
  final String eventDescp;

  MyEvents({required this.eventTitle, required this.eventDescp});

  @override
  String toString() => eventTitle;
}
