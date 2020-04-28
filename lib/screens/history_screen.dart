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

  List<History> historys = [];

  @override
  void initState() {
    super.initState();
    _getDate();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: historys.isEmpty
          ? Center(
              child: Text('기록이 없습니다!'),
            )
          : ListView(
              children: historys
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
        historys.add(History(
          title: dateMap["progressDay"].toString(),
          description: dateMap["dday"].toString(),
        ));
      });
    });
  }
}
