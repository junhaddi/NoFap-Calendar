import 'package:flutter/material.dart';
import 'package:nofapcalendar/ui/screens/walkthrough_screen.dart';
import 'package:nofapcalendar/ui/screens/index_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  bool seen = false;

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
    SharedPreferences prefs = await SharedPreferences.getInstance();
    seen = (prefs.getBool('seen') ?? false);
  }

  Widget _toHome() {
    _handleCurrentScreen();

    if (seen) {
      return new IndexScreen();
    } else {
      return new WalkthroughScreen();
    }
  }
}
