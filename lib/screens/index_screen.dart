import 'dart:async';
import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_admob/flutter_native_admob.dart';
import 'package:flutter_native_admob/native_admob_controller.dart';
import 'package:nofapcamp/pages/home_page.dart';
import 'package:nofapcamp/pages/setting_page.dart';
import 'package:nofapcamp/pages/status_page.dart';
import 'package:nofapcamp/pages/subscribe_page.dart';
import 'package:nofapcamp/widgets/bottom_navy_bar.dart';
import 'package:nofapcamp/widgets/custom_dialog.dart';

final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

class IndexScreen extends StatefulWidget {
  @override
  _IndexScreenState createState() => _IndexScreenState();
}

class _IndexScreenState extends State<IndexScreen> {
  int _currentIndex = 0;
  PageController _pageController;
  DateTime _currentBackPressTime;

  @override
  void initState() {
    super.initState();
    _fcmListener();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WillPopScope(
        onWillPop: _onWillPop,
        child: PageView(
          controller: _pageController,
          onPageChanged: (index) {
            setState(() => _currentIndex = index);
          },
          children: <Widget>[
            HomePage(),
            StatusPage(),
            SubscribeScreen(),
            SettingPage()
          ],
        ),
      ),
      bottomNavigationBar: BottomNavyBar(
        selectedIndex: _currentIndex,
        onItemSelected: (index) {
          setState(() => _currentIndex = index);
          _pageController.jumpToPage(index);
        },
        items: <BottomNavyBarItem>[
          BottomNavyBarItem(
            icon: Icon(Icons.dashboard),
            title: Text('홈'),
            activeColor: Colors.redAccent,
            textAlign: TextAlign.center,
          ),
          BottomNavyBarItem(
            icon: Icon(Icons.play_circle_filled),
            title: Text('현황'),
            activeColor: Colors.deepPurpleAccent,
            textAlign: TextAlign.center,
          ),
          BottomNavyBarItem(
            icon: Icon(Icons.subscriptions),
            title: Text('구독'),
            activeColor: Colors.indigoAccent,
            textAlign: TextAlign.center,
          ),
          BottomNavyBarItem(
            icon: Icon(Icons.settings),
            title: Text('설정'),
            activeColor: Colors.orangeAccent,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  // FCM 메시지 수신
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

  Future<bool> _onWillPop() async {
    DateTime currentTime = DateTime.now();
    if (_currentBackPressTime == null ||
        currentTime.difference(_currentBackPressTime) > Duration(seconds: 2)) {
      _currentBackPressTime = currentTime;
      _showExitDialog(context);
      return false;
    }
    return true;
  }

  void _showExitDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return CustomDialog(
          subtitle: '금딸캠프를 종료 할까요?',
          child: Container(
            height: 200.0,
            child: NativeAdmob(
              adUnitID: 'ca-app-pub-8336339515298040/6724604841',
              controller: NativeAdmobController(),
              type: NativeAdmobType.full,
            ),
          ),
          event: () {
            Navigator.of(context).pop();
            SystemChannels.platform.invokeMethod('SystemNavigator.pop');
          },
        );
      },
    );
  }
}
