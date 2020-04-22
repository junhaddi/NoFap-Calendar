import 'package:flutter/material.dart';
import 'package:flutter_native_admob/flutter_native_admob.dart';
import 'package:flutter_native_admob/native_admob_controller.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class HomePageItem {
  String title;
  String description;
  String imageURL;
  String youtubeURL;

  HomePageItem({this.title, this.description, this.imageURL, this.youtubeURL});
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

  // 광고창
  _googleAd() {
    return Column(
      children: <Widget>[
        Container(
          height: 230,
          // height: 300,
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
        Container(
          width: double.infinity,
          height: 230,
          // height: 300,
          child: Card(
            child: Column(
              children: <Widget>[
                Image.network('https://ojsfile.ohmynews.com/STD_IMG_FILE/2012/0604/IE001447169_STD.jpg'),
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
      ],
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
          expandedHeight: 400.0,
          flexibleSpace: FlexibleSpaceBar(
            background: Image.network(
              'https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcTfHFexcrsT2rKcRuJuQkrkjJXKy-bZcRMg2BbY_CX6opF3nswi&usqp=CAU',
              fit: BoxFit.cover,
            ),
          ),
        ),
        SliverList(delegate: SliverChildBuilderDelegate(
          (context, index) {
            return _googleAd();
          },
        ))
      ],
    ));
  }
}
