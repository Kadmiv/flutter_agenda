class EventTime extends DateTime {
  EventTime({
    required int hour,
    required int minute,
  })  : assert(24 >= hour),
        assert(60 >= minute),
        super(
          hour,
          minute,
        );

  EventTime.fromDateTime(DateTime dateTime)
      : super(
          dateTime.year,
          dateTime.month,
          dateTime.day,
          dateTime.hour,
          dateTime.minute,
        );
}
