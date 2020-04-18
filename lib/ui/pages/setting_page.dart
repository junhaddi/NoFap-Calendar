import 'package:flutter/material.dart';
import 'package:nofapcalendar/ui/widgets/custom_app_bar.dart';

class SettingPage extends StatefulWidget {
  @override
  _SettingPageState createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: '설정',
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
