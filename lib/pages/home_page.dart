import 'package:flutter/material.dart';
import 'package:flutter_native_admob/flutter_native_admob.dart';
import 'package:flutter_native_admob/native_admob_controller.dart';

class HomePage extends StatelessWidget {
  static const _adUnitID = 'ca-app-pub-8336339515298040/5864052966';
  final _nativeAdController = NativeAdmobController();

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (context, index) {
        return Card(
          margin: EdgeInsets.all(5),
          elevation: 5,
          child: Container(
            height: 300,
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
