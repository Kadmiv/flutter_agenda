import 'dart:math' as math;

import 'package:flutter/material.dart';

class Utils {
  static bool sameDay(DateTime date, [DateTime? target]) {
    target = target ?? DateTime.now();
    return target.year == date.year &&
        target.month == date.month &&
        target.day == date.day;
  }

  static double pillarWidth(
    int lenght,
    double timeWidth,
    double defaultWidth,
    Orientation orientation,
  ) {
    MediaQueryData mediaData =
        MediaQueryData.fromWindow(WidgetsBinding.instance!.window);
    double screenWidth = mediaData.size.width;
    switch (orientation) {
      case Orientation.portrait:
        if (screenWidth < 480 && lenght < 4) {
          return (screenWidth - timeWidth) / lenght;
        } else if (lenght < 8) {
          return (screenWidth - timeWidth) / lenght;
        } else {
          return defaultWidth;
        }
      case Orientation.landscape:
        if (screenWidth < 480 && lenght < 6) {
          return (screenWidth - timeWidth) / lenght;
        } else if (lenght < 12) {
          return (screenWidth - timeWidth) / lenght;
        } else {
          return defaultWidth;
        }
    }
  }

  static String removeLastWord(String string) {
    List<String> words = string.split(' ');
    if (words.isEmpty) {
      return '';
    }

    return words.getRange(0, words.length - 1).join(' ');
  }

  static String dateFormatter(int year, int month, int day) {
    return year.toString() +
        '-' +
        _addLeadingZero(month) +
        '-' +
        _addLeadingZero(day);
  }

  static String hourFormatter(int hour, int minute) {
    return _addLeadingZero(hour) + ':' + _addLeadingZero(minute);
  }

  static String minFormatter(int minute) {
    return _addLeadingZero(minute);
  }

  static String _addLeadingZero(int number) {
    return (number < 10 ? '0' : '') + number.toString();
  }

  static bool? _exceedHeight(
      List<TextSpan> input, TextStyle textStyle, double height, double width) {
    double fontSize = textStyle.fontSize ?? 14;
    int maxLines = height ~/ ((textStyle.height ?? 1.2) * fontSize);
    if (maxLines == 0) {
      return null;
    }

    TextPainter painter = TextPainter(
      text: TextSpan(
        children: input,
        style: textStyle,
      ),
      maxLines: maxLines,
      textDirection: TextDirection.ltr,
    );
    painter.layout(maxWidth: width);
    return painter.didExceedMaxLines;
  }

  static bool _ellipsize(List<TextSpan> input, [String ellipse = '…']) {
    if (input.isEmpty) {
      return false;
    }

    TextSpan last = input.last;
    String text = last.text!;
    if (text.isEmpty || text == ellipse) {
      input.removeLast();

      if (text == ellipse) {
        _ellipsize(input, ellipse);
      }
      return true;
    }

    String truncatedText;
    if (text.endsWith('\n')) {
      truncatedText = text.substring(0, text.length - 1) + ellipse;
    } else {
      truncatedText = Utils.removeLastWord(text);
      truncatedText =
          truncatedText.substring(0, math.max(0, truncatedText.length - 2)) +
              ellipse;
    }

    input[input.length - 1] = TextSpan(
      text: truncatedText,
      style: last.style,
    );

    return true;
  }
}
