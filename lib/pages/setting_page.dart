import 'package:dynamic_theme/dynamic_theme.dart';
import 'package:flutter/material.dart';

class SettingPage extends StatefulWidget {
  @override
  _SettingPageState createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  bool _isDarkMode = false;

  void _changeBrightness() {
    DynamicTheme.of(context).setBrightness(
        _isDarkMode ? Brightness.light : Brightness.dark);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('설정'),
      ),
      body: ListView(
        children: <Widget>[
          SwitchListTile(
            title: Text('다크모드'),
            value: _isDarkMode,
            onChanged: (value) {
              setState(() {
                _changeBrightness();
                _isDarkMode = value;
              });
            },
          ),
        ],
      ),
    );
  }
}
