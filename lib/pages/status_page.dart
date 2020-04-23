import 'package:flutter/material.dart';
import 'package:nofapcamp/widgets/custom_app_bar.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:share/share.dart';

class StatusPage extends StatefulWidget {
  @override
  _StatusPageState createState() => _StatusPageState();
}

class _StatusPageState extends State<StatusPage> {
  int _dday = 1;

  void _showDialog() {
    showDialog<int>(
        context: context,
        builder: (BuildContext context) {
          return NumberPickerDialog.integer(
            minValue: 1,
            maxValue: 100,
            title: Text('ang'),
            initialIntegerValue: _dday,
          );
        }).then((int value) {
      if (value != null) {
        setState(() => _dday = value);
      }
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: '현황',
        actions: [
          IconButton(
            color: Colors.black,
            icon: Icon(Icons.history),
            onPressed: () {
              Navigator.of(context).pushNamed('/history');
            },
          ),
          IconButton(
            color: Colors.black,
            icon: Icon(Icons.share),
            onPressed: () {
              RenderBox box = context.findRenderObject();
              String text = "anggimoddi";
              Share.share(text,
                  subject: text,
                  sharePositionOrigin:
                      box.localToGlobal(Offset.zero) & box.size);
            },
          ),
        ],
      ),
      body: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              CircularPercentIndicator(
                radius: 240.0,
                lineWidth: 26.0,
                animation: true,
                percent: 0.7,
                center: Text(
                  "D-4",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 40.0),
                ),
                circularStrokeCap: CircularStrokeCap.round,
                progressColor: Colors.red,
              ),
              RaisedButton(
                color: Colors.blue,
                child: Icon(Icons.warning),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                onPressed: _showDialog,
              )
            ],
          ),
        ),
      ),
    );
  }
}
