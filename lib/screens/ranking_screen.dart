import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class RankingScreen extends StatefulWidget {
  @override
  _RankingScreenState createState() => _RankingScreenState();
}

class _RankingScreenState extends State<RankingScreen> {
  RefreshController _refreshController = RefreshController();
  String dropdownValue = 'One';
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
              expandedHeight: 200.0,
              bottom: PreferredSize(
                preferredSize: const Size.fromHeight(48.0),
                child: Row(
                  children: <Widget>[
                    DropdownButton<String>(
                      value: dropdownValue,
                      icon: Icon(Icons.arrow_downward),
                      iconSize: 24,
                      elevation: 16,
                      style: TextStyle(color: Colors.deepPurple),
                      underline: Container(
                        height: 2,
                        color: Colors.deepPurpleAccent,
                      ),
                      onChanged: (String newValue) {
                        setState(() {
                          dropdownValue = newValue;
                        });
                      },
                      items: <String>['One', 'Two', 'Free', 'Four']
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                    Switch(
                      value: isFriend,
                    ),
                  ],
                ),
              ),
              pinned: true,
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
//              flexibleSpace: FlexibleSpaceBar(
//                background: Column(
//                  mainAxisAlignment: MainAxisAlignment.center,
//                  children: <Widget>[
//                    Text('anggimoddi'),
//                  ],
//                ),
//                title: Column(
//                  children: <Widget>[
//                    Text('ang'),
//                    Switch(
//                      value: true,
//                    )
//                  ],
//                ),
//                centerTitle: true,
//              ),
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  return ListTile(
                    title: Text(
                      "Item $index",
                      style: TextStyle(
                        color: Colors.indigoAccent,
                      ),
                    ),
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
