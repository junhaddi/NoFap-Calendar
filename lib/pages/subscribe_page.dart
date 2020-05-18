import 'package:flutter/material.dart';
import 'package:flutter_native_admob/flutter_native_admob.dart';
import 'package:flutter_native_admob/native_admob_controller.dart';

class SubscribeScreen extends StatefulWidget {
  @override
  _SubscribeScreenState createState() => _SubscribeScreenState();
}

class _SubscribeScreenState extends State<SubscribeScreen>
    with AutomaticKeepAliveClientMixin {
  static const _adUnitID = 'ca-app-pub-8336339515298040/6724604841';
  final _nativeAdController = NativeAdmobController();

  // TODO 로컬 구독 정보 구현

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    // TODO 서버로부터 구독 정보 받아오기
  }

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
