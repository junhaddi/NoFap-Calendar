import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final List<Widget> actions;

  const CustomAppBar({
    this.title,
    this.actions,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      bottom: PreferredSize(
        child: Container(
          color: Color.fromRGBO(211, 211, 211, 1.0),
          height: 1.0,
        ),
        preferredSize: null,
      ),
      title: Text(
        title,
        style: TextStyle(color: Colors.black),
      ),
      actions: actions,
      elevation: 0,
    );
  }

  final Size preferredSize = const Size.fromHeight(kToolbarHeight);
}
