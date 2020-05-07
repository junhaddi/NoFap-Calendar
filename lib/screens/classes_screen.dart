import 'package:flutter/material.dart';

import '../widgets/custom_app_bar.dart';

class ClassesScreen extends StatelessWidget {
  _hasImageCard() {
    return Container();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: '계급',
      ),
      body: ListView(
        children: <Widget>[
          _hasImageCard(),
          _hasImageCard(),
          _hasImageCard(),
          _hasImageCard(),
          _hasImageCard(),
          _hasImageCard(),
        ],
      ),
    );
  }
}
