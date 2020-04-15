import 'package:flutter/material.dart';

import 'package:table_calendar/table_calendar.dart';

// 캘린더 페이지 화면
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
      // 캘린더
      child: Column(
        children: <Widget>[
          TableCalendar(
            headerStyle: HeaderStyle(
              centerHeaderTitle: true,
              formatButtonVisible: false,
            ),
            builders: CalendarBuilders(
              selectedDayBuilder: (context, date, events) => Container(
                margin: EdgeInsets.all(4),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(
                        'https://upload.wikimedia.org/wikipedia/commons/thumb/4/48/Dark_Red_x.svg/600px-Dark_Red_x.svg.png'),
                  ),
                ),
                child: Text(
                  date.day.toString(),
                  style: TextStyle(color: Colors.white),
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
            calendarController: _calendar,
          ),
        ],
      ),
    );
  }
}