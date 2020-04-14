import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:table_calendar/table_calendar.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '금딸캘린더',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _page = 0;
  PageController _c;
  CalendarController _calendar;

  @override
  void initState() {
    _c = PageController(
      initialPage: _page,
    );
    _calendar = CalendarController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('금딸캘린더'),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: Text('Drawer Header'),
              decoration: BoxDecoration(color: Colors.blue),
            ),
            ListTile(
              title: Text('Item 1'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Text('Item 2'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _page,
        onTap: (index) {
          this._c.animateToPage(index,
              duration: const Duration(milliseconds: 500),
              curve: Curves.easeInOut);
        },
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: Icon(Icons.home), title: Text("홈")),
          BottomNavigationBarItem(
              icon: Icon(Icons.calendar_today), title: Text("캘린더")),
          BottomNavigationBarItem(
              icon: Icon(Icons.settings), title: Text("설정")),
        ],
      ),
      body: PageView(
        physics: NeverScrollableScrollPhysics(),
        controller: _c,
        onPageChanged: (newPage) {
          setState(() {
            this._page = newPage;
          });
        },
        children: <Widget>[
          Center(
            // 홈
            child: Column(
              children: <Widget>[
                TableCalendar(calendarController: _calendar),
              ],
            ),
          ),
          Center(
            // 캘린더
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[Icon(Icons.calendar_today), Text("캘린더")],
            ),
          ),
          Center(
            // 설정
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[Icon(Icons.settings), Text("설정")],
            ),
          ),
        ],
      ),
    );
  }
}
