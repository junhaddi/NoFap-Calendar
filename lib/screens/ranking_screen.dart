import 'package:flutter/material.dart';
import 'package:nofapcamp/models/classes.dart';
import 'package:nofapcamp/models/dropdown_item.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:transparent_image/transparent_image.dart';

class RankingScreen extends StatefulWidget {
  @override
  _RankingScreenState createState() => _RankingScreenState();
}

class _RankingScreenState extends State<RankingScreen> {
  SharedPreferences _prefs;
  int _progressDay;
  RefreshController _refreshController = RefreshController();
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
  bool _isGridView = false;

  @override
  void initState() {
    super.initState();
    _getDate();
    // TODO 서버로부터 유저 정보 가져오기
  }

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
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      _progressDay == null
                          ? Text(
                              '시작하세요',
                              style: TextStyle(
                                fontSize: 42.0,
                                fontWeight: FontWeight.bold,
                              ),
                            )
                          : Column(
                              children: <Widget>[
                                FadeInImage(
                                  height: 60.0,
                                  placeholder: MemoryImage(kTransparentImage),
                                  image: getClassesImage(_progressDay),
                                ),
                                SizedBox(
                                  height: 20.0,
                                ),
                                Text(
                                  '상위 69.69%',
                                  style: TextStyle(
                                    fontSize: 24.0,
                                  ),
                                ),
                              ],
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
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                _isGridView = !_isGridView;
                              });
                            },
                            child: Icon(
                              _isGridView
                                  ? Icons.grid_on
                                  : Icons.format_list_numbered,
                            ),
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
            _isGridView
                ? SliverPadding(
                    padding: EdgeInsets.all(8.0),
                    sliver: SliverGrid.count(
                      crossAxisSpacing: 10.0,
                      mainAxisSpacing: 10.0,
                      crossAxisCount: 4,
                      childAspectRatio: 0.8,
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.all(4.0),
                          child: Column(
                            children: <Widget>[
                              Image(
                                height: 40.0,
                                image: getClassesImage(100),
                              ),
                              SizedBox(
                                height: 10.0,
                              ),
                              Text(
                                '강준하',
                              ),
                              SizedBox(
                                height: 4.0,
                              ),
                              Text('69일째'),
                            ],
                          ),
                        ),
                      ],
                    ),
                  )
                : SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        return Column(
                          children: <Widget>[
                            ListTile(
                              leading: Container(
                                width: 40.0,
                                alignment: Alignment.center,
                                child: Image(image: getClassesImage(10)),
                              ),
                              title: Text(
                                '강준하(#1234)',
                              ),
                              subtitle: Text(
                                '4일째',
                              ),
                              trailing: Text(
                                '${index + 1}위',
                                style: TextStyle(
                                  color: Colors.grey,
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

  Future<void> _getDate() async {
    _prefs = await SharedPreferences.getInstance();
    setState(() {
      _progressDay = _prefs.getInt('progressDay') ?? null;
    });
  }

  Future<void> _onRefresh() async {
    await Future.delayed(Duration(milliseconds: 300));
    _refreshController.refreshCompleted();
  }
}
