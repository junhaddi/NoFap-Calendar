import 'package:dynamic_theme/dynamic_theme.dart';
import 'package:flutter/material.dart';
import 'package:nofapcamp/screens/history_screen.dart';
import 'package:nofapcamp/screens/index_screen.dart';
import 'package:nofapcamp/screens/nickname_screen.dart';
import 'package:nofapcamp/screens/ranking_screen.dart';
import 'package:nofapcamp/screens/viewmore.dart';
import 'package:nofapcamp/screens/walkthrough_screen.dart';
import 'package:nofapcamp/screens/wisesaying_screen.dart';
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
    return DynamicTheme(
      defaultBrightness: (prefs.getBool('isDark') ?? false
          ? Brightness.dark
          : Brightness.light),
      data: (brightness) {
        return brightness == Brightness.light
            ? ThemeData(
                // 기본모드 테마
                primarySwatch: Colors.grey,
                primaryColor: Colors.white,
                brightness: Brightness.light,
                accentColor: Colors.black,
                fontFamily: 'NanumBarunGothic',
              )
            : ThemeData(
                // 다크모드 테마
                primarySwatch: Colors.grey,
                primaryColor: Colors.black,
                brightness: Brightness.dark,
                accentColor: Colors.white,
                fontFamily: 'NanumBarunGothic',
              );
      },
      themedWidgetBuilder: (context, theme) {
        return MaterialApp(
          title: '금딸캠프',
          theme: theme,
          debugShowCheckedModeBanner: false,
          routes: <String, WidgetBuilder>{
            '/walkthrough': (BuildContext context) =>
                WalkthroughScreen(prefs: prefs),
            '/index': (BuildContext context) => IndexScreen(),
            '/nickname': (BuildContext context) => NicknameScreen(),
            '/wisesaying': (BuildContext context) => WisesayingScreen(),
            '/history': (BuildContext context) => HistoryScreen(),
            '/ranking': (BuildContext context) => RankingScreen(),
            '/viewmore': (BuildContext context) => ViewmoreScreen(),
          },
          home: _handleCurrentScreen(),
        );
      },
    );
  }

  // 앱 실행 시 스크린 라우팅
  Widget _handleCurrentScreen() {
    bool isWalkthroughSeen = (prefs.getBool('walkthroughSeen') ?? false);
    if (isWalkthroughSeen) {
      return IndexScreen();
    } else {
      return WalkthroughScreen(prefs: prefs);
    }
  }
}
