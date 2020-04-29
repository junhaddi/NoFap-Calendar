import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class History {
  final String title;
  final String description;

  History({this.title, this.description});
}

class HistoryScreen extends StatefulWidget {
  @override
  _HistoryScreenState createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  SharedPreferences _prefs;

  List<History> _historys = [];

  @override
  void initState() {
    super.initState();
    _getDate();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('도전기록'),
      ),
      body: _historys.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(
                    Icons.history,
                    size: 42.0,
                    color: Colors.grey,
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Text(
                    '기록이 없습니다',
                    style: TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            )
          : ListView(
              children: _historys.reversed
                  .map(
                    (History history) => Card(
                      child: ListTile(
                        title: Text(history.title),
                        subtitle: Text(history.description),
                      ),
                    ),
                  )
                  .toList(),
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
            title: '${dateMap["progressDay"].toString()}일째',
            description: dateMap["dday"].toString(),
          ),
        );
      });
    });
  }
}
