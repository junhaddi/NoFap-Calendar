import 'package:flutter/material.dart';

class History {
  final String title;
  final String description;

  History({this.title, this.description});
}

class HistoryScreen extends StatelessWidget {
  List<History> historys = [
    History(
      title: "앙기모띠",
      description: "설명이라오하하하하하하",
    ),
    History(
      title: "앙기모띠",
      description: "설명이라오하하하하하하",
    ),
    History(
      title: "앙기모띠",
      description: "설명이라오하하하하하하",
    ),
    History(
      title: "앙기모띠",
      description: "설명이라오하하하하하하",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar (
        title: Text('기록'),
      ),
      body: Column(
        children: historys
            .map((History history) => Card(
                  child: ListTile(
                    title: Text(history.title),
                    subtitle: Text(history.description),
                  ),
                ))
            .toList(),
      ),
    );
  }
}
