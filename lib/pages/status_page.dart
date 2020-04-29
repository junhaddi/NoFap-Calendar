import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:nofapcamp/widgets/numberpicker.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StatusPage extends StatefulWidget {
  @override
  _StatusPageState createState() => _StatusPageState();
}

class _StatusPageState extends State<StatusPage> {
  SharedPreferences _prefs;
  DateTime _srcDate;
  DateTime _dstDate;
  int _progressDay;
  int _dday;
  bool _isLoaded = false;
  bool _isSuccess = false;

  @override
  void initState() {
    super.initState();
    _getDate();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      // TODO 상단 배너광고 추가
      body: Center(
        child: CircularPercentIndicator(
          radius: 280.0,
          lineWidth: 24.0,
          animation: true,
          percent: _isLoaded
              ? max(
                  0.001,
                  min(
                      DateTime.now().difference(_srcDate).inMilliseconds /
                          _dstDate.difference(_srcDate).inMilliseconds,
                      1.0),
                )
              : 0.0,
          center: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              _isLoaded
                  ? Column(
                      children: <Widget>[
                        Text(
                          '$_progressDay일차',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 42.0,
                          ),
                        ),
                        Text(
                          '${_srcDate.year}/${_srcDate.month}/${_srcDate.day}~',
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        Text(
                          'D${_dday < 0 ? '+' : '-'}${_dday == 0 ? 'DAY' : _dday.abs()}',
                          style: TextStyle(
                            fontSize: 24.0,
                          ),
                        ),
                      ],
                    )
                  : Text(
                      '시작하세요',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 42.0,
                      ),
                    ),
              SizedBox(
                height: 10.0,
              ),
              MaterialButton(
                onPressed: () {
                  if (_isLoaded) {
                    if (_isSuccess) {
                      _showResetDialog();
                    } else {
                      _showReconfirmDialog();
                    }
                  } else {
                    _showResetDialog();
                  }
                },
                color: Colors.blueGrey,
                child: Icon(
                  _isLoaded
                      ? _isSuccess ? Icons.star : Icons.pause
                      : Icons.play_arrow,
                  size: 32.0,
                ),
                padding: EdgeInsets.all(8),
                shape: CircleBorder(),
              ),
            ],
          ),
          circularStrokeCap: CircularStrokeCap.round,
          progressColor: Colors.deepPurpleAccent,
        ),
      ),
    );
  }

  Future<void> _getDate() async {
    _prefs = await SharedPreferences.getInstance();
    setState(() {
      _srcDate =
          DateTime.fromMillisecondsSinceEpoch(_prefs.getInt('srcDate') ?? null);
      _dstDate =
          DateTime.fromMillisecondsSinceEpoch(_prefs.getInt('dstDate') ?? null);
      _progressDay = DateTime(
                  DateTime.now().year, DateTime.now().month, DateTime.now().day)
              .difference(DateTime(_srcDate.year, _srcDate.month, _srcDate.day))
              .inDays +
          1;
      _dday = DateTime(_dstDate.year, _dstDate.month, _dstDate.day)
          .difference(DateTime(
              DateTime.now().year, DateTime.now().month, DateTime.now().day))
          .inDays;
      _isLoaded = _srcDate != null && _dstDate != null;
      _isSuccess = DateTime.now().difference(_dstDate).inMilliseconds >= 0;
    });
  }

  void _showReconfirmDialog() async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('싸버렸습니까?'),
          content: Image.network(
            'https://www.mediatoday.co.kr/news/photo/201201/99838_91766_5815.jpg',
          ),
          actions: <Widget>[
            RaisedButton(
              color: Colors.red,
              child: Text('잘못누름'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            RaisedButton(
              child: Text('쌌습니다'),
              onPressed: () {
                Navigator.of(context).pop();
                _showResetDialog();
              },
            ),
          ],
        );
      },
    );
  }

  void _showResetDialog() async {
    showDialog<int>(
        context: context,
        builder: (BuildContext context) {
          return NumberPickerDialog.integer(
            minValue: 1,
            maxValue: 100,
            title: Text('목표일수'),
            initialIntegerValue: 1,
          );
        }).then((int value) {
      if (value != null) {
        setState(() {
          if (_isSuccess) {
            // 목표 달성 성공
            _dstDate = DateTime.now().add(Duration(days: value));
          } else {
            // 목표 달성 실패
            if (_isLoaded) {
              // 기록 저장
              List<String> dateHistorys =
                  _prefs.getStringList('dateHistorys') ?? [];
              dateHistorys.add(
                jsonEncode({
                  'srcDate': _srcDate.millisecondsSinceEpoch,
                  'dstDate': _dstDate.millisecondsSinceEpoch,
                  'progressDay': _progressDay,
                  'dday': _dday,
                }),
              );
              _prefs.setStringList('dateHistorys', dateHistorys);
            }
            _srcDate = DateTime.now();
            _dstDate = _srcDate.add(Duration(days: value));
            _progressDay = 1;
          }
          _dday = DateTime(_dstDate.year, _dstDate.month, _dstDate.day)
              .difference(DateTime(DateTime.now().year, DateTime.now().month,
                  DateTime.now().day))
              .inDays;
          _isLoaded = true;

          // 현황 저장
          _prefs.setInt('srcDate', _srcDate.millisecondsSinceEpoch);
          _prefs.setInt('dstDate', _dstDate.millisecondsSinceEpoch);
        });
      }
    });
  }
}
