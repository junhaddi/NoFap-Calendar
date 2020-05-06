import 'package:flutter/material.dart';

class InkWellCard extends StatelessWidget {
  final VoidCallback onTap;
  final Widget child;
  final BorderRadius _baseBorderRadius = BorderRadius.circular(50.0);

  InkWellCard({@required this.onTap, @required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(4.0),
      child: Card(
        elevation: 4.0,
        shape: RoundedRectangleBorder(borderRadius: _baseBorderRadius),
        child: InkWell(
          borderRadius: _baseBorderRadius,
          onTap: onTap,
          child: child,
        ),
      ),
    );
  }
}
