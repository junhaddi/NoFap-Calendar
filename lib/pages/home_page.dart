import 'package:flutter/material.dart';
import 'package:flutter_native_admob/flutter_native_admob.dart';
import 'package:flutter_native_admob/native_admob_controller.dart';

class HomePage extends StatelessWidget {
  static const _adUnitID = 'ca-app-pub-8336339515298040/6724604841';
  final _nativeAdController = NativeAdmobController();

  // 로고 그냥 추가 해봤음
  // 맘에 안들면 삭제
  _appBarLogo() {
    return Container(
      margin: EdgeInsets.all(5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
        border: Border.all(
          // 테두리 색갈 생각
          color: Colors.blue,
          width: 3
        )
      ),
      child: CircleAvatar(
        backgroundImage: AssetImage('assets/ic_launcher.png'),
      ),
    );
  }

  // 광고창
  _googleAd() {
    return Container(
      height: 230,
      // height: 300,
      child: Card(
        margin: EdgeInsets.all(5),
        elevation: 5,
        child: NativeAdmob(
          adUnitID: _adUnitID,
          controller: _nativeAdController,
          type: NativeAdmobType.full,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            floating: true,
            leading: _appBarLogo(),
            title: Text('금딸캘린더'),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                return _googleAd();
              },
            )
          )
        ],
      )
    );
  }
}
