import 'package:flutter/material.dart';
import 'package:flutter_native_admob/flutter_native_admob.dart';
import 'package:flutter_native_admob/native_admob_controller.dart';

class SubscribeScreen extends StatelessWidget {
  static const _adUnitID = 'ca-app-pub-8336339515298040/6724604841';
  final _nativeAdController = NativeAdmobController();

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (context, index) {
        return Card(
          margin: EdgeInsets.all(8.0),
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
    );
  }
}
