import 'dart:convert';
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
  DateTime _srcDate;
  DateTime _dstDate;
  int _progressDay;
  int _dday;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _getDate();
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
              String text = '공유';
              Share.share(
                text,
                subject: text,
                sharePositionOrigin: box.localToGlobal(Offset.zero) & box.size,
              );
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
                percent: _isLoading
                    ? 0.0
                    : max(
                        0.001,
                        min(
                            DateTime.now().difference(_srcDate).inMinutes /
                                _dstDate.difference(_srcDate).inMinutes,
                            1.0),
                      ),
                center: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    _isLoading
                        ? CircularProgressIndicator()
                        : Column(
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
                                height: 10,
                              ),
                              Text(
                                'D${_dday < 0 ? '+' : '-'}${_dday == 0 ? 'DAY' : _dday.abs()}',
                                style: TextStyle(
                                  fontSize: 24.0,
                                ),
                              ),
                            ],
                          ),
                  ],
                ),
                circularStrokeCap: CircularStrokeCap.round,
                // TODO 목표 현황에 따라 그래프 색상 변화
                progressColor: Colors.red,
              ),
              RaisedButton(
                // TODO 목표 현황에 따라 아이콘 변경(포기/달성)
                // TODO 버튼 디자인 수정
                child: Icon(Icons.warning),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(100.0),
                ),
                onPressed: _isLoading ? _showResetDialog : _showReconfirmDialog,
              ),
            ],
          ),
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
      _isLoading = _srcDate == null && _dstDate == null;
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
            title: Text('목표 일수'),
            initialIntegerValue: 1,
          );
        }).then((int value) {
      if (value != null) {
        setState(() {
          if (!_isLoading) {
            // 기록 저장
            List<String> dateHistorys =
                (_prefs.getStringList('dateHistorys') ?? []);
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
          // TODO 목표 달성시 처리
          _srcDate = DateTime.now();
          _dstDate = _srcDate.add(Duration(days: value));
          _progressDay = 1;
          _dday = DateTime(_dstDate.year, _dstDate.month, _dstDate.day)
              .difference(DateTime(DateTime.now().year, DateTime.now().month,
                  DateTime.now().day))
              .inDays;
          _isLoading = false;

          // 현황 저장
          _prefs.setInt('srcDate', _srcDate.millisecondsSinceEpoch);
          _prefs.setInt('dstDate', _dstDate.millisecondsSinceEpoch);
        });
      }
    });
  }
}
