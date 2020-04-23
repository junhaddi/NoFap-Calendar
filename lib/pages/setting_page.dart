import 'package:dynamic_theme/dynamic_theme.dart';
import 'package:flutter/material.dart';
import 'package:nofapcamp/widgets/custom_app_bar.dart';

class SettingPage extends StatefulWidget {
  @override
  _SettingPageState createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> with AutomaticKeepAliveClientMixin {
  bool _darkMode = false;

  // 다른 페이지 이동 할 때에도 상태는 지속 유지
  @override
  bool get wantKeepAlive => true;

  _changeBrightness() {
    DynamicTheme.of(context).setBrightness(Theme.of(context).brightness == Brightness.dark ? Brightness.light: Brightness.dark);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: '설정',
      ),
      body: ListView(
        children: <Widget>[
          SwitchListTile(
            title: Text('다크모드'),
            value: _darkMode,
            onChanged: (value) {
              _changeBrightness();
              setState(() {
                _darkMode = value;
              });
            }
          )
          // CheckboxListTile(
          //   value: true,
          //   title: Text('체크박스'),
          //   onChanged: (value) {},
          // ),
          // SwitchListTile(
          //   value: false,
          //   title: Text('스위치박스'),
          //   onChanged: (value) {},
          // ),
          // ListTile(
          //   title: Text('리스트'),
          //   subtitle: Text('부제목'),
          // ),
          // CheckboxListTile(
          //   value: true,
          //   title: Text('체크박스'),
          //   onChanged: (value) {},
          // ),
          // SwitchListTile(
          //   value: false,
          //   title: Text('스위치박스'),
          //   onChanged: (value) {},
          // ),
          // ListTile(
          //   title: Text('리스트'),
          //   subtitle: Text('부제목'),
          // ),
          // CheckboxListTile(
          //   value: true,
          //   title: Text('체크박스'),
          //   onChanged: (value) {},
          // ),
          // SwitchListTile(
          //   value: false,
          //   title: Text('스위치박스'),
          //   onChanged: (value) {},
          // ),
          // ListTile(
          //   title: Text('리스트'),
          //   subtitle: Text('부제목'),
          // ),
          // CheckboxListTile(
          //   value: true,
          //   title: Text('체크박스'),
          //   onChanged: (value) {},
          // ),
          // SwitchListTile(
          //   value: false,
          //   title: Text('스위치박스'),
          //   onChanged: (value) {},
          // ),
          // ListTile(
          //   title: Text('리스트'),
          //   subtitle: Text('부제목'),
          // ),
        ],
      ),
    );
  }
}
