import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:nofapcamp/pages/home_page.dart';
import 'package:nofapcamp/pages/status_page.dart';
import 'package:nofapcamp/pages/achievement_page.dart';
import 'package:nofapcamp/pages/setting_page.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:io';

final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

// VPN 사용유무 감지
Future<bool> checkVPN() async {
  try {
    final response = await http.get('https://pornhub.com');
    if (response.statusCode == 200) {
      print('USE VPN');
      return true;
    } else {
      print('NON VPN');
      return false;
    }
  } catch (e) {
    // ISP 차단
    print('NON VPN');
    return false;
  }
}

class IndexScreen extends StatefulWidget {
  final SharedPreferences prefs;

  IndexScreen({this.prefs});

  @override
  _IndexScreenState createState() => _IndexScreenState();
}

class _IndexScreenState extends State<IndexScreen> {
  int _page = 0;
  PageController _c;
  DateTime currentBackPressTime;

  var _everyPage = <Widget>[
    HomePage(),
    StatusPage(),
    AchievementPage(),
    SettingPage()
  ];

  var _bottomItem = <BottomNavigationBarItem>[
    BottomNavigationBarItem(
      icon: Icon(Icons.home),
      title: Text('홈'),
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.calendar_today),
      title: Text('현황'),
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.cake),
      title: Text('업적'),
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.settings),
      title: Text('설정'),
    ),
  ];

  @override
  void initState() {
    super.initState();
    
    checkVPN();
    _fcmListener();
    _c = PageController(
      initialPage: _page,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WillPopScope(
        onWillPop: onWillPop,
        child: PageView(
          controller: _c,
          onPageChanged: (newPage) {
            setState(() {
              this._page = newPage;
            });
          },
          children: _everyPage,
        ),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(boxShadow: <BoxShadow>[
          BoxShadow(
            color: Color.fromRGBO(211, 211, 211, 1.0),
          ),
        ]),
        child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          currentIndex: _page,
          onTap: (index) {
            this._c.animateToPage(index,
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut);
          },
          items: _bottomItem,
        ),
      ),
    );
  }

  void _fcmListener() {
    if (Platform.isIOS) {
      _firebaseMessaging.requestNotificationPermissions(
          IosNotificationSettings(sound: true, badge: true, alert: true));
      _firebaseMessaging.onIosSettingsRegistered
          .listen((IosNotificationSettings settings) {
        print('Settings registered: $settings');
      });
    }
    _firebaseMessaging.getToken().then((token) {
      print('token: $token');
    });

    _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        print('on message: $message');
      },
      onResume: (Map<String, dynamic> message) async {
        print('on resume: $message');
      },
      onLaunch: (Map<String, dynamic> message) async {
        print('on launch: $message');
      },
    );
  }

  void _showExitDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
          content: Column(
            children: <Widget>[
              Image.network(
                  'https://pds.joins.com/news/component/htmlphoto_mmdata/201904/30/26fe5ce4-bbb6-4085-a7b6-ae85caf0f177.jpg'),
              Text('금딸캠프를 종료할까요?'),
            ],
          ),
          actions: <Widget>[
            RaisedButton(
              child: Text('취소'),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            RaisedButton(
              child: Text('종료'),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }

  Future<bool> onWillPop() async {
    DateTime currentTime = DateTime.now();
    if (currentBackPressTime == null ||
        currentTime.difference(currentBackPressTime) > Duration(seconds: 2)) {
      currentBackPressTime = currentTime;
      _showExitDialog(context);
      return false;
    }
    return true;
  }
}
