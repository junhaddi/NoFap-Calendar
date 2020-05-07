import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class RankingScreen extends StatefulWidget {
  @override
  _RankingScreenState createState() => _RankingScreenState();
}

class _RankingScreenState extends State<RankingScreen> {
  RefreshController _refreshController = RefreshController();
  String dropdownValue = '전체 기간';
  bool isFriend = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SmartRefresher(
        header: MaterialClassicHeader(
          backgroundColor: Colors.white,
          color: Colors.black,
        ),
        controller: _refreshController,
        onRefresh: _onRefresh,
        child: CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              title: Text("순위"),
              centerTitle: true,
              pinned: true,
              expandedHeight: 240.0,
              elevation: 0.0,
              actions: <Widget>[
                Container(
                  margin: EdgeInsets.only(right: 10.0),
                  child: GestureDetector(
                    onTap: () {
                      // TODO 페이스북 로그인/로그아웃 창 띄우기
                    },
                    child: CircleAvatar(
                      radius: 20.0,
                      child: ClipOval(
                        child: Image.network(
                          'https://pbs.twimg.com/profile_images/885160602603110400/NDy2DF5c_400x400.jpg',
                        ),
                      ),
                    ),
                  ),
                ),
              ],
              flexibleSpace: FlexibleSpaceBar(
                background: SafeArea(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      CircleAvatar(
                        radius: 32.0,
                        backgroundImage: NetworkImage(
                            'https://img.insight.co.kr/static/2018/11/16/700/990ejzhe8h36114p05gn.jpg'),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Text('명예의 전당')
                    ],
                  ),
                ),
              ),
              bottom: PreferredSize(
                preferredSize: const Size.fromHeight(64.0),
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(
                          left: 18.0, right: 18.0, bottom: 10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          DropdownButtonHideUnderline(
                            child: DropdownButton<String>(
                              value: dropdownValue,
                              icon: Icon(Icons.arrow_drop_down),
                              onChanged: (String newValue) {
                                setState(() {
                                  dropdownValue = newValue;
                                });
                              },
                              items: <String>[
                                '오늘',
                                '이번 주',
                                '전체 기간'
                              ].map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                            ),
                          ),
                          Row(
                            children: <Widget>[
                              Text('전체'),
                              Switch(
                                value: isFriend,
                                onChanged: (bool newValue) {
                                  setState(() {
                                    isFriend = newValue;
                                  });
                                },
                              ),
                              Text('친구'),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Container(
                      color: Color.fromRGBO(105, 105, 105, 1.0),
                      height: 0.3,
                    ),
                  ],
                ),
              ),
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  return Column(
                    children: <Widget>[
                      ListTile(
                        leading: Container(
                          width: 64.0,
                          alignment: Alignment.center,
                          child: Icon(
                            Icons.account_circle,
                            size: 48.0,
                          ),
                        ),
                        title: Text(
                          "MA강준하멋쟁이",
                          style: TextStyle(
                            color: Colors.indigoAccent,
                          ),
                        ),
                        subtitle: Text(
                          'MA설명이랑께',
                        ),
                        trailing: Text('${index + 1}등'),
                      ),
                      Divider(
                        thickness: 1.0,
                        indent: 96.0,
                      ),
                    ],
                  );
                },
                childCount: 20,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _onRefresh() async {
    await Future.delayed(Duration(milliseconds: 1000));
    _refreshController.refreshCompleted();
  }
}
