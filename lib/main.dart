import 'package:flutter/material.dart';

import 'router.dart';
import 'Page/home.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '금딸캘린더',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      onGenerateRoute: onGenerateRoute,
      home: MyHomePage(),
    );
  }
}
