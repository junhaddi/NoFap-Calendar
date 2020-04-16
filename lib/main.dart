import 'package:flutter/material.dart';
import 'package:nofapcalendar/ui/screens/walkthrough_screen.dart';
import 'package:nofapcalendar/ui/screens/index_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  SharedPreferences prefs;
  bool isSeen = false;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '금딸캘린더',
      debugShowCheckedModeBanner: false,
      routes: <String, WidgetBuilder>{
        '/walkthrough': (BuildContext context) => new WalkthroughScreen(),
        '/index': (BuildContext context) => new IndexScreen(),
      },
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: _toHome(),
    );
  }

  _handleCurrentScreen() async {
    prefs = await SharedPreferences.getInstance();
    isSeen = (prefs.getBool('seen') ?? false);
    print(isSeen);
    if (isSeen) {
      print('메인');
      return new IndexScreen();
    } else {
      print('웰컴');
      return new WalkthroughScreen(prefs: prefs);
    }
  }

  Widget _toHome() {
    _handleCurrentScreen();
    return Scaffold();
  }
}
