import 'dart:math';
import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:share/share.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StatusPage extends StatefulWidget {
  @override
  _StatusPageState createState() => _StatusPageState();
}

class _StatusPageState extends State<StatusPage> {
  SharedPreferences _prefs;
  Firestore firestore = Firestore.instance;
  DateTime _srcDate;
  DateTime _dstDate;
  int _progressDay;
  int _dday;

  @override
  void initState() {
    super.initState();
    _getDays();
  }

  _getDays() async {
    _prefs = await SharedPreferences.getInstance();
    setState(() {
      _srcDate = DateTime.fromMillisecondsSinceEpoch(
          _prefs.getInt('srcDate') ?? DateTime.now());
      _dstDate = DateTime.fromMillisecondsSinceEpoch(
          _prefs.getInt('dstDate') ?? DateTime.now());
      _progressDay = (_prefs.getInt('progressDay') ?? 0);
      _dday = ((_dstDate.millisecondsSinceEpoch -
                  DateTime.now().millisecondsSinceEpoch) /
              (1000 * 60 * 60 * 24))
          .floor();
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
          _dday = ((_dstDate.millisecondsSinceEpoch -
                      DateTime.now().millisecondsSinceEpoch) /
                  (1000 * 60 * 60 * 24))
              .floor();

          // 저장
          _prefs.setInt('progressDay', _progressDay);
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
                    (DateTime.now().millisecondsSinceEpoch -
                            _srcDate.millisecondsSinceEpoch) /
                        (_dstDate.millisecondsSinceEpoch -
                            _srcDate.millisecondsSinceEpoch),
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
                      'D${_dday < 0.0 ? "+" : "-"}${_dday == 0 ? "DAY" : _dday}',
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
              RaisedButton(
                child: Text('DB 내용 추가'),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                onPressed: () {
                  String book = "준하의 일대기";
                  firestore.collection('books').document(book).setData(
                    {'page': 6969, 'purchase?': false, 'title': '천년의_사랑'},
                  );
                },
              ),
              RaisedButton(
                child: Text('DB 값 읽기'),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                onPressed: () {
                  firestore.collection('books').document('준하의 일대기').get().then(
                    (DocumentSnapshot ds) {
                      print(ds.data["title"]);
                    },
                  );
                },
              ),
              RaisedButton(
                child: Text('DB 데이터 갱신'),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                onPressed: () {
                  firestore.collection('books').document('준하의 일대기').updateData(
                    {'title': '앙 값 바꼈띠!'},
                  );
                },
              ),
              RaisedButton(
                child: Text('DB document/필드 삭제'),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                onPressed: () {
                  // 특정 document 통째로 날리기
                  firestore.collection('books').document('junhaddi').delete();
                  // 특정 document 필드 하나를 삭제
                  firestore.collection('books').document('준하의 일대기').updateData(
                    {'title': FieldValue.delete()},
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
