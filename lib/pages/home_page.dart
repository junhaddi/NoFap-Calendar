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

  HomePageItem(
      {this.title,
      this.description,
      this.imageURL,
      this.youtubeURL,
      this.wiseSaying});
}

// 1) 업적 정렬 버튼 누르면 업적들 정렬 시키기(움직이는 애니메이션 까지 추가)
// 2) 다크모드 추가(외부 모듈 그 때 그거 사용해서 구현하기)
class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
              color: Theme.of(context).primaryColor,
              width: 3)),
      child: CircleAvatar(
        backgroundImage: AssetImage('assets/ic_launcher.png'),
      ),
    );
  }

  // 페이지 아이템
  final List<HomePageItem> pages = [
    HomePageItem(
      title: '이미지는 없다 개샠키야',
      description: '유튜브도 없다 이자식아',
    ),
    HomePageItem(
      title: '이미지는 없다 개샠키야',
      description: '유튜브도 없다 이자식아',
    ),
    HomePageItem(
      title: '이미지는 없다 개샠키야',
      description: '유튜브도 없다 이자식아',
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
          expandedHeight: 400.0,
          leading: _appBarLogo(),
          flexibleSpace: FlexibleSpaceBar(
            title: Text('금딸캘린더'),
            centerTitle: true,
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
    ));
  }
}