import 'package:flutter/material.dart';
import 'package:flutter_calendar_carousel/classes/event.dart';
import 'package:flutter_calendar_carousel/classes/event_list.dart';
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart'
    show CalendarCarousel;
import 'package:nofapcalendar/ui/widgets/custom_app_bar.dart';

List<DateTime> presentDates = [
  DateTime(2020, 4, 1),
  DateTime(2020, 4, 2),
  DateTime(2020, 4, 3),
  DateTime(2020, 4, 4),
  DateTime(2020, 4, 5),
  DateTime(2020, 4, 6),
  DateTime(2020, 4, 7),
  DateTime(2020, 4, 8),
  DateTime(2020, 4, 9),
  DateTime(2020, 4, 10),
  DateTime(2020, 4, 11),
];
List<DateTime> absentDates = [
  DateTime(2020, 4, 12),
  DateTime(2020, 4, 13),
  DateTime(2020, 4, 14),
  DateTime(2020, 4, 18),
  DateTime(2020, 4, 19),
  DateTime(2020, 4, 20),
  DateTime(2020, 4, 21),
  DateTime(2020, 4, 22),
  DateTime(2020, 4, 23),
  DateTime(2020, 4, 24),
  DateTime(2020, 4, 25),
];

class CalendarPage extends StatefulWidget {
  @override
  _CalendarPageState createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  static Widget _presentIcon(String day) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
            image: Image.network(
                    'https://pluspng.com/img-png/png-hd-x-open-pluspng-com-x-png-hd-2000.png')
                .image),
      ),
      child: Center(
        child: Text(
          day,
          style: TextStyle(color: Colors.black),
        ),
      ),
    );
  }

  static Widget _absentIcon(String day) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
            image: Image.network(
                    'https://upload.wikimedia.org/wikipedia/commons/thumb/2/26/Check-green.svg/1200px-Check-green.svg.png')
                .image),
      ),
      child: Center(
        child: Text(
          day,
          style: TextStyle(color: Colors.black),
        ),
      ),
    );
  }

  EventList<Event> _markedDateMap = EventList<Event>(
    events: {},
  );

  @override
  Widget build(BuildContext context) {
    for (int i = 0; i < presentDates.length; i++) {
      _markedDateMap.add(
        presentDates[i],
        Event(
          date: presentDates[i],
          title: 'Event 5',
          icon: _presentIcon(
            presentDates[i].day.toString(),
          ),
        ),
      );
    }

    for (int i = 0; i < absentDates.length; i++) {
      _markedDateMap.add(
        absentDates[i],
        Event(
          date: absentDates[i],
          title: 'Event 5',
          icon: _absentIcon(
            absentDates[i].day.toString(),
          ),
        ),
      );
    }

    return Scaffold(
      appBar: CustomAppBar(
        title: '금딸캘린더',
      ),
      body: Column(
        children: <Widget>[
          CalendarCarousel<Event>(
            height: 835,
            todayButtonColor: Theme.of(context).primaryColor,
            markedDatesMap: _markedDateMap,
            markedDateShowIcon: true,
            markedDateIconMaxShown: 1,
            markedDateMoreShowTotal: null,
            markedDateIconBuilder: (event) {
              return event.icon;
            },
          ),
        ],
      ),
    );
  }
}
