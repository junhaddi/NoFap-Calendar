import 'package:flutter/material.dart';

// 홈 페이지 화면
class HomePage extends StatelessWidget {
  // 카드 아래 있는 "조아요, 댓글, 공유" 바
  _cardBottom() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        Row(
          children: <Widget>[
            Icon(Icons.thumb_up, color: Colors.grey),
            SizedBox(width: 8),
            Text(
              '쪼아요',
              style: TextStyle(color: Colors.grey),
            ),
          ],
        ),
        Row(
          children: <Widget>[
            Icon(Icons.comment, color: Colors.grey),
            SizedBox(width: 8),
            Text(
              '댓글',
              style: TextStyle(color: Colors.grey),
            ),
          ],
        ),
        Row(
          children: <Widget>[
            Icon(Icons.share, color: Colors.grey),
            SizedBox(width: 8),
            Text(
              '공유',
              style: TextStyle(color: Colors.grey),
            ),
          ],
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      // 추가하는 카드 수를 지정
      // itemCount: ,
      itemBuilder: (context, index) {
        return Card(
          margin: EdgeInsets.all(5),
          elevation: 5,
          child: Container(
            height: 350,
            color: Colors.white,
            child: Column(
              children: <Widget>[
                ListTile(
                  leading: CircleAvatar(),
                  title: Text('제목이랑께'),
                  subtitle: Text('2020.04.14'),
                ),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(
                            'https://pds.joins.com/news/component/htmlphoto_mmdata/201906/27/htm_20190627161112785240.jpg'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 14),
                _cardBottom(),
                SizedBox(
                  height: 12,
                )
              ],
            ),
          ),
        );
      }
    );
  }
}
