import 'package:flutter/material.dart';

class RankingPage extends StatefulWidget {
  @override
  _RankingPageState createState() => _RankingPageState();
}

class _RankingPageState extends State<RankingPage> {
  // int _radioValue = 0;

  // void _handleRadioValueChange(int value) {
  //   setState(() {
  //     _radioValue = value;
  //     switch (_radioValue) {
  //       case 0:
  //         break;
  //       case 1:
  //         break;
  //       case 2:
  //         break;
  //     }
  //   });
  // }

  var _tabBar = <Tab> [
    Tab(text: '현재 시즌'),
    Tab(text: '시즌 최고 기록')
  ];

  int _tabBarIndex = 0;

  // 얼마나 참았는지
  _containerListView() {
    return Container(
      // 크기 지정
      width: 500,
      height: 415,
      margin: EdgeInsets.fromLTRB(15, 0, 15, 0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        border: Border.all(
          color: Colors.yellow,
          width: 6
        ),
        color: Color.fromRGBO(255, 245, 175, 100),
      ),
      padding: EdgeInsets.all(5),
      child: ListView.builder(
        itemBuilder: (context, index) => ListTile(
          leading: Container(
            width: 20,
            height: 20,
            child: Placeholder(),
          ),
          title: Text('name'),
        )
      )
    );
  }

  _theFirst() {
    double height = 50;
    double width = 40;

    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Container(
          height: height,
          width: width,
          margin: EdgeInsets.only(left: 25),
          child: Center(
            child: Text('1등', style: TextStyle(fontSize: 25)),
          ),
        ),
        SizedBox(
          width: 15,
        ),
        Container(
          width: 1,
          height: height / 2,
          color: Colors.black12,
        ),
        SizedBox(
          width: 15,
        ),
        Padding(
          padding: EdgeInsets.all(20),
          // 막 넣었음
          child: Icon(Icons.airline_seat_flat_angled),
        ),
        SizedBox(
          width: 15,
        ),
        Container(
          width: 1,
          height: height / 2,
          color: Colors.black12,
        ),
        Container(
          height: height,
          width: 200,
          margin: EdgeInsets.only(left: 10),
          child: Center(
            child: Text('123123123123', style: TextStyle(fontSize: 25)),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text('순위'),
          actions: [
            IconButton(
              icon: Icon(Icons.sort),
              onPressed: () {},
            )
          ],
          bottom: TabBar(
            onTap: (i) {
              setState(() {
                _tabBarIndex = i;
              });
            },
            tabs: _tabBar
          )
        ),
        // 현재 시즌, 시즌 최고 기록
        body: Column(
          children: <Widget>[
            _theFirst(),
            _containerListView()
          ],
        )
      )
    );
  }
}
