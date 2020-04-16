import 'package:flutter/material.dart';

// 업적 페이지 화면
class AchievementPage extends StatefulWidget {
  AchievementPage({Key key}) : super(key: key);

  @override
  _AchievementPageState createState() => _AchievementPageState();
}

class _AchievementPageState extends State<AchievementPage> {
  @override
  Widget build(BuildContext context) {
    return Center(
      // 업적
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
