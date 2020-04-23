import 'package:flutter/material.dart';
import 'package:flutter_native_admob/flutter_native_admob.dart';
import 'package:flutter_native_admob/native_admob_controller.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class HomePageItem {
  String title;
  String description;
  String imageURL;
  String youtubeURL;
  String wiseSaying;

  HomePageItem({
    this.title,
    this.description,
    this.imageURL,
    this.youtubeURL,
    this.wiseSaying,
  });
}

class HomePage extends StatelessWidget {
  static const _adUnitID = 'ca-app-pub-8336339515298040/6724604841';
  final _nativeAdController = NativeAdmobController();

  // 로고 그냥 추가 해봤음
  // 맘에 안들면 삭제
  _appBarLogo() {
    return Container(
      margin: EdgeInsets.all(5),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          border: Border.all(
              // 테두리 색갈 생각
              color: Colors.blue,
              width: 3)),
      child: CircleAvatar(
        backgroundImage: AssetImage('assets/ic_launcher.png'),
      ),
    );
  }

  // 페이지 아이템
  final List<HomePageItem> pages = [
    HomePageItem(
      title: '아앙기모띠',
      description: '요고슨 설명입니다요 레후',
    ),
    HomePageItem(
      title: '섹시 준하',
      description:
          '설명설명 하하하 쓸말이 없구나 이런..... 설명설명 하하하 쓸말이 없구나 이런..... 설명설명 하하하 쓸말이 없구나 이런..... 설명설명 하하하 쓸말이 없구나 이런.....',
    ),
    HomePageItem(
      title: '요거스은 더미 데이터 입니다요 하하하',
      description: '데이터베이스에서 읽어오는 기능도 만들어볼까??',
    ),
  ];

  Column listItem() {
    List<Widget> widgets = [];
    for (int i = 0; i < pages.length; i++) {
      HomePageItem page = pages[i];
      widgets.add(
        Container(
          height: 300,
          child: Card(
            margin: EdgeInsets.all(5),
            elevation: 5,
            child: NativeAdmob(
              adUnitID: _adUnitID,
              controller: _nativeAdController,
              type: NativeAdmobType.full,
            ),
          ),
        ),
      );
      widgets.add(
        Container(
          height: 230,
          width: double.infinity,
          // height: 300,
          child: Card(
            margin: EdgeInsets.all(5),
            elevation: 5,
            child: Column(
              children: <Widget>[
                Text(page.title),
                Text(page.description),
              ],
            ),
          ),
        ),
      );
      widgets.add(
        Container(
          width: double.infinity,
          child: Card(
            margin: EdgeInsets.all(5),
            elevation: 5,
            child: Column(
              children: <Widget>[
                Text(page.title),
                Text(page.description),
                YoutubePlayer(
                  controller: YoutubePlayerController(
                      initialVideoId: 'xdvYOkE8r3A',
                      flags: YoutubePlayerFlags(
                        autoPlay: true,
                        mute: true,
                      )),
                  showVideoProgressIndicator: true,
                  progressColors: ProgressBarColors(
                    playedColor: Colors.amber,
                    handleColor: Colors.amberAccent,
                  ),
                  onReady: () {},
                ),
              ],
            ),
          ),
        ),
      );
    }
    return Column(
      children: widgets,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            floating: false,
            pinned: true,
            leading: _appBarLogo(),
            title: Text('금딸캘린더'),
            expandedHeight: 300.0,
            flexibleSpace: FlexibleSpaceBar(
              background: Image.network(
                'https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcTfHFexcrsT2rKcRuJuQkrkjJXKy-bZcRMg2BbY_CX6opF3nswi&usqp=CAU',
                fit: BoxFit.cover,
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                return listItem();
              },
            ),
          ),
        ],
      ),
    );
  }
}
