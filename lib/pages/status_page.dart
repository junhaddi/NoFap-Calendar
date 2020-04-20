import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class StatusPage extends StatefulWidget {
  @override
  _StatusPageState createState() => _StatusPageState();
}

class _StatusPageState extends State<StatusPage> {
  Widget build(BuildContext context) {
    return Container(
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
          ],
        ),
      ),
    );
  }
}
