import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  const CustomAppBar({
    this.title,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      bottom: PreferredSize(
        child: Container(
          color: Color.fromRGBO(105, 105, 105, 1.0),
          height: 0.3,
        ),
        preferredSize: null,
      ),
      title: Text(
        title,
      ),
      elevation: 0.0,
    );
  }

  final Size preferredSize = const Size.fromHeight(kToolbarHeight);
}
