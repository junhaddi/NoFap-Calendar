import 'package:flutter/material.dart';

class CustomDialog extends StatelessWidget {
  final String title;
  final String content;
  final String image;
  final event;

  const CustomDialog({
    this.title = '제목',
    this.content = '내용',
    this.image =
        'https://image.fmkorea.com/files/attach/new/20190723/2895716/51565484/2017469519/0700c9f95979a6383445ef1901a15fdc.jpg',
    this.event,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      contentPadding: EdgeInsets.zero,
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.circular(20.0),
            child: Image.network(
              image,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(
            height: 16.0,
          ),
          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 28.0),
          ),
          SizedBox(
            height: 16.0,
          ),
          Text(
            content,
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: 24.0,
          ),
          ButtonBar(
            alignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              SizedBox(
                width: 80.0,
                height: 40.0,
                child: RaisedButton(
                  child: Text('취소'),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ),
              SizedBox(
                width: 80.0,
                height: 40.0,
                child: RaisedButton(
                  color: Colors.green,
                  child: Text('확인'),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  onPressed: event,
                ),
              ),
            ],
          ),
          SizedBox(
            height: 16.0,
          ),
        ],
      ),
    );
  }
}
