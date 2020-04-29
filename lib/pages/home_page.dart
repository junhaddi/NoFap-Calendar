import 'package:flutter/material.dart';
import 'package:share/share.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Expanded(
            child: Row(
              children: <Widget>[
                Expanded(
                  child: CardItem(
                      title: '칭호',
                      icon: Icons.cake,
                      event: () {
                        Navigator.of(context).pushNamed('/nickname');
                      }),
                ),
                Expanded(
                  child: CardItem(
                      title: '명언',
                      icon: Icons.textsms,
                      event: () {
                        Navigator.of(context).pushNamed('/wisesaying');
                      }),
                ),
              ],
            ),
          ),
          Expanded(
            child: CardItem(
                title: '도전기록',
                icon: Icons.history,
                isSingle: true,
                event: () {
                  Navigator.of(context).pushNamed('/history');
                }),
          ),
          Expanded(
            child: CardItem(
                title: '금딸효능',
                icon: Icons.healing,
                isSingle: true,
                event: () {
                  Navigator.of(context).pushNamed('/efficacy');
                }),
          ),
          Expanded(
            child: Row(
              children: <Widget>[
                Expanded(
                  child: CardItem(
                      title: '더보기',
                      icon: Icons.favorite,
                      event: () {
                        Navigator.of(context).pushNamed('/viewmore');
                      }),
                ),
                Expanded(
                  child: CardItem(
                      title: '공유',
                      icon: Icons.share,
                      event: () {
                        final RenderBox box = context.findRenderObject();
                        String text = "스토어링크";
                        Share.share(text,
                            sharePositionOrigin:
                                box.localToGlobal(Offset.zero) & box.size);
                      }),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 30.0,
          ),
        ],
      ),
    );
  }
}

class CardItem extends StatelessWidget {
  final String title;
  final IconData icon;
  final bool isSingle;
  final event;

  CardItem({
    this.title = "hello",
    this.icon = Icons.home,
    this.isSingle = false,
    this.event,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: event,
      child: Container(
        margin: EdgeInsets.all(4.0),
        width: MediaQuery.of(context).size.width,
        child: Card(
          elevation: 0.0,
          child: isSingle
              ? Stack(
                  children: <Widget>[
                    Positioned.fill(
                      left: 16.0,
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Icon(icon, size: 36.0, color: Colors.redAccent),
                      ),
                    ),
                    Positioned.fill(
                      right: 16.0,
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: Icon(Icons.arrow_forward_ios, size: 36.0),
                      ),
                    ),
                    Center(
                      child: Text(title, style: TextStyle(fontSize: 24.0)),
                    ),
                  ],
                )
              : Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(icon, size: 36.0, color: Colors.redAccent),
                    SizedBox(height: 8.0),
                    Text(
                      title,
                      style: TextStyle(fontSize: 24.0),
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}
