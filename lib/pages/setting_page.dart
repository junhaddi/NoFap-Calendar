import 'package:dynamic_theme/dynamic_theme.dart';
import 'package:flutter/material.dart';
import 'package:nofapcamp/models/divider_list_tile.dart';
import 'package:nofapcamp/widgets/custom_app_bar.dart';
import 'package:nofapcamp/widgets/divider_list_group.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../custom_icons_icons.dart';

class SettingPage extends StatefulWidget {
  @override
  _SettingPageState createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  SharedPreferences _prefs;
  String _nickName = '';
  bool _isDarkMode;

  @override
  void initState() {
    super.initState();
    _getNickName();
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
          DividerListGroup(
            title: '계정',
            child: [
              DividerListTile(
                title: '$_nickName님',
                subtitle: '이름 변경하기',
                icon: Icons.account_circle,
                onTap: () {},
              ),
            ],
          ),
          DividerListGroup(
            title: '테마',
            child: [
              DividerListTile(
                title: '다크모드',
                trailing: Switch(
                  value: _isDarkMode,
                  onChanged: (value) {
                    setState(() {
                      _changeBrightness();
                      _isDarkMode = value;
                    });
                  },
                ),
                icon: CustomIcons.moon,
              ),
            ],
          ),
          DividerListGroup(
            title: '기타',
            child: [
              DividerListTile(
                title: '리뷰 남기기',
                icon: Icons.thumb_up,
                onTap: () {},
              ),
              DividerListTile(
                title: '의견 보내기',
                icon: Icons.mail,
                onTap: () {},
              ),
            ],
          ),
        ],
      ),
    );
  }

  Future<void> _getNickName() async {
    _prefs = await SharedPreferences.getInstance();
    _nickName = _prefs.getString('nickName') ?? '';
  }

  void _changeBrightness() {
    DynamicTheme.of(context)
        .setBrightness(_isDarkMode ? Brightness.light : Brightness.dark);
  }
}
