import 'package:dynamic_theme/dynamic_theme.dart';
import 'package:flutter/material.dart';

class SettingPage extends StatefulWidget {
  @override
  _SettingPageState createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  bool _isDarkMode;

  void _changeBrightness() {
    DynamicTheme.of(context)
        .setBrightness(_isDarkMode ? Brightness.light : Brightness.dark);
  }

  @override
  void initState() {
    super.initState();
    _isDarkMode = DynamicTheme.of(context).brightness == Brightness.dark;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
