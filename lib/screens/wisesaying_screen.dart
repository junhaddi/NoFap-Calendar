import 'package:flutter/material.dart';
import 'package:nofapcamp/widgets/custom_app_bar.dart';

class WisesayingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: '명언',
      ),
    );
  }
}
