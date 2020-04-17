import 'package:flutter/material.dart';

class AchievementPage extends StatefulWidget {
  AchievementPage({Key key}) : super(key: key);

  @override
  _AchievementPageState createState() => _AchievementPageState();
}

class _AchievementPageState extends State<AchievementPage> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Icon(Icons.cake),
          Text('업적'),
        ],
      ),
    );
  }
}
