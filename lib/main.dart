import 'package:flutter/material.dart';
import 'package:nofapcalendar/ui/screens/walkthrough_screen.dart';
import 'package:nofapcalendar/ui/screens/index_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
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
      home: _handleCurrentScreen(),
    );
  }

  Widget _handleCurrentScreen() {
//    bool seen = (prefs.getBool('seen') ?? false);
//    if (seen) {
//      return new RootScreen();
//    } else {
//      return new WalkthroughScreen(prefs: prefs);
//    }
    return new WalkthroughScreen();
  }
}
