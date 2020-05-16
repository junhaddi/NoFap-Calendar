import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:nofapcamp/models/classes.dart';
import 'package:nofapcamp/models/history.dart';
import 'package:nofapcamp/widgets/custom_app_bar.dart';
import 'package:nofapcamp/widgets/inkwell_card.dart';
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
  Map<DateTime, List> _events = {};

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
            events: _events,
            availableCalendarFormats: const {
              CalendarFormat.month: '한달',
              CalendarFormat.twoWeeks: '2주',
              CalendarFormat.week: '주간',
            },
            calendarStyle: CalendarStyle(
              highlightSelected: false,
            ),
            headerStyle: HeaderStyle(
              formatButtonShowsNext: false,
              titleTextBuilder: (date, locale) {
                return '${date.month}월 ${date.year}';
              },
              titleTextStyle: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
              formatButtonDecoration: BoxDecoration(
                color: Colors.blueAccent[700],
                borderRadius: BorderRadius.circular(50.0),
              ),
              formatButtonTextStyle: TextStyle(
                fontSize: 16.0,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
              leftChevronIcon: Icon(Icons.arrow_back_ios),
              rightChevronIcon: Icon(Icons.arrow_forward_ios),
            ),
            daysOfWeekStyle: DaysOfWeekStyle(dowTextBuilder: (date, locale) {
              String week;
              switch (date.weekday) {
                case 1:
                  week = '월';
                  break;
                case 2:
                  week = '화';
                  break;
                case 3:
                  week = '수';
                  break;
                case 4:
                  week = '목';
                  break;
                case 5:
                  week = '금';
                  break;
                case 6:
                  week = '토';
                  break;
                case 7:
                  week = '일';
                  break;
              }
              return week;
            }),
            builders: CalendarBuilders(
              markersBuilder: (context, date, events, holidays) {
                final children = <Widget>[];
                if (events.isNotEmpty) {
                  children.add(
                    events[0] == 0
                        ? Center(
                            child: Container(
                              height: 40.0,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.blueAccent[events[1]],
                              ),
                              child: Center(
                                child: Text(
                                  '${date.day}',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          )
                        : Center(
                            child: Container(
                              height: 40.0,
                              decoration: BoxDecoration(
                                color: Colors.blueAccent[events[1]],
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(
                                    events[0] == 1 ? 50.0 : 0.0,
                                  ),
                                  topRight: Radius.circular(
                                    events[0] == 3 ? 50.0 : 0.0,
                                  ),
                                  bottomLeft: Radius.circular(
                                    events[0] == 1 ? 50.0 : 0.0,
                                  ),
                                  bottomRight: Radius.circular(
                                    events[0] == 3 ? 50.0 : 0.0,
                                  ),
                                ),
                              ),
                              child: Center(
                                child: Text(
                                  '${date.day}',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ),
                  );
                }
                return children;
              },
            ),
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
                    children: _historys.reversed
                        .map(
                          (History history) => InkWellCard(
                            baseBorderRadius: BorderRadius.circular(4.0),
                            baseMarginValue: EdgeInsets.only(
                              left: 4.0,
                              right: 4.0,
                            ),
                            onTap: () {
                              setState(() {
                                _calendarController
                                    .setSelectedDay(history.srcDate);
                              });
                            },
                            child: ListTile(
                              title: Text(
                                history.title,
                              ),
                              subtitle: Text(
                                '${history.srcDate.year}/${history.srcDate.month}/${history.srcDate.day}~${history.dstDate.year}/${history.dstDate.month}/${history.dstDate.day}',
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
    DateTime initDate = DateTime.fromMillisecondsSinceEpoch(
        _prefs.getInt('initDate') ?? DateTime.now().millisecondsSinceEpoch);
    initDate = DateTime(initDate.year, initDate.month, initDate.day);
    List<String> dateHistoryList = _prefs.getStringList('dateHistorys') ?? [];
    setState(() {
      // 도전기록 불러오기
      for (int i = 0; i < dateHistoryList.length; i++) {
        String element = dateHistoryList[i];
        Map dateMap = jsonDecode(element);
        _historys.add(
          History(
            title: '[${i + 1}차] ${dateMap['progressDay'].toString()}일째',
            srcDate: DateTime.fromMillisecondsSinceEpoch(dateMap['srcDate']),
            dstDate: DateTime.fromMillisecondsSinceEpoch(dateMap['dstDate']),
            image: getClassesImage(dateMap['progressDay']),
          ),
        );
      }
      /*
       {shape}
       0: ([])
       1: (
       2:  []
       3:    )
      */
      int shape;

      // 도전기록 캘린더 표시
      int color = 200;
      _historys.forEach((history) {
        for (DateTime dt = history.srcDate;
            dt.difference(history.dstDate).inDays < 0;
            dt = dt.add(Duration(days: 1))) {
          if (dt == history.srcDate) {
            if (dt
                    .difference(history.dstDate.subtract(Duration(days: 1)))
                    .inDays ==
                0) {
              shape = 0;
            } else {
              shape = 1;
            }
          } else {
            if (dt
                    .difference(history.dstDate.subtract(Duration(days: 1)))
                    .inDays ==
                0) {
              shape = 3;
            } else {
              shape = 2;
            }
          }
          _events.addAll({
            dt: [shape, color]
          });
        }
        switch (color) {
          case 200:
            color = 400;
            break;
          case 400:
            color = 700;
            break;
          case 700:
            color = 200;
            break;
        }
      });

      // 현황 캘린더 표시
      DateTime now = DateTime(
          DateTime.now().year, DateTime.now().month, DateTime.now().day);
      for (DateTime dt = initDate;
          dt.difference(now).inDays <= 0;
          dt = dt.add(Duration(days: 1))) {
        if (dt == initDate) {
          if (dt.difference(now).inDays == 0) {
            shape = 0;
          } else {
            shape = 1;
          }
        } else {
          if (dt.difference(now).inDays == 0) {
            shape = 3;
          } else {
            shape = 2;
          }
        }
        _events.addAll({
          dt: [shape, 100]
        });
      }
    });
  }
}
