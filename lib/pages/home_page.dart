import 'package:flutter/material.dart';
import 'package:nofapcamp/custom_icons_icons.dart';
import 'package:nofapcamp/widgets/card_item.dart';
import 'package:share/share.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Expanded(
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: CardItem(
                      title: '계급',
                      icon: Icons.star,
                      onTap: () {
                        Navigator.of(context).pushNamed('/classes');
                      },
                    ),
                  ),
                  Expanded(
                    child: CardItem(
                      title: '게시판',
                      icon: Icons.rate_review,
                      onTap: () {
                        Navigator.of(context).pushNamed('/board');
                      },
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: CardItem(
                title: '도전기록',
                icon: Icons.event,
                isSingle: true,
                onTap: () {
                  Navigator.of(context).pushNamed('/history');
                },
              ),
            ),
            Expanded(
              child: CardItem(
                title: '순위',
                icon: Icons.public,
                isSingle: true,
                onTap: () {
                  Navigator.of(context).pushNamed('/ranking');
                },
              ),
            ),
            Expanded(
              child: CardItem(
                title: '더보기',
                icon: Icons.more_horiz,
                isSingle: true,
                onTap: () {
                  Navigator.of(context).pushNamed('/viewmore');
                },
              ),
            ),
            Expanded(
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: CardItem(
                      title: '후원',
                      icon: Icons.favorite,
                      onTap: () {
                        // TODO 인앱 구매
                      },
                    ),
                  ),
                  Expanded(
                    child: CardItem(
                      title: '공유',
                      icon: CustomIcons.share,
                      onTap: () {
                        final RenderBox box = context.findRenderObject();
                        String text = '플레이스토어, 앱스토어 링크';
                        Share.share(text,
                            sharePositionOrigin:
                                box.localToGlobal(Offset.zero) & box.size);
                      },
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 60.0,
            ),
          ],
        ),
      ),
    );
  }
}
