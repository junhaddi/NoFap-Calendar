import 'package:flutter/material.dart';
import 'package:flutter_native_admob/flutter_native_admob.dart';
import 'package:flutter_native_admob/native_admob_controller.dart';
import 'package:nofapcamp/widgets/custom_app_bar.dart';

class ViewmoreScreen extends StatelessWidget {
  static const _adUnitID = 'ca-app-pub-8336339515298040/6724604841';
  final _nativeAdController = NativeAdmobController();

  // TODO 커뮤니티 목록 구현

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: '더보기',
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: ListView.builder(
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
      ),
    );
  }
}
