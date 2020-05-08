import 'package:dynamic_theme/dynamic_theme.dart';
import 'package:flutter/material.dart';
import 'package:nofapcamp/custom_icons_icons.dart';
import 'package:nofapcamp/widgets/custom_app_bar.dart';

class SettingPage extends StatefulWidget {
  @override
  _SettingPageState createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  bool _isAllowAlert;
  bool _isDarkMode;

  void _changeBrightness() {
    DynamicTheme.of(context)
        .setBrightness(_isDarkMode ? Brightness.light : Brightness.dark);
  }

  @override
  void initState() {
    super.initState();
    _isAllowAlert = false;
    _isDarkMode = DynamicTheme.of(context).brightness == Brightness.dark;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: '설정',
      ),
      body: ListView(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left: 20.0, top: 8.0, bottom: 8.0),
            child: Text(
              '일반',
              style: TextStyle(
                fontSize: 16.0,
                color: Colors.orangeAccent,
              ),
            ),
          ),
          Container(
            child: Ink(
              child: Column(
                children: <Widget>[
                  ListTile(
                    leading: Container(
                      width: 40.0,
                      alignment: Alignment.center,
                      child: Icon(CustomIcons.facebook),
                    ),
                    title: Text('계정'),
                    subtitle: Text('rkdwnsgk05@gmail.com'),
                    onTap: () {},
                  ),
                  Divider(),
                  ListTile(
                    leading: Container(
                      width: 40.0,
                      alignment: Alignment.center,
                      child: Icon(Icons.translate),
                    ),
                    title: Text('언어'),
                    subtitle: Text('한국어'),
                    onTap: () {},
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20.0, top: 8.0, bottom: 8.0),
            child: Text(
              '설정',
              style: TextStyle(
                fontSize: 16.0,
                color: Colors.orangeAccent,
              ),
            ),
          ),
          Container(
            child: Ink(
              child: Column(
                children: <Widget>[
                  ListTile(
                    leading: Container(
                      width: 40.0,
                      alignment: Alignment.center,
                      child: Icon(Icons.notifications),
                    ),
                    title: Text('알림허용'),
                    trailing: Switch(
                      value: _isAllowAlert,
                      onChanged: (value) {
                        setState(() {
                          _isAllowAlert = value;
                        });
                      },
                    ),
                  ),
                  Divider(),
                  ListTile(
                    leading: Container(
                      width: 40.0,
                      alignment: Alignment.center,
                      child: Icon(CustomIcons.moon),
                    ),
                    title: Text('다크모드'),
                    trailing: Switch(
                      value: _isDarkMode,
                      onChanged: (value) {
                        setState(() {
                          _changeBrightness();
                          _isDarkMode = value;
                        });
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20.0, top: 8.0, bottom: 8.0),
            child: Text(
              '기타',
              style: TextStyle(
                fontSize: 16.0,
                color: Colors.orangeAccent,
              ),
            ),
          ),
          Container(
            child: Ink(
              child: Column(
                children: <Widget>[
                  ListTile(
                    leading: Container(
                      width: 40.0,
                      alignment: Alignment.center,
                      child: Icon(Icons.thumb_up),
                    ),
                    title: Text('리뷰 남기기'),
                    onTap: () {},
                  ),
                  Divider(),
                  ListTile(
                    leading: Container(
                      width: 40.0,
                      alignment: Alignment.center,
                      child: Icon(Icons.mail),
                    ),
                    title: Text('의견 보내기'),
                    onTap: () {},
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
