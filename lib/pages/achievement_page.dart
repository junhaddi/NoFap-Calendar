import 'package:flutter/material.dart';

import 'ArticleDescriptionClass/custom_listItem_two.dart';

/// This is the stateless widget that the main application instantiates.
class AchievementPage extends StatelessWidget {
  AchievementPage({Key key}) : super(key: key);

  final double _rounded = 50.0;

  // 임시 이미지가 있는 카드
  _hasImageCard() {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(_rounded)
      ),
      child: Padding(
        padding: EdgeInsets.only(left: 10.0),
        child: CustomListItemTwo(
          thumbnail: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(_rounded),
              image: DecorationImage(
                // colorFilter: ColorFilter.,
                image: NetworkImage(
                    'https://img.hankyung.com/photo/201905/01.19755570.1.jpg'),
                fit: BoxFit.cover,
              ),
            ),
            alignment: Alignment.center,
            child: Text(
              '100%',
              style: TextStyle(fontSize: 32.0, color: Colors.red),
            ),
          ),
          title: 'Flutter 1.0 Launch',
          subtitle: 'Flutter continues to improve and expand its horizons.'
              'This text should max out at two lines and clip',
          author: 'Dash',
          publishDate: 'Dec 28',
          readDuration: '5 mins',
        ),
      )
    );
  }

  // 임시 이미지가 없는 카드
  _nonImageCard() {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(_rounded)
      ),
      elevation: 5,
      child: CustomListItemTwo(
        thumbnail: Placeholder(),         // 이미지를 넣을 때 다른 느낌이 난다.
        title: 'Flutter 1.2 Release - Continual updates to the framework',
        subtitle: 'Flutter once again improves and makes updates.',
        author: 'Flutter',
        publishDate: 'Feb 26',
        readDuration: '12 mins',
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('업적'),
        actions: [
          IconButton(
            icon: Icon(Icons.sort),
            onPressed: () {},
          )
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(10.0),
        children: <Widget>[
          _hasImageCard(),
          _nonImageCard(),
          _nonImageCard(),
          _nonImageCard(),
        ],
      ),
    );
  }
}
