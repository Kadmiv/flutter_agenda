import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_agenda/flutter_agenda.dart';
import 'package:flutter_agenda/src/controllers/scroll_linker.dart';
import 'package:flutter_agenda/src/utils/scroll_config.dart';
import 'package:flutter_agenda/src/views/pillar_view.dart';

typedef HeaderBuilder<H> = Widget Function(BuildContext context, H header);

typedef EventBuilder<E> = Widget Function(BuildContext context, E event);

typedef TimeSlotBuilder = Widget Function(
    BuildContext context, int hour, TimeSlot slotType);

class FlutterAgenda<H, E extends AbstractEvent> extends StatefulWidget {
  /// Agenda visualization only one required parameter [pillarsList].
  FlutterAgenda({
    Key? key,
    required this.resources,
    required this.eventBuilder,
    required this.timeSlotBuilder,
    this.headerBuilder,
    this.agendaStyle: const AgendaStyle(),
  }) : super(key: key);

  /// list of pillar Object:
  ///
  /// [header] employee/resource.
  ///
  /// [events] (appointments/Todos) linked to the head.
  final List<Resource<H, E>> resources;

  /// if you want to customize the view more
  final AgendaStyle agendaStyle;
  final HeaderBuilder<dynamic>? headerBuilder;
  final EventBuilder<dynamic> eventBuilder;
  final TimeSlotBuilder timeSlotBuilder;

  @override
  _FlutterAgendaState createState() => _FlutterAgendaState<H, E>();
}

