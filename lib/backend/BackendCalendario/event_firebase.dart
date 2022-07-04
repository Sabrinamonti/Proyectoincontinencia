import 'package:firebase_helpers/firebase_helpers.dart';
import 'package:loginpage/backend/BackendCalendario/event.dart';

final eventDBS = DatabaseService<EventModel>(
  'Evento',
  fromDS: (id, data) => EventModel.fromDS(id, data!),
  toMap: (event) => event.toMap(),
);
