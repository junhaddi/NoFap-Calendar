import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:nofapcamp/models/classes.dart';
import 'package:nofapcamp/widgets/custom_app_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:table_calendar/table_calendar.dart';

class History {
  final AssetImage image;
  final String title;
  final String description;

  History({this.image, this.title, this.description});
}

class HistoryScreen extends StatefulWidget {
  @override
  _HistoryScreenState createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  SharedPreferences _prefs;
  CalendarController _calendarController = CalendarController();
  List<History> _historys = [];

  @override
  void initState() {
    super.initState();
    _getDate();
    _calendarController = CalendarController();
  }

  @override
  void dispose() {
    _calendarController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: '도전기록',
      ),
      body: Column(
        children: <Widget>[
          TableCalendar(
            calendarController: _calendarController,
          ),
          Expanded(
            child: ListView(
              children: _historys.reversed
                  .map(
                    (History history) => Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50.0),
                      ),
                      child: ListTile(
                        title: Text(
                          history.title,
                        ),
                        subtitle: Text(
                          history.description,
                        ),
                        trailing: Container(
                          width: 40.0,
                          alignment: Alignment.center,
                          child: Image(
                            image: history.image,
                          ),
                        ),
                      ),
                    ),
                  )
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _getDate() async {
    _prefs = await SharedPreferences.getInstance();
    List<String> dateHistorys = _prefs.getStringList('dateHistorys') ?? [];
    setState(() {
      dateHistorys.forEach((element) {
        Map dateMap = jsonDecode(element);
        _historys.add(
          History(
            image: getClassesImage(dateMap["progressDay"]),
            title: '${dateMap["progressDay"].toString()}일째',
            description: dateMap["term"],
          ),
        );
      });
    });
  }
}
