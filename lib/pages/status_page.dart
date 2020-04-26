import 'dart:math';
import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:share/share.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StatusPage extends StatefulWidget {
  @override
  _StatusPageState createState() => _StatusPageState();
}

class _StatusPageState extends State<StatusPage> {
  SharedPreferences _prefs;
  DateTime _srcDate = DateTime.now();
  DateTime _dstDate = DateTime.now();
  int _progressDay;
  int _dday;

  @override
  void initState() {
    super.initState();

    _getDate();
  }

  _getDate() async {
    _prefs = await SharedPreferences.getInstance();
    setState(() {
      _srcDate =
          DateTime.fromMillisecondsSinceEpoch(_prefs.getInt('srcDate') ?? null);
      _dstDate =
          DateTime.fromMillisecondsSinceEpoch(_prefs.getInt('dstDate') ?? null);
      _progressDay = DateTime.now().difference(_srcDate).inDays + 1;
      _dday = _dstDate.difference(DateTime.now()).inDays;
    });
  }

  _showDialog() async {
    showDialog<int>(
        context: context,
        builder: (BuildContext context) {
          return NumberPickerDialog.integer(
            minValue: 1,
            maxValue: 100,
            title: Text('목표 일수'),
            initialIntegerValue: 1,
          );
        }).then((int value) {
      if (value != null) {
        setState(() {
          _srcDate = DateTime.now();
          _dstDate = _srcDate.add(Duration(days: value));
          _progressDay = 1;
          _dday = _dstDate.difference(DateTime.now().add(Duration(milliseconds: -1))).inDays;

          // 저장
          _prefs.setInt('srcDate', _srcDate.millisecondsSinceEpoch);
          _prefs.setInt('dstDate', _dstDate.millisecondsSinceEpoch);
        });
      }
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('현황'),
        actions: [
          IconButton(
            icon: Icon(Icons.history),
            onPressed: () {
              Navigator.of(context).pushNamed('/history');
            },
          ),
          IconButton(
            icon: Icon(Icons.share),
            onPressed: () {
              RenderBox box = context.findRenderObject();
              String text = "anggimoddi";
              Share.share(text,
                  subject: text,
                  sharePositionOrigin:
                      box.localToGlobal(Offset.zero) & box.size);
            },
          ),
        ],
      ),
      body: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              CircularPercentIndicator(
                radius: 240.0,
                lineWidth: 26.0,
                animation: true,
                percent: min(
                    (DateTime.now().difference(_srcDate).inMinutes) /
                        (_dstDate.difference(_srcDate).inMinutes),
                    1.0),
                center: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      "$_progressDay일차",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 42.0,
                      ),
                    ),
                    Text("${_srcDate.year}/${_srcDate.month}/${_srcDate.day}~"),
                    SizedBox(height: 10),
                    Text(
                      'D${_dday < 0 ? "+" : "-"}${_dday == 0 ? "DAY" : _dday}',
                      style: TextStyle(
                        fontSize: 24.0,
                      ),
                    )
                  ],
                ),
                circularStrokeCap: CircularStrokeCap.round,
                progressColor: Colors.red,
              ),
              RaisedButton(
                child: Icon(Icons.warning),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                onPressed: _showDialog,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
