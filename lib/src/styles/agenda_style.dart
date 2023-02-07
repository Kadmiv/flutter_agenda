import 'package:flutter/material.dart';
import 'package:flutter_agenda/src/models/time_slot.dart';

class AgendaStyle {
  /// Customize the agenda to match you own UI approach.
  /// by defaut the styles are great but you can change them.
  const AgendaStyle({
    this.startHour: 0,
    this.endHour: 24,
    this.direction: TextDirection.ltr,
    this.cornerTop: true,
    this.cornerBottom: true,
    this.cornerRight: true,
    this.cornerLeft: true,
    this.pillarColor: Colors.white,
    this.cornerColor: Colors.white,
    this.timelineColor: Colors.white,
    this.timelineItemColor: Colors.white,
    this.visibleHeadSeperator: false,
    this.visiblePillarSeperator: false,
    this.mainBackgroundColor: Colors.white,
    this.decorationLineBorderColor: const Color(0xFFCECECE),
    this.headBottomBorder = true,
    this.visibleBottomBorder = true,
    this.isFittedWidth = true,
    this.timelineBorderColor: const Color(0xFF7F7F7F),
    this.timeItemTextColor: const Color(0xFF7B7B7B),
    this.timeSlotHeight: 100,
    this.eventRadius: 5,
    this.pillarWidth: 200,
    this.headerHeight: 50,
    this.timeSlot: TimeSlot.half,
    this.timeItemWidth: 70,
    this.decorationLineHeight: 20,
    this.decorationLineDashWidth: 4,
    this.decorationLineDashSpaceWidth: 4,
    this.eventBorderWidth: 4,
    this.pillarViewPadding: EdgeInsets.zero,
    this.visibleTimeBorder: true,
    this.visibleTimelineBorder: true,
    this.visibleTimeDecorationBorder: true,
    this.visibleTimelineSeparator: true,
  });

  final TextDirection direction;

  ///Timeline start hour.
  ///
  /// it doesn't support period format.
  final int startHour;

  ///Timeline end hour.
  ///
  /// it doesn't support period format.
  final int endHour;

  /// pillar color.
  final Color pillarColor;

  /// the top left corner color
  final Color cornerColor;

  /// the is corner bottom border is active
  final bool cornerTop;
  final bool cornerBottom;

  /// the is corner right border is active
  final bool cornerRight;
  final bool cornerLeft;

  /// the time item [hour] text color
  final Color timeItemTextColor;

  /// the time line color
  final Color timelineColor;

  /// the time line item color
  final Color timelineItemColor;

  /// main body background color
  final Color mainBackgroundColor;

  /// event border Radius
  final double eventRadius;

  /// the time line border color
  final Color timelineBorderColor;

  /// head bottom border
  final bool headBottomBorder;
  final bool visibleBottomBorder;

  final Color decorationLineBorderColor;

  // pillar width
  final double pillarWidth;

  final bool isFittedWidth;

  final bool visibleHeadSeperator;

  final bool visiblePillarSeperator;

  final double headerHeight;

  /// this timeSlot is so important.
  ///
  /// - TimeSlot.full: 15min timeline view.
  ///
  /// you get a 160 height time slot
  ///
  /// - TimeSlot.half: 30min timeline view
  ///
  /// you get a 80 height time slot
  ///
  /// - TimeSlot.quarter: 1h timeline view
  ///
  /// you get a 60 height time slot
  final TimeSlot timeSlot;

  final double timeSlotHeight;

  /// the time item width
  final double timeItemWidth;

  /// decoration line height
  final double decorationLineHeight;

  /// decoration line dash width
  final double decorationLineDashWidth;

  /// event left border width
  final double eventBorderWidth;

  /// decoration line dash space width
  final double decorationLineDashSpaceWidth;

  /// visible time border
  final bool visibleTimeBorder;

  final EdgeInsets pillarViewPadding;

  /// visible decoration border
  final bool visibleTimeDecorationBorder;
  final bool visibleTimelineBorder;

  /// visible decoration border
  final bool visibleTimelineSeparator;
}
