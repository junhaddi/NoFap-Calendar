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
      debugShowCheckedModeBanner: false,
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
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _page,
        onTap: (index) {
          this._c.animateToPage(index,
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut);
        },
        items: <BottomNavigationBarItem>[
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
        ],
      ),
      body: PageView(
        controller: _c,
        onPageChanged: (newPage) {
          setState(() {
            this._page = newPage;
          });
        },
        children: <Widget>[
          Center(
            // 홈
            child: ListView.builder(
              itemCount: 3,
              itemBuilder: (context, index) => CardItem(),
            ),
          ),
          Center(
            // 캘린더
            child: Column(
              children: <Widget>[
                TableCalendar(
                  headerStyle: HeaderStyle(
                    centerHeaderTitle: true,
                    formatButtonVisible: false,
                  ),
                  builders: CalendarBuilders(
                    selectedDayBuilder: (context, date, events) => Container(
                      margin: EdgeInsets.all(4),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage(
                              'https://upload.wikimedia.org/wikipedia/commons/thumb/4/48/Dark_Red_x.svg/600px-Dark_Red_x.svg.png'),
                        ),
                      ),
                      child: Text(
                        date.day.toString(),
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    todayDayBuilder: (context, date, events) => Container(
                      margin: EdgeInsets.all(4),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        date.day.toString(),
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                  calendarController: _calendar,
                ),
              ],
            ),
          ),
          Center(
            // 업적
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(Icons.cake),
                Text('업적'),
              ],
            ),
          ),
          Center(
            // 설정
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  AppBar(
                    title: Text('설정'),
                  ),
                  CheckboxListTile(
                    value: true,
                    title: Text('체크박스'),
                    onChanged: (value) {},
                  ),
                  SwitchListTile(
                    value: false,
                    title: Text('스위치박스'),
                    onChanged: (value) {},
                  ),
                  ListTile(
                    title: Text('리스트'),
                    subtitle: Text('부제목'),
                  ),
                  CheckboxListTile(
                    value: true,
                    title: Text('체크박스'),
                    onChanged: (value) {},
                  ),
                  SwitchListTile(
                    value: false,
                    title: Text('스위치박스'),
                    onChanged: (value) {},
                  ),
                  ListTile(
                    title: Text('리스트'),
                    subtitle: Text('부제목'),
                  ),
                  CheckboxListTile(
                    value: true,
                    title: Text('체크박스'),
                    onChanged: (value) {},
                  ),
                  SwitchListTile(
                    value: false,
                    title: Text('스위치박스'),
                    onChanged: (value) {},
                  ),
                  ListTile(
                    title: Text('리스트'),
                    subtitle: Text('부제목'),
                  ),
                  CheckboxListTile(
                    value: true,
                    title: Text('체크박스'),
                    onChanged: (value) {},
                  ),
                  SwitchListTile(
                    value: false,
                    title: Text('스위치박스'),
                    onChanged: (value) {},
                  ),
                  ListTile(
                    title: Text('리스트'),
                    subtitle: Text('부제목'),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CardItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        height: 350,
        color: Colors.white,
        child: Column(
          children: <Widget>[
            ListTile(
              leading: CircleAvatar(),
              title: Text('제목이랑께'),
              subtitle: Text('2020.04.14'),
            ),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(
                        'https://pds.joins.com/news/component/htmlphoto_mmdata/201906/27/htm_20190627161112785240.jpg'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            SizedBox(height: 14),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Icon(Icons.thumb_up, color: Colors.grey),
                    SizedBox(width: 8),
                    Text(
                      '쪼아요',
                      style: TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
                Row(
                  children: <Widget>[
                    Icon(Icons.comment, color: Colors.grey),
                    SizedBox(width: 8),
                    Text(
                      '댓글',
                      style: TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
                Row(
                  children: <Widget>[
                    Icon(Icons.share, color: Colors.grey),
                    SizedBox(width: 8),
                    Text(
                      '공유',
                      style: TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(
              height: 12,
            )
          ],
        ),
      ),
    );
  }
}
