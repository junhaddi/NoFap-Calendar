import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:nofapcamp/models/walkthrough.dart';

class WalkthroughScreen extends StatefulWidget {
  final SharedPreferences prefs;
  final List<Walkthrough> pages = [
    Walkthrough(
      icon: Icons.warning,
      title: '딸치면 때립니다!',
      description: '조심하십쇼.',
    ),
    Walkthrough(
      icon: Icons.warning,
      title: '이제부터 딸치면 때립니다!!',
      description: '진심입니다.',
    ),
    Walkthrough(
      icon: Icons.warning,
      title: '정말로 떄립니다!!!',
      description: '각오는 되셨겠죠.',
    ),
  ];

  WalkthroughScreen({this.prefs});

  @override
  _WalkthroughScreenState createState() => _WalkthroughScreenState();
}

class _WalkthroughScreenState extends State<WalkthroughScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Swiper.children(
        autoplay: false,
        index: 0,
        loop: false,
        pagination: SwiperPagination(
          margin: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 40.0),
          builder: DotSwiperPaginationBuilder(
            color: Colors.white30,
            activeColor: Colors.white,
            size: 6.5,
            activeSize: 8.0,
          ),
        ),
        control: SwiperControl(
          iconPrevious: null,
          iconNext: null,
        ),
        children: _getPages(context),
      ),
    );
  }

  List<Widget> _getPages(BuildContext context) {
    List<Widget> widgets = [];
    for (int i = 0; i < widget.pages.length; i++) {
      Walkthrough page = widget.pages[i];
      widgets.add(
        Container(
          color: Colors.red,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  page.icon,
                  size: 120.0,
                  color: Colors.white,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 50.0),
                  child: Text(
                    page.title,
                    softWrap: true,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      decoration: TextDecoration.none,
                      fontSize: 24.0,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Text(
                    page.description,
                    softWrap: true,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15.0,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }
    widgets.add(
      Container(
        color: Colors.amber,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(
                Icons.code,
                size: 120.0,
                color: Colors.white,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 50.0),
                child: Text(
                  '금딸캠프에 오신것을 환영합니다.',
                  softWrap: true,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24.0,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: RaisedButton(
                  child: Text('시작하기'),
                  onPressed: () {
                    widget.prefs.setBool('walkthroughSeen', true);
                    Navigator.of(context).pushReplacementNamed('/index');
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
    return widgets;
  }
}