class _FlutterAgendaState<H, E extends AbstractEvent>
    extends State<FlutterAgenda> {
  // scroll linkers
  late ScrollLinker _horizontalScrollLinker;
  late ScrollLinker _verticalScrollLinker;

  // vertical scroll controllers
  List<ScrollController> _verticalScrollControllers = <ScrollController>[];

  // horizontal (header, body) scroll controllers
  late ScrollController _headerScrollController;
  late ScrollController _bodyScrollController;

  @override
  void initState() {
    super.initState();
    // init scroll linkers
    _verticalScrollLinker = ScrollLinker();
    _horizontalScrollLinker = ScrollLinker();

    // sychronize the scroll of the vertical scrollers
    _headerScrollController = _horizontalScrollLinker.addAndGet();
    _bodyScrollController = _horizontalScrollLinker.addAndGet();

    // sychronize the scroll of the horizontal scrollers
    _verticalScrollControllers.add(_verticalScrollLinker.addAndGet());
    widget.resources.forEach((element) {
      _verticalScrollControllers.add(_verticalScrollLinker.addAndGet());
    });
  }

  @override
  void dispose() {
    super.dispose();
    // disposing the vetical scrollers

    for (final controller in _verticalScrollControllers) {
      controller.dispose();
    }
    // clearing the vertical scrollers list
    _verticalScrollControllers.clear();

    // disposing the horizontal scrollers
    _headerScrollController.dispose();
    _bodyScrollController.dispose();
  }

  @override
  void didUpdateWidget(covariant FlutterAgenda oldWidget) {
    super.didUpdateWidget(oldWidget);

    final difference =
        (widget.resources.length + 1) - _verticalScrollControllers.length;

    if (difference > 0) {
      for (var i = 0; i <= difference; i++) {
        _verticalScrollControllers.add(_verticalScrollLinker.addAndGet());
      }
    } else if (difference < 0) {
      for (var i = difference; difference < 0; i++) {
        _verticalScrollControllers.removeLast();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: widget.agendaStyle.direction,
      child: Stack(
        children: <Widget>[
          _buildMainContent(context),
          _buildTimeLines(context),
          _buildHeaders(context),
          _buildCorner(),
        ],
      ),
    );
  }

  Widget _buildCorner() {
    return Positioned(
      left: widget.agendaStyle.direction == TextDirection.ltr ? 0 : null,
      right: widget.agendaStyle.direction == TextDirection.rtl ? 0 : null,
      top: 0,
      child: SizedBox(
        width: widget.agendaStyle.timeItemWidth + 2,
        height: widget.agendaStyle.headerHeight + 1,
        child: DecoratedBox(
          position: DecorationPosition.background,
          decoration: BoxDecoration(
            color: widget.agendaStyle.cornerColor,
            border: Border(
              right: (widget.agendaStyle.cornerRight &&
                      widget.agendaStyle.direction != TextDirection.rtl)
                  ? BorderSide(
                      color: widget.agendaStyle.timelineBorderColor,
                    )
                  : BorderSide.none,
              left: (widget.agendaStyle.cornerLeft &&
                      widget.agendaStyle.direction == TextDirection.ltr)
                  ? BorderSide(
                      color: widget.agendaStyle.timelineBorderColor,
                    )
                  : BorderSide.none,
              // bottom: widget.agendaStyle.cornerBottom
              //     ? BorderSide(
              //         color: widget.agendaStyle.timelineBorderColor,
              //       )
              //     : BorderSide.none,
              // top: widget.agendaStyle.cornerTop
              //     ? BorderSide(
              //         color: widget.agendaStyle.timelineBorderColor,
              //       )
              //     : BorderSide.none,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildMainContent(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: widget.agendaStyle.direction == TextDirection.ltr
            ? widget.agendaStyle.timeItemWidth
            : 0,
        right: widget.agendaStyle.direction == TextDirection.rtl
            ? widget.agendaStyle.timeItemWidth
            : 0,
        top: widget.agendaStyle.headerHeight != 0
            ? widget.agendaStyle.headerHeight - 1
            : 0,
      ),
      child: ScrollConfiguration(
        behavior: NoGlowScroll(),
        child: ListView(
          scrollDirection: Axis.horizontal,
          // reverse: widget.agendaStyle.direction == TextDirection.rtl,
          controller: _bodyScrollController,
          children: widget.resources.map((pillar) {
            return PillarView(
              lenght: widget.resources.length,
              scrollController: _verticalScrollControllers[
                  widget.resources.indexOf(pillar) + 1],
              events: pillar.events,
              eventBuilder: widget.eventBuilder,
              agendaStyle: widget.agendaStyle,
            );
          }).toList(),
        ),
      ),
    );
  }

  Widget _buildTimeLines(BuildContext context) {
    return Container(
      // padding: const EdgeInsets.only(top: 2.35),
      padding: widget.agendaStyle.headerHeight != 0
          ? EdgeInsets.only(top: widget.agendaStyle.headerHeight - 1)
          : null,
      alignment: widget.agendaStyle.direction == TextDirection.rtl
          ? Alignment.topLeft
          : Alignment.topRight,
      width: widget.agendaStyle.timeItemWidth + 3,
      decoration: BoxDecoration(
        color: widget.agendaStyle.timelineColor,
        border: widget.agendaStyle.visibleTimelineBorder
            ? Border(
                right: widget.agendaStyle.direction == TextDirection.ltr
                    ? BorderSide(color: widget.agendaStyle.timelineBorderColor)
                    : BorderSide.none,
                left: widget.agendaStyle.direction == TextDirection.rtl
                    ? BorderSide(color: widget.agendaStyle.timelineBorderColor)
                    : BorderSide.none,
                bottom: widget.agendaStyle.direction == TextDirection.rtl
                    ? BorderSide(color: widget.agendaStyle.timelineBorderColor)
                    : BorderSide.none,
              )
            : null,
      ),
      child: ScrollConfiguration(
        behavior: NoGlowScroll(),
        child: ListView(
          controller: _verticalScrollControllers[0],
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          children: [
            for (var i = widget.agendaStyle.startHour;
                i < widget.agendaStyle.endHour;
                i += 1)
              i
          ].map((hour) {
            final isFirstHour = hour == widget.agendaStyle.startHour;

            return Container(
              height: widget.agendaStyle.timeSlotHeight,
              decoration: isFirstHour
                  ? null
                  : widget.agendaStyle.visibleTimelineSeparator
                      ? BoxDecoration(
                          border: Border(
                            top: BorderSide(
                              color: widget.agendaStyle.timelineBorderColor,
                              width: 0.8,
                            ),
                          ),
                          color: widget.agendaStyle.timelineItemColor,
                        )
                      : null,
              child: widget.timeSlotBuilder(
                context,
                hour,
                widget.agendaStyle.timeSlot,
              ),
            );
          }).toList(),
        ),
      ),
    );
  }

  Widget _buildHeaders(BuildContext context) {
    return Container(
      alignment: widget.agendaStyle.direction == TextDirection.rtl
          ? Alignment.topRight
          : Alignment.topLeft,
      decoration: BoxDecoration(
        color: widget.agendaStyle.pillarColor,
        border: widget.agendaStyle.headBottomBorder
            ? Border(
                bottom: BorderSide(
                  color: widget.agendaStyle.timelineBorderColor,
                ),
              )
            : null,
      ),
      height: widget.agendaStyle.headerHeight,
      padding: EdgeInsets.only(
          left: widget.agendaStyle.direction == TextDirection.ltr
              ? widget.agendaStyle.timeItemWidth
              : 0,
          right: widget.agendaStyle.direction == TextDirection.rtl
              ? widget.agendaStyle.timeItemWidth
              : 0),
      child: ScrollConfiguration(
        behavior: NoGlowScroll(),
        child: ListView(
          scrollDirection: Axis.horizontal,
          controller: _headerScrollController,
          shrinkWrap: true,
          children: widget.resources.map((pillar) {
            return Container(
              width: widget.agendaStyle.isFittedWidth
                  ? Utils.pillarWidth(
                      widget.resources.length,
                      widget.agendaStyle.timeItemWidth,
                      widget.agendaStyle.pillarWidth,
                      MediaQuery.of(context).orientation,
                    )
                  : widget.agendaStyle.pillarWidth,
              height: widget.agendaStyle.headerHeight,
              decoration: BoxDecoration(
                border: widget.agendaStyle.visibleHeadSeperator
                    ? Border(
                        left: BorderSide(
                          color: widget.agendaStyle.timelineBorderColor,
                        ),
                      )
                    : null,
              ),
              child: Center(
                child: widget.headerBuilder?.call(context, pillar.header),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
