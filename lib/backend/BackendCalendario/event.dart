// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_helpers/firebase_helpers.dart';

class EventModel {
  final String id;
  final String title;
  final String description;
  final DateTime eventDate;
  final bool cumplido;
  EventModel({
    required this.id,
    required this.title,
    required this.description,
    required this.eventDate,
    required this.cumplido,
  });

  EventModel copyWith({
    String? id,
    String? title,
    String? description,
    DateTime? eventDate,
    bool? cumplido,
  }) {
    return EventModel(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      eventDate: eventDate ?? this.eventDate,
      cumplido: cumplido ?? this.cumplido,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'description': description,
      'eventDate': eventDate.millisecondsSinceEpoch,
      'cumplido': cumplido,
    };
  }

  factory EventModel.fromMap(Map<String, dynamic> map) {
    return EventModel(
      id: map['id'] as String,
      title: map['title'] as String,
      description: map['description'] as String,
      eventDate: DateTime.fromMillisecondsSinceEpoch(map['eventDate'] as int),
      cumplido: map['cumplido'] as bool,
    );
  }

  factory EventModel.fromDS(String id, Map<String, dynamic> map) {
    return EventModel(
      id: id,
      title: map['title'] as String,
      description: map['description'] as String,
      eventDate: DateTime.fromMillisecondsSinceEpoch(map['eventDate'] as int),
      cumplido: map['cumplido'] as bool,
    );
  }

  String toJson() => json.encode(toMap());

  factory EventModel.fromJson(String source) =>
      EventModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'EventModel(id: $id, title: $title, description: $description, eventDate: $eventDate, cumplido: $cumplido)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is EventModel &&
        other.id == id &&
        other.title == title &&
        other.description == description &&
        other.eventDate == eventDate &&
        other.cumplido == cumplido;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        title.hashCode ^
        description.hashCode ^
        eventDate.hashCode ^
        cumplido.hashCode;
  }
}
