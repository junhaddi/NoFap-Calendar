import 'package:flutter/material.dart';
import 'package:flutter_native_admob/native_admob_controller.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

// 1. (업적 칭호), 기록
// 2. 효능    장단점
// 3. 추천사이트, 공유
class _HomePageState extends State<HomePage> {
  static const _adUnitID = 'ca-app-pub-8336339515298040/6724604841';
  final _nativeAdController = NativeAdmobController();

  final double _elevation = 5;

  final _widgetMargin = EdgeInsets.fromLTRB(10, 2.5, 9, 2.5);

  _rowCard(IconData icon, String text) {
    const double cardHeight = 120;     // 너비
    const double cardWidht = 190;     // 높이

    return InkWell(
      onTap: () {
        print('rowCard');
      },
      child: Container(
        height: cardHeight,
        width: cardWidht,
        margin: EdgeInsets.only(right: 5.0),
        child: Card(
          elevation: _elevation,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(icon, size: 33, color: Colors.red),
              SizedBox(height: 15),
              Text('$text', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold))
            ],
          ),
        ),
      ),
    );
  }

  _firstRow() {
    return Container(
      margin: _widgetMargin,
      child: Row(
        children: <Widget>[
          _rowCard(Icons.contacts, 'E-card'),
          _rowCard(Icons.graphic_eq, 'Results'),
        ],
      ),
    );
  }

  _lastRow() {
    return Container(
      margin: _widgetMargin,
      child: Row(
        children: <Widget>[
          _rowCard(Icons.book, 'E-Book'),
          _rowCard(Icons.video_library, 'Video'),
        ],
      ),
    );
  }

  _columnCard(IconData icon, String text) {
    const double cardHeight = 110;     // 너비
    const double cardWidth = 390;

    return Container(
      width: cardWidth,
      height: cardHeight,
      margin: EdgeInsets.fromLTRB(0, 3, 5, 3),
      child: Card(
        elevation: _elevation,
        child: ListTile(
          leading: Padding(
            padding: EdgeInsets.fromLTRB(15, 20, 0, 0),
            child: Icon(icon, color: Colors.red, size: 33),
          ),
          title: Center(
            child: Text('$text', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          ),
          trailing: Padding(
            padding: EdgeInsets.fromLTRB(5, 12, 0, 0),
            child: Icon(Icons.chevron_right, size: 50),
          ),
          onTap: () {
            // 실행 함수
            print('ColumnCard');
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          _firstRow(),
          _columnCard(Icons.calendar_today, 'Announcements'),
          _columnCard(Icons.work, 'Assignments'),
          _columnCard(Icons.hotel, 'Holidays'),
          // _lastRow()
        ],
      )
    );
  }
}