import 'package:flutter/material.dart';

// 설정 페이지 화면
class SettingPage extends StatefulWidget {
  SettingPage({Key key}) : super(key: key);

  @override
  _SettingPageState createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Center(
          child: Text('설정', style: TextStyle(
            fontSize: 17
          )),
        ),
      ),
      body: ListView(
        children: <Widget>[
          CheckboxListTile(
            value: true,
            title: Text('체크박스'),
            onChanged: (value) {},
          ),
          SwitchListTile(
            value: false,
            title: Text('스위치박스'),
            onChanged: (value) {},
          ),
          ListTile(
            title: Text('리스트'),
            subtitle: Text('부제목'),
          ),
          CheckboxListTile(
            value: true,
            title: Text('체크박스'),
            onChanged: (value) {},
          ),
          SwitchListTile(
            value: false,
            title: Text('스위치박스'),
            onChanged: (value) {},
          ),
          ListTile(
            title: Text('리스트'),
            subtitle: Text('부제목'),
          ),
          CheckboxListTile(
            value: true,
            title: Text('체크박스'),
            onChanged: (value) {},
          ),
          SwitchListTile(
            value: false,
            title: Text('스위치박스'),
            onChanged: (value) {},
          ),
          ListTile(
            title: Text('리스트'),
            subtitle: Text('부제목'),
          ),
          CheckboxListTile(
            value: true,
            title: Text('체크박스'),
            onChanged: (value) {},
          ),
          SwitchListTile(
            value: false,
            title: Text('스위치박스'),
            onChanged: (value) {},
          ),
          ListTile(
            title: Text('리스트'),
            subtitle: Text('부제목'),
          ),
        ],
      ),
    );
  }
}
