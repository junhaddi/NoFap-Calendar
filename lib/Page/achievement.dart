import 'package:flutter/material.dart';

// 업적 페이지 화면
class AchevementPage extends StatefulWidget {
  AchevementPage({Key key}) : super(key: key);

  @override
  _AchevementPageState createState() => _AchevementPageState();
}

class _AchevementPageState extends State<AchevementPage> {
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