import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:nofapcamp/widgets/custom_app_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';

class History {
  final String title;
  final String description;

  const History({this.title, this.description});
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
      appBar: CustomAppBar(
        title: '도전기록',
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
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50.0),
                      ),
                      child: ListTile(
                        leading: Container(
                          width: 40.0,
                          alignment: Alignment.center,
                          child: Icon(Icons.info),
                        ),
                        title: Text(
                          history.title,
                        ),
                        subtitle: Text(
                          history.description,
                        ),
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
            description: dateMap["term"],
          ),
        );
      });
    });
  }
}
