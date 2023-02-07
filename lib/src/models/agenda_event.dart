import 'package:flutter_agenda/src/models/event_time.dart';

abstract class AbstractEvent {
  EventTime get start;

  EventTime get end;
}

class AgendaEvent implements AbstractEvent {
  AgendaEvent({required this.startTime, required this.endTime});

  final EventTime startTime;

  final EventTime endTime;

  @override
  // TODO: implement end
  EventTime get end => endTime;

  @override
  // TODO: implement start
  EventTime get start => startTime;
}
