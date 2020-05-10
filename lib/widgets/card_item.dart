import 'package:flutter/material.dart';

import 'inkwell_card.dart';

class CardItem extends StatelessWidget {
  final String title;
  final IconData icon;
  final bool isSingle;
  final VoidCallback onTap;

  CardItem({
    this.title = '',
    this.icon,
    this.isSingle = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWellCard(
      onTap: onTap,
      child: isSingle
          ? Stack(
              children: <Widget>[
                Positioned.fill(
                  left: 20.0,
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Icon(
                      icon,
                      size: 32.0,
                      color: Colors.redAccent,
                    ),
                  ),
                ),
                Positioned.fill(
                  right: 20.0,
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Icon(
                      Icons.arrow_forward_ios,
                      size: 28.0,
                    ),
                  ),
                ),
                Center(
                  child: Text(
                    title,
                    style: TextStyle(
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            )
          : Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(
                  icon,
                  size: 32.0,
                  color: Colors.redAccent,
                ),
                SizedBox(
                  height: 10.0,
                ),
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
    );
  }
}
