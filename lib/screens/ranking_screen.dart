import 'package:flutter/material.dart';
import 'package:nofapcamp/models/dropdown_item.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class RankingScreen extends StatefulWidget {
  @override
  _RankingScreenState createState() => _RankingScreenState();
}

class _RankingScreenState extends State<RankingScreen> {
  RefreshController _refreshController = RefreshController();
  TextEditingController _textEditingController = TextEditingController();
  static List<DropdownItem> _dropdownItems = [
    DropdownItem(
      name: '전체',
      image: null,
    ),
    DropdownItem(
      name: '병사',
      image: AssetImage('assets/images/classes/classes_1.jpg'),
    ),
    DropdownItem(
      name: '부사관',
      image: AssetImage('assets/images/classes/classes_5.png'),
    ),
    DropdownItem(
      name: '준사관',
      image: AssetImage('assets/images/classes/classes_9.png'),
    ),
    DropdownItem(
      name: '위관장교',
      image: AssetImage('assets/images/classes/classes_10.png'),
    ),
    DropdownItem(
      name: '영관장교',
      image: AssetImage('assets/images/classes/classes_13.png'),
    ),
    DropdownItem(
      name: '장군',
      image: AssetImage('assets/images/classes/classes_16.png'),
    ),
  ];
  DropdownItem _dropdownValue = _dropdownItems[0];
  bool _isSwitchFriend = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SmartRefresher(
        header: MaterialClassicHeader(
          color: Colors.black,
        ),
        controller: _refreshController,
        onRefresh: _onRefresh,
        child: CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              expandedHeight: 240.0,
              automaticallyImplyLeading: false,
              centerTitle: true,
              pinned: true,
              elevation: 0.0,
              title: Text('순위'),
              leading: IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              flexibleSpace: FlexibleSpaceBar(
                background: SafeArea(
                  child: _isSwitchFriend
                      ? Column(
                          // 페이스북
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            CircleAvatar(
                              radius: 32.0,
                              backgroundImage: NetworkImage(
                                  'https://www.bizmoa.co.kr/data/file/sub1_02/thumb-1795154778_vcyhiXz6_517857878d888ea41d4a4e261f83a01ae306ebb4_600x563.png'),
                            ),
                            SizedBox(
                              height: 10.0,
                            ),
                            Text(
                              '페이스북이름',
                              style: TextStyle(fontSize: 18.0),
                            ),
                          ],
                        )
                      : Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              '개발자가 여기를 꾸미려다가 실패한듯 하다',
                              style: TextStyle(fontStyle: FontStyle.italic),
                            ),
                          ],
                        ),
                ),
              ),
              bottom: PreferredSize(
                preferredSize: const Size.fromHeight(60.0),
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(
                        left: 18.0,
                        right: 18.0,
                        bottom: 10.0,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          DropdownButtonHideUnderline(
                            child: DropdownButton<DropdownItem>(
                              value: _dropdownValue,
                              icon: Icon(Icons.arrow_drop_down),
                              onChanged: (DropdownItem value) {
                                setState(() {
                                  _dropdownValue = value;
                                });
                              },
                              items: _dropdownItems.map((DropdownItem item) {
                                return DropdownMenuItem<DropdownItem>(
                                  value: item,
                                  child: item.image == null
                                      ? Row(
                                          children: <Widget>[
                                            Icon(Icons.done_all),
                                            SizedBox(
                                              width: 10.0,
                                            ),
                                            Text(
                                              item.name,
                                            ),
                                          ],
                                        )
                                      : Row(
                                          children: <Widget>[
                                            Image(
                                              width: 20.0,
                                              image: item.image,
                                            ),
                                            SizedBox(
                                              width: 10.0,
                                            ),
                                            Text(
                                              item.name,
                                            ),
                                          ],
                                        ),
                                );
                              }).toList(),
                            ),
                          ),
                          Row(
                            children: <Widget>[
                              Text('전체'),
                              Switch(
                                value: _isSwitchFriend,
                                onChanged: (bool newValue) {
                                  setState(() {
                                    _isSwitchFriend = newValue;
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
                        leading: Icon(
                          Icons.account_circle,
                          size: 48.0,
                        ),
                        title: Text(
                          '#${index + 1} 강준하',
                        ),
                        subtitle: Text(
                          '4일째 (상위 69.69%)',
                        ),
                        trailing: Image(
                          width: 40.0,
                          image: AssetImage(
                            'assets/images/classes/classes_9.png',
                          ),
                        ),
                      ),
                      Divider(),
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
    await Future.delayed(Duration(milliseconds: 300));
    _refreshController.refreshCompleted();
  }
}
