import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarPage extends StatefulWidget {
  CalendarPage({Key key}) : super(key: key);

  @override
  _CalendarPageState createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  CalendarController _calendar;

  @override
  void initState() {
    super.initState();
    _calendar = CalendarController();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: <Widget>[
          TableCalendar(
            calendarController: _calendar,
            headerStyle: HeaderStyle(
              centerHeaderTitle: true,
              formatButtonVisible: false,
            ),
            builders: CalendarBuilders(
              selectedDayBuilder: (context, date, events) => Container(
                margin: EdgeInsets.all(4),
                alignment: Alignment.center,
                child: Icon(
                  Icons.block,
                  size: 50,
                ),
              ),
              todayDayBuilder: (context, date, events) => Container(
                margin: EdgeInsets.all(4),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  date.day.toString(),
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
