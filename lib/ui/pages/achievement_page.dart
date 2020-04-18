import 'package:flutter/material.dart';
import 'package:nofapcalendar/ui/widgets/custom_app_bar.dart';

class AchievementPage extends StatefulWidget {
  @override
  _AchievementPageState createState() => _AchievementPageState();
}

class _AchievementPageState extends State<AchievementPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'n% 달성',
        actions: [
          IconButton(
            color: Colors.black,
            icon: Icon(Icons.sort),
            onPressed: () {},
          )
        ],
      ),
      body: GridView.count(
        crossAxisCount: 2,
        children: List.generate(100, (index) {
          return Card(
            clipBehavior: Clip.antiAlias,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Image.network(
                    'https://pds.joins.com/news/component/htmlphoto_mmdata/201906/27/htm_20190627161112785240.jpg'),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text('금딸의 신'),
                      SizedBox(height: 8.0),
                      Text('Index $index'),
                    ],
                  ),
                )
              ],
            ),
          );
        }),
      ),
    );
  }
}
