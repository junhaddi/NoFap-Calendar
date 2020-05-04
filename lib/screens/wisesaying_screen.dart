import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:nofapcamp/widgets/custom_app_bar.dart';

class WisesayingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: '명언',
      ),
      body: Swiper(
        itemBuilder: (BuildContext context, int index) {
          return new Image.network(
            "https://i.pinimg.com/736x/54/01/5e/54015e9d50e0bfdcc92d5ca90c10efc3.jpg",
            fit: BoxFit.fill,
          );
        },
        itemCount: 10,
        itemWidth: 300.0,
        itemHeight: 500.0,
        layout: SwiperLayout.STACK,
      ),
    );
  }
}
