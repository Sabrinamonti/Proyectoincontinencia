import 'package:flutter/material.dart';
import 'package:loginpage/MedicPage/tablechartPage.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

/*class EventEditingPage extends StatefulWidget {
  
  final Events ? event;

  const EventEditingPage({
    Key? key,
    this.event,
  }) : super(key : key);

  @override
  State<EventEditingPage> createState() => _EventEditingPageState();
}

class _EventEditingPageState extends State<EventEditingPage> {
  final _formKey =GlobalKey<FormState>();
  final titleController = TextEditingController();
  late DateTime fromDate;
  late DateTime toDate;

  @override
  void initState() {
    super.initState();
    if(widget.event == null){
      fromDate = DateTime.now();
      toDate = DateTime.now().add(Duration(hours: 2));
    }
  }

  @override
  void dispose() {
    super.dispose();
    titleController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: CloseButton(),
        actions: [
          ElevatedButton.icon(
          style: ElevatedButton.styleFrom(
            primary: Colors.transparent,
            shadowColor: Colors.transparent,
          ),
          onPressed: () {}, 
          icon: Icon(Icons.done), 
          label: Text('Guardar'),
        )],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(12),
        child: Form(
          key: _formKey,
          child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            buildTitle(),
            SizedBox(height: 12),
            buildDateTimePicker(),
          ],
        ),
        )
      ),
    );
  }

  Widget buildTitle() => TextFormField(
    style: TextStyle(fontSize: 24),
    decoration: InputDecoration(
      border: UnderlineInputBorder(),
      hintText: 'Añadir titulo de tarea'
    ),
    onFieldSubmitted: (_) {},
    validator: (title) => title != null && title.isEmpty ? 'Agregar titulo de tarea' : null,
    controller: titleController
  );

  Widget buildDateTimePicker() => Column(
    children: [
      buildFront(),
      buildTo(),
    ],
  );

  Widget buildFront() => buildHeader(
    header: 'Desde', 
    child: Row(
    children: [
      Expanded(
        flex: 2,
        child: buildDropDownField(
          text: Utils.toDate(fromDate),
          onClicked: () =>
            pickFromDateTime(pickDate: true),
        )
      ),
      Expanded(
        child: buildDropDownField(
          text: Utils.toTime(fromDate), 
          onClicked: () =>
          pickFromDateTime(pickDate: false),
        )
      )
    ],
  ));

  Widget buildTo() => buildHeader(
    header: 'Hasta', 
    child: Row(
    children: [
      Expanded(
        flex: 2,
        child: buildDropDownField(
          text: Utils.toDate(toDate),
          onClicked: () => pickToDateTime(pickDate: true),
        )
      ),
      Expanded(
        child: buildDropDownField(
          text: Utils.toTime(toDate), 
          onClicked: () => pickToDateTime(pickDate: false),
        )
      )
    ],
  ));
  
  Future pickFromDateTime({required bool pickDate}) async {
    final date= await pickDateTime(fromDate, pickDate: pickDate);
    if(date == null) return;
    if(date.isAfter(toDate)){
      toDate = DateTime(date.year, date.month, date.day, toDate.hour, toDate.minute);
    }
    setState(() {
      fromDate=date;
    });
  }

  Future pickToDateTime({required bool pickDate}) async {
    final date= await pickDateTime(toDate, pickDate: pickDate, firstDate: pickDate ? fromDate: null);
    if(date == null) return;
    if(date.isAfter(toDate)){
      toDate = DateTime(date.year, date.month, date.day, toDate.hour, toDate.minute);
    }
    setState(() {
      toDate=date;
    });
  }

  
  Future<DateTime?> pickDateTime(
    DateTime initialDate, {
      required bool pickDate,
      DateTime? firstDate,
    }
  ) async {
    if(pickDate) {
      final date= await showDatePicker(
        context: context, 
        initialDate: initialDate, 
        firstDate: firstDate ?? DateTime(2021, 1), 
        lastDate: DateTime(2035),
      );

      if(date == null) return null;
      final time= Duration(hours: initialDate.hour, minutes: initialDate.minute);

      return date.add(time);
    } else {
      final timeOfDay= await showTimePicker(
        context: context, 
        initialTime: TimeOfDay.fromDateTime(initialDate)
      );

      if(timeOfDay == null) return null;
      final time = Duration(hours: timeOfDay.hour, minutes: timeOfDay.minute);
      final date= DateTime(initialDate.year, initialDate.month, initialDate.day);
      return date.add(time);
    }
  }

  Widget buildDropDownField({
    required String text, 
    required onClicked,
  }) => ListTile(
    title: Text(text),
    trailing: Icon(Icons.arrow_drop_down),
    onTap: onClicked,
  );

  Widget buildHeader({
    required String header,
    required Widget child,
  }) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(header, style: TextStyle(fontWeight: FontWeight.bold)),
      child
    ],
  );
  Future saveForm() async {
    final isValid = _formKey.currentState!.validate();
    if(isValid){
      final event= Events(title: titleController.text,
      description: 'Description',
      from: fromDate,
      to: toDate,
      isAllDay: false,
      );
    }
  }
}

class Utils {
  static String toDateTime(DateTime dateTime) {
    final date= DateFormat.yMMMEd().format(dateTime);
    final time = DateFormat.Hm().format(dateTime);

    return '$date $time';
  }

  static String toDate(DateTime dateTime) {
    final date= DateFormat.yMMMEd().format(dateTime);

    return '$date';
  }

  static String toTime(DateTime dateTime) {
    final time= DateFormat.Hm().format(dateTime);

    return '$time';
  }
}*/