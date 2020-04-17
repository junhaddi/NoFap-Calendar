import 'package:flutter/material.dart';
import 'package:nofapcalendar/ui/screens/walkthrough_screen.dart';
import 'package:nofapcalendar/ui/screens/index_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences.getInstance().then((prefs) {
    runApp(MyApp(prefs: prefs));
  });
}

class MyApp extends StatelessWidget {
  final SharedPreferences prefs;

  MyApp({this.prefs});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '금딸캘린더',
      debugShowCheckedModeBanner: false,
      routes: <String, WidgetBuilder>{
        '/walkthrough': (BuildContext context) => WalkthroughScreen(),
        '/index': (BuildContext context) => IndexScreen(),
      },
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: _handleCurrentScreen(),
    );
  }

  Widget _handleCurrentScreen() {
    bool seen = (prefs.getBool('seen') ?? false);
    if (seen) {
      return IndexScreen();
    } else {
      return WalkthroughScreen(prefs: prefs);
    }
  }
}
