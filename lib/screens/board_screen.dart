import 'package:flutter/material.dart';
import 'package:flutter_native_admob/flutter_native_admob.dart';
import 'package:flutter_native_admob/native_admob_controller.dart';
import 'package:nofapcamp/widgets/custom_app_bar.dart';

import '../custom_icons_icons.dart';

class BoardScreen extends StatelessWidget {
  static const _adUnitID = 'ca-app-pub-8336339515298040/6724604841';
  final _nativeAdController = NativeAdmobController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: '게시판',
      ),
      body: ListView.builder(
        itemBuilder: (context, index) {
          return Card(
            margin: EdgeInsets.all(8.0),
            elevation: 4.0,
            child: Container(
              height: 300.0,
              child: NativeAdmob(
                adUnitID: _adUnitID,
                controller: _nativeAdController,
                type: NativeAdmobType.full,
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(CustomIcons.pencil),
      ),
    );
  }
}
