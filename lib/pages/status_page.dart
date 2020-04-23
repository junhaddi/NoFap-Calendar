import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:share/share.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class StatusPage extends StatefulWidget {
  @override
  _StatusPageState createState() => _StatusPageState();
}

class _StatusPageState extends State<StatusPage> {
  Firestore firestore = Firestore.instance;
  int _dday = 1;

  void _showDialog() {
    showDialog<int>(
        context: context,
        builder: (BuildContext context) {
          return NumberPickerDialog.integer(
            minValue: 1,
            maxValue: 100,
            title: Text('ang'),
            initialIntegerValue: _dday,
          );
        }).then((int value) {
      if (value != null) {
        setState(() => _dday = value);
      }
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('현황'),
        actions: [
          IconButton(
            color: Colors.black,
            icon: Icon(Icons.history),
            onPressed: () {
              Navigator.of(context).pushNamed('/history');
            },
          ),
          IconButton(
            color: Colors.black,
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
                percent: 0.7,
                center: Text(
                  "D-4",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 40.0),
                ),
                circularStrokeCap: CircularStrokeCap.round,
                progressColor: Colors.red,
              ),
              RaisedButton(
                color: Colors.blue,
                child: Icon(Icons.warning),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                onPressed: _showDialog,
              ),
              RaisedButton(
                color: Colors.blue,
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
                color: Colors.blue,
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
                color: Colors.blue,
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
                color: Colors.blue,
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
