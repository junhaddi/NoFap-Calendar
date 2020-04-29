import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:nofapcamp/widgets/numberpicker.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StatusPage extends StatefulWidget {
  @override
  _StatusPageState createState() => _StatusPageState();
}

class _StatusPageState extends State<StatusPage> {
  RefreshController _refreshController = RefreshController();
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
      body: SmartRefresher(
        header: WaterDropMaterialHeader(
          color: Theme.of(context).brightness == Brightness.light
              ? Colors.black
              : Colors.white,
        ),
        controller: _refreshController,
        onRefresh: _onRefresh,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            CircularPercentIndicator(
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
              progressColor: Colors.red,
            ),
          ],
        ),
      ),
    );
  }

  void _onRefresh() async {
    await Future.delayed(Duration(milliseconds: 1000));
    _refreshController.refreshCompleted();
    _getDate();
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
    const double circular = 20;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(circular)
          ),
          contentPadding: EdgeInsets.zero,
          // content: ,
          content: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            // borderRadius: BorderRadius.only(
            //   topRight: Radius.circular(circular),
            //   topLeft: Radius.circular(circular)
            // ),
            child: Image.network('https://image.fmkorea.com/files/attach/new/20190723/2895716/51565484/2017469519/0700c9f95979a6383445ef1901a15fdc.jpg', fit: BoxFit.cover),
            // child: Image.network('https://optimal.inven.co.kr/upload/2019/09/03/bbs/i13189999330.png', fit: BoxFit.cover),
          ),
          actions: <Widget>[
            Container(
              height: 170,
              child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text('asdfasdf', style: TextStyle(fontSize: 30)),
                  SizedBox(
                    height: 10,
                  ),  
                  Text(
                    'asdfasdfasdfasdfajweklf;jawklefjalwkejfklawejeflk;awjelkfjawklefjaklwjefklaw;ejwfklaw;jefkllaw;ef',
                    maxLines: 3,
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  ButtonBar(
                    alignment: MainAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(
                        child: RaisedButton(
                          child: Text('취소'),
                          onPressed: () {

                          }
                        ),
                        width: 80,
                      ),
                      SizedBox(
                        width: 30,
                      ),
                      SizedBox(
                        child: RaisedButton(
                          child: Text('확인'),
                          color: Colors.green,
                          textColor: Colors.white,
                          onPressed: () {
                            
                          }
                        ),
                        width: 80,
                      )
                    ],
                  )
                ],
              ),
            )
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
