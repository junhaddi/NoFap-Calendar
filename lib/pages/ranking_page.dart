import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class RankingPage extends StatefulWidget {
  @override
  _RankingPageState createState() => _RankingPageState();
}

class _RankingPageState extends State<RankingPage> {
  RefreshController _refreshController = RefreshController();

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
              title: Text("SliverAppBar"),
              expandedHeight: 200.0,
              pinned: true,
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
