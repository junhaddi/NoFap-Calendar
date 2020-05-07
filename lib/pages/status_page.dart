import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:nofapcamp/widgets/custom_dialog.dart';
import 'package:nofapcamp/widgets/numberpicker.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StatusPage extends StatefulWidget {
  @override
  _StatusPageState createState() => _StatusPageState();
}

class _StatusPageState extends State<StatusPage> {
  SharedPreferences _prefs;
  DateTime _initDate;
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
      body: SafeArea(
        child: Center(
          child: CircularPercentIndicator(
            radius: 280.0,
            lineWidth: 24.0,
            circularStrokeCap: CircularStrokeCap.round,
            progressColor: Colors.deepPurpleAccent,
            animation: true,
            animateFromLastPercent: true,
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
                            '${_initDate.year}/${_initDate.month}/${_initDate.day}~',
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
                Image(
                  height: 64.0,
                  image: AssetImage('assets/classes/classes_20.png'),
                ),
              ],
            ),
            footer: Column(
              children: <Widget>[
                RaisedButton(
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
                  padding: EdgeInsets.all(8.0),
                  shape: CircleBorder(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _getDate() async {
    _prefs = await SharedPreferences.getInstance();
    setState(() {
      _initDate = DateTime.fromMillisecondsSinceEpoch(
          _prefs.getInt('initDate') ?? null);
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
      _isLoaded = _initDate != null && _srcDate != null && _dstDate != null;
      _isSuccess = DateTime.now().difference(_dstDate).inMilliseconds >= 0;
    });
  }

  void _showReconfirmDialog() async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return CustomDialog(
          title: '금딸실패',
          content: '사실이라면 정말 실망입니다.',
          event: () {
            Navigator.of(context).pop();
            _showResetDialog();
          },
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
            _srcDate = DateTime.now();
            _dstDate = DateTime.now().add(Duration(days: value));
          } else {
            // 목표 달성 실패
            if (_isLoaded) {
              // 기록 저장
              List<String> dateHistorys =
                  _prefs.getStringList('dateHistorys') ?? [];
              dateHistorys.add(
                jsonEncode({
                  'progressDay': _progressDay,
                  'term':
                      '${_initDate.year}/${_initDate.month}/${_initDate.day}~${DateTime.now().year}/${DateTime.now().month}/${DateTime.now().day}',
                }),
              );
              _prefs.setStringList('dateHistorys', dateHistorys);
            }
            _initDate = DateTime.now();
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
          _prefs.setInt('initDate', _initDate.millisecondsSinceEpoch);
          _prefs.setInt('srcDate', _srcDate.millisecondsSinceEpoch);
          _prefs.setInt('dstDate', _dstDate.millisecondsSinceEpoch);
        });
      }
    });
  }
}
