import 'package:flutter/material.dart';
import 'package:nofapcalendar/ui/pages/home_page.dart';
import 'package:nofapcalendar/ui/pages/calendar_page.dart';
import 'package:nofapcalendar/ui/pages/achievement_page.dart';
import 'package:nofapcalendar/ui/pages/setting_page.dart';

class IndexScreen extends StatefulWidget {
  @override
  _IndexScreenState createState() => _IndexScreenState();
}

class _IndexScreenState extends State<IndexScreen> {
  int _page = 0;
  PageController _c;

  var _everyPage = <Widget>[
    HomePage(),
    CalendarPage(),
    AchievementPage(),
    SettingPage()
  ];

  var _bottomItem = <BottomNavigationBarItem>[
    BottomNavigationBarItem(
      icon: Icon(Icons.home),
      title: Text('홈'),
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.calendar_today),
      title: Text('캘린더'),
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.cake),
      title: Text('업적'),
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.settings),
      title: Text('설정'),
    ),
  ];

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () => _showDailyDialog(context));
    _c = PageController(
      initialPage: _page,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _c,
        onPageChanged: (newPage) {
          setState(() {
            this._page = newPage;
          });
        },
        children: _everyPage,
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _page,
        onTap: (index) {
          this._c.animateToPage(index,
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut);
        },
        items: _bottomItem,
      ),
    );
  }

  void _showDailyDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
          title: Text('금딸 성공'),
          content: Text('하셨습니까???????'),
          actions: <Widget>[
            FlatButton(
              child: Text('오늘은 잘 참았다'),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            FlatButton(
              child: Text('실패하였습니다..'),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }
}
