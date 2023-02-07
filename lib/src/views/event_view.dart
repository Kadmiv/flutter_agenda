import 'package:flutter/material.dart';
import 'package:flutter_agenda/src/models/agenda_event.dart';
import 'package:flutter_agenda/src/styles/agenda_style.dart';
import 'package:flutter_agenda/src/utils/utils.dart';
import 'package:flutter_agenda/src/views/agenda_screen.dart';

class EventView<E extends AbstractEvent> extends StatelessWidget {
  final E event;
  final int lenght;
  final AgendaStyle agendaStyle;
  final EventBuilder<E> eventBuilder;

  const EventView({
    Key? key,
    required this.event,
    required this.lenght,
    required this.agendaStyle,
    required this.eventBuilder,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: top(),
      height: height(),
      left: 0,
      width: agendaStyle.isFittedWidth
          ? Utils.pillarWidth(lenght, agendaStyle.timeItemWidth,
                  agendaStyle.pillarWidth, MediaQuery.of(context).orientation) -
              agendaStyle.pillarViewPadding.right
          : agendaStyle.pillarWidth - agendaStyle.pillarViewPadding.right,
      child: eventBuilder(context, event),
    );
  }

  double top() {
    return calculateTopOffset(
            event.start.hour, event.start.minute, agendaStyle.timeSlotHeight) -
        agendaStyle.startHour * agendaStyle.timeSlotHeight;
  }

  double height() {
    return calculateTopOffset(0, event.end.difference(event.start).inMinutes,
            agendaStyle.timeSlotHeight) +
        1;
  }

  double calculateTopOffset(
    int hour, [
    int minute = 0,
    double? hourRowHeight,
  ]) {
    return (hour + (minute / 60)) * (hourRowHeight ?? 60);
  }
}
