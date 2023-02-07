import 'package:flutter_agenda/src/models/agenda_event.dart';
import 'package:flutter_agenda/src/models/header.dart';

class Resource<H , E extends AbstractEvent> {
  /// Pillar object helps link the resource with his appointments.

  /// [header] employee/resource.
  final H header;

  /// [events] (appointments/Todos) linked to the head.
  final List<E> events;

  Resource({
    required this.header,
    required this.events,
  });
}
