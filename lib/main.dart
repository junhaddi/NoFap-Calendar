import 'package:dynamic_theme/dynamic_theme.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:nofapcamp/screens/walkthrough_screen.dart';
import 'package:nofapcamp/screens/index_screen.dart';
import 'package:background_fetch/background_fetch.dart';

void backgroundFetchHeadlessTask(String taskId) async {
  print('[BackgroundFetch] Headless event received.');
  BackgroundFetch.finish(taskId);
}

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences.getInstance().then((prefs) {
    runApp(MyApp(prefs: prefs));
  });
  BackgroundFetch.registerHeadlessTask(backgroundFetchHeadlessTask);
}

class MyApp extends StatelessWidget {
  final SharedPreferences prefs;

  MyApp({this.prefs});

  @override
  Widget build(BuildContext context) {
    return DynamicTheme(
      defaultBrightness: Brightness.light,
      data: (brightness) => ThemeData(
        brightness: brightness,
        primarySwatch: Colors.red
      ),
      themedWidgetBuilder: (context, theme) => MaterialApp(
        title: '금딸캘린더',
        theme: theme,
        debugShowCheckedModeBanner: false,
        routes: <String, WidgetBuilder>{
          '/walkthrough': (BuildContext context) =>
              WalkthroughScreen(prefs: prefs),
          '/index': (BuildContext context) => IndexScreen(prefs: prefs),
        },
        home: _handleCurrentScreen(),
      ),
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
