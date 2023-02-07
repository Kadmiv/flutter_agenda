import 'package:flutter/material.dart';
import 'package:flutter_agenda/flutter_agenda.dart';
import 'package:flutter_agenda/src/styles/background_painter.dart';
import 'package:flutter_agenda/src/utils/utils.dart';
import 'package:flutter_agenda/src/views/event_view.dart';

class PillarView<E extends AbstractEvent> extends StatelessWidget {
  PillarView({
    Key? key,
    required this.events,
    required this.lenght,
    required this.scrollController,
    required this.agendaStyle,
    required this.eventBuilder,
  }) : super(key: key);

  final List<E> events;
  final int lenght;
  final ScrollController scrollController;
  final AgendaStyle agendaStyle;
  final EventBuilder<E> eventBuilder;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      controller: scrollController,
      physics: ClampingScrollPhysics(),
      child: Container(
        padding: agendaStyle.pillarViewPadding,
        height: height(),
        width: agendaStyle.isFittedWidth
            ? Utils.pillarWidth(lenght, agendaStyle.timeItemWidth,
                agendaStyle.pillarWidth, MediaQuery.of(context).orientation)
            : agendaStyle.pillarWidth,
        decoration: agendaStyle.visiblePillarSeperator
            ? BoxDecoration(
                border: Border(
                  left: BorderSide(
                    color: agendaStyle.timelineBorderColor,
                  ),
                ),
              )
            : BoxDecoration(),
        child: Stack(
          children: [
            ...[
              Positioned.fill(
                // child: Padding(
                //   padding: const EdgeInsets.only(top: 0.5), /// Don't change this
                  child: CustomPaint(
                    painter: BackgroundPainter(
                      agendaStyle: agendaStyle,
                    ),
                  ),
                // ),
              )
            ],
            ...events.map((event) {
              return EventView(
                event: event,
                lenght: lenght,
                agendaStyle: agendaStyle,
                eventBuilder: eventBuilder,
              );
            }).toList(),
          ],
        ),
      ),
    );
  }

  double height() {
    return (agendaStyle.endHour - agendaStyle.startHour) *
        agendaStyle.timeSlotHeight;
  }
}
