import 'package:flutter/material.dart';

class CanlendarPage extends StatefulWidget {
  CanlendarPage({Key key}) : super(key: key);

  @override
  _CanlendarPageState createState() => _CanlendarPageState();
}

class _CanlendarPageState extends State<CanlendarPage> {

  @override
  void initState() {
    super.initState();

    print('asdfasdf');

    Future.delayed(Duration(
      seconds: 3
    ), () {
      Navigator.pop(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green,
      body: Center(
        child: Text(
          'Hello 준하',
          style: TextStyle(
            fontSize: 35
          ),
        ),
      ),
    );
  }
}