import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_agenda/src/models/agenda_event.dart';
import 'package:flutter_agenda/src/styles/agenda_style.dart';
import 'package:flutter_agenda/src/utils/utils.dart';

class EventView extends StatelessWidget {
  final AgendaEvent event;
  final AgendaStyle agendaStyle;

  const EventView({
    Key? key,
    required this.event,
    required this.agendaStyle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: top(),
      height: height(),
      left: 0,
      width: agendaStyle.pillarHeadWidth,
      child: GestureDetector(
        onTap: event.onTap,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(agendaStyle.eventRadius),
          child: Container(
            decoration: event.decoration ??
                (BoxDecoration(
                    color: event.backgroundColor.withOpacity(0.1),
                    border: Border(
                      left: BorderSide(
                          color: event.backgroundColor,
                          width: agendaStyle.eventBorderWidth),
                      bottom: BorderSide(color: Color(0xFFBCBCBC)),
                    ))),
            padding: event.padding,
            margin: event.margin,
            child: (Utils.eventText)(
              event,
              context,
              math.max(
                  0.0, height() - (event.padding.top) - (event.padding.bottom)),
              math.max(
                  0.0,
                  agendaStyle.pillarHeadWidth -
                      (event.padding.left) -
                      (event.padding.right)),
            ),
          ),
        ),
      ),
    );
  }

  double top() {
    return calculateTopOffset(
            event.start.hour, event.start.minute, agendaStyle.timeItemHeight) -
        agendaStyle.startHour * agendaStyle.timeItemHeight;
  }

  double height() {
    return calculateTopOffset(0, event.end.difference(event.start).inMinutes,
            agendaStyle.timeItemHeight) +
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
