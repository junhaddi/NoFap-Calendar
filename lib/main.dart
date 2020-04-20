import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:nofapcalendar/screens/walkthrough_screen.dart';
import 'package:nofapcalendar/screens/index_screen.dart';

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
        '/walkthrough': (BuildContext context) =>
            WalkthroughScreen(prefs: prefs),
        '/index': (BuildContext context) => IndexScreen(prefs: prefs),
      },
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: _handleCurrentScreen(),
    );
  }

  // 앱 실행 시 스크린 라우팅
  Widget _handleCurrentScreen() {
    bool isWalkthroughSeen = (prefs.getBool('walkthroughSeen') ?? false);
    if (isWalkthroughSeen) {
      return IndexScreen(prefs: prefs);
    } else {
      return WalkthroughScreen(prefs: prefs);
    }
  }
}
