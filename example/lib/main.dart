import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_agenda/flutter_agenda.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue),
      home: AgendaScreen(),
    );
  }
}

class AgendaScreen extends StatefulWidget {
  AgendaScreen({Key? key}) : super(key: key);

  @override
  _AgendaScreenState createState() => _AgendaScreenState();
}

TimeSlot _selectedTimeSlot = TimeSlot.full;

class _AgendaScreenState extends State<AgendaScreen> {
  var resources = <Resource<HeaderData, AgendaEvent>>[];

  @override
  void initState() {
    super.initState();
    resources = [
      Resource(
        header: HeaderData(
          title: 'HeaderData 1',
        ),
        events: [
          AgendaEvent(
            startTime: EventTime(hour: 15, minute: 0),
            endTime: EventTime(hour: 16, minute: 30),
          ),
          AgendaEvent(
            startTime: EventTime(hour: 12, minute: 0),
            endTime: EventTime(hour: 13, minute: 20),
          ),
        ],
      ),
      Resource(
        header: HeaderData(
          title: 'HeaderData 2',
        ),
        events: [
          AgendaEvent(
            startTime: EventTime(hour: 9, minute: 10),
            endTime: EventTime(hour: 11, minute: 45),
          ),
        ],
      ),
      Resource(
        header: HeaderData(
          title: 'HeaderData 3',
        ),
        events: [
          AgendaEvent(
            startTime: EventTime(hour: 10, minute: 10),
            endTime: EventTime(hour: 11, minute: 45),
          ),
        ],
      ),
      Resource(
        header: HeaderData(
          title: 'HeaderData 4',
        ),
        events: [
          AgendaEvent(
            startTime: EventTime(hour: 10, minute: 10),
            endTime: EventTime(hour: 11, minute: 45),
          ),
        ],
      ),
      Resource(
        header: HeaderData(
          title: 'HeaderData 5',
        ),
        events: [
          AgendaEvent(
            startTime: EventTime(hour: 10, minute: 10),
            endTime: EventTime(hour: 11, minute: 45),
          ),
        ],
      ),
      Resource(
        header: HeaderData(
          title: 'HeaderData 6',
        ),
        events: [
          AgendaEvent(
            startTime: EventTime(hour: 10, minute: 10),
            endTime: EventTime(hour: 11, minute: 45),
          ),
        ],
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Flutter Agenda'),
          actions: [
            IconButton(
              icon: Icon(Icons.refresh),
              onPressed: () {},
            ),
            IconButton(
              icon: Icon(Icons.add),
              onPressed: () {
                setState(() {
                  resources.addAll([
                    Resource(
                      header: HeaderData(
                        title: '12',
                      ),
                      events: [
                        AgendaEvent(
                          startTime: EventTime(hour: 10, minute: 10),
                          endTime: EventTime(hour: 11, minute: 45),
                        ),
                      ],
                    ),
                    Resource(
                      header: HeaderData(
                        title: '12',
                      ),
                      events: [
                        AgendaEvent(
                          startTime: EventTime(hour: 10, minute: 10),
                          endTime: EventTime(hour: 11, minute: 45),
                        ),
                      ],
                    ),
                  ]);
                });
              },
            ),
            IconButton(
              icon: Icon(Icons.remove),
              onPressed: () {
                setState(() {
                  resources.removeAt(0);
                });
              },
            ),
            IconButton(
              icon: Icon(Icons.event),
              onPressed: () {
                setState(() {
                  resources.first.events.add(
                    AgendaEvent(
                      startTime: EventTime(hour: 9, minute: 0),
                      endTime: EventTime(hour: 11, minute: 45),
                    ),
                  );
                });
              },
            ),
            TextButton(
              child: Text("15 min", style: TextStyle(color: Colors.white)),
              onPressed: () {
                setState(() {
                  _selectedTimeSlot = TimeSlot.quarter;
                });
              },
            ),
            TextButton(
              child: Text("30 min", style: TextStyle(color: Colors.white)),
              onPressed: () {
                setState(() {
                  _selectedTimeSlot = TimeSlot.half;
                });
              },
            ),
            TextButton(
              child: Text("1h", style: TextStyle(color: Colors.white)),
              onPressed: () {
                setState(() {
                  _selectedTimeSlot = TimeSlot.full;
                });
              },
            ),
          ],
        ),
        body: FlutterAgenda<HeaderData, AgendaEvent>(
          resources: resources,
          agendaStyle: AgendaStyle(
            startHour: 9,
            endHour: 20,
            timeSlot: _selectedTimeSlot,
            isFittedWidth: false,
            timeItemWidth: 50,
            headerHeight: 40,
            pillarWidth: 120,
            visibleTimeDecorationBorder: false,
            visibleHeadSeperator: false,
            visibleTimelineSeparator: false,
            visiblePillarSeperator: true,
            cornerBottom: false,
            cornerRight: false,
            mainBackgroundColor: Theme.of(context).colorScheme.surface,
            // timelineBorderColor: Colors.transparent,
            timelineItemColor: Colors.transparent,
          ),
          headerBuilder: _headerBuilder,
          eventBuilder: _eventBuilder,
          timeSlotBuilder: _timeSlotBuilder,
        ),
      ),
    );
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

  Widget _eventBuilder(BuildContext context, dynamic event) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              color: Colors.greenAccent,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Center(
              child: Text(
                hourFormatter(event.start.hour, event.start.minute) +
                    ' - ' +
                    hourFormatter(event.end.hour, event.end.minute) +
                    ' ',
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _headerBuilder(BuildContext context, dynamic header) {
    return Padding(
      padding: const EdgeInsets.all(4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: 16,
            backgroundImage: NetworkImage(
              'https://video-editor.su/images/kak-snimalsya-film-avatar_01.jpg',
            ),
          ),
          Center(
            child: Text(
              header.title,
            ),
          ),
        ],
      ),
    );
  }

  Widget _timeSlotBuilder(BuildContext context, int hour, TimeSlot slotType) {
    switch (slotType) {
      case TimeSlot.half:
        {
          return Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(vertical: 2, horizontal: 5),
                child: Text(
                  Utils.hourFormatter(hour, 0),
                  textAlign: TextAlign.right,
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 2, horizontal: 5),
                child: Text(
                  Utils.hourFormatter(hour, 30),
                  textAlign: TextAlign.right,
                ),
              ),
            ].toList(),
          );
        }
      case TimeSlot.quarter:
        {
          return Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(vertical: 2, horizontal: 5),
                child: Text(
                  Utils.hourFormatter(hour, 0),
                  textAlign: TextAlign.right,
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 2, horizontal: 5),
                child: Text(
                  Utils.minFormatter(15),
                  textAlign: TextAlign.right,
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 2, horizontal: 5),
                child: Text(
                  Utils.hourFormatter(hour, 30),
                  textAlign: TextAlign.right,
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 2, horizontal: 5),
                child: Text(
                  Utils.minFormatter(45),
                  textAlign: TextAlign.right,
                ),
              ),
            ],
          );
        }

      default:
        {
          return Padding(
            padding: const EdgeInsets.all(5.0),
            child: Text(
              Utils.hourFormatter(hour, 0),
              textAlign: TextAlign.right,
            ),
          );
        }
    }
  }
}

class HeaderData extends Header {
  HeaderData({
    required this.title,
    this.subtitle,
    // required this.object,
  }) : super(title);

  String title;
  String? subtitle;
// Object object;
}
