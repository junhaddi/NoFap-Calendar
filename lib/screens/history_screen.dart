import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:nofapcamp/models/classes.dart';
import 'package:nofapcamp/models/history.dart';
import 'package:nofapcamp/widgets/custom_app_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:table_calendar/table_calendar.dart';

class HistoryScreen extends StatefulWidget {
  @override
  _HistoryScreenState createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  SharedPreferences _prefs;
  CalendarController _calendarController;
  List<History> _historys = [];

  @override
  void initState() {
    super.initState();
    _calendarController = CalendarController();
    _getHistoryDate();
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
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Column(
        children: <Widget>[
          TableCalendar(
            calendarController: _calendarController,
          ),
          Expanded(
            child: _historys.isEmpty
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Icon(
                        Icons.event,
                        color: Colors.grey,
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Text(
                        '도전기록이 없습니다',
                        style: TextStyle(color: Colors.grey),
                      ),
                    ],
                  )
                : ListView(
                    // TODO 카드 클릭시 캘린더 이동
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
                              trailing: Image(
                                width: 40.0,
                                image: history.image,
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

  Future<void> _getHistoryDate() async {
    _prefs = await SharedPreferences.getInstance();
    List<String> dateHistoryList = _prefs.getStringList('dateHistorys') ?? [];
    setState(() {
      for (int i = 0; i < dateHistoryList.length; i++) {
        String element = dateHistoryList[i];
        Map dateMap = jsonDecode(element);
        _historys.add(
          History(
            title: '[${i + 1}차] ${dateMap['progressDay'].toString()}일째',
            description: dateMap['term'],
            image: getClassesImage(dateMap['progressDay']),
          ),
        );
      }
    });
  }
}
