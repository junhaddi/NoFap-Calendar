import 'package:flutter/material.dart';

class Classes {
  final AssetImage image;
  final String name;
  final String description;
  final int srcDay;
  final int dstDay;

  Classes({this.image, this.name, this.description, this.srcDay, this.dstDay});
}

final List<Classes> classesList = [
  Classes(
    image: AssetImage('assets/images/classes/classes_1.jpg'),
    name: '이등병',
    description: '이등병',
    srcDay: 1,
    dstDay: 2,
  ),
  Classes(
    image: AssetImage('assets/images/classes/classes_2.jpg'),
    name: '일등병',
    description: '일등병',
    srcDay: 3,
    dstDay: 6,
  ),
  Classes(
    image: AssetImage('assets/images/classes/classes_3.jpg'),
    name: '상등병',
    description: '상등병',
    srcDay: 7,
    dstDay: 10,
  ),
  Classes(
    image: AssetImage('assets/images/classes/classes_4.jpg'),
    name: '병장',
    description: '병장',
    srcDay: 11,
    dstDay: 14,
  ),
  Classes(
    image: AssetImage('assets/images/classes/classes_5.png'),
    name: '하사',
    description: '하사',
    srcDay: 15,
    dstDay: 20,
  ),
  Classes(
    image: AssetImage('assets/images/classes/classes_6.png'),
    name: '중사',
    description: '중사',
    srcDay: 21,
    dstDay: 25,
  ),
  Classes(
    image: AssetImage('assets/images/classes/classes_7.png'),
    name: '상사',
    description: '상사',
    srcDay: 26,
    dstDay: 30,
  ),
  Classes(
    image: AssetImage('assets/images/classes/classes_8.png'),
    name: '원사',
    description: '원사',
    srcDay: 31,
    dstDay: 40,
  ),
  Classes(
    image: AssetImage('assets/images/classes/classes_9.png'),
    name: '준위',
    description: '준위',
    srcDay: 41,
    dstDay: 48,
  ),
  Classes(
    image: AssetImage('assets/images/classes/classes_10.png'),
    name: '소위',
    description: '소위',
    srcDay: 49,
    dstDay: 59,
  ),
  Classes(
    image: AssetImage('assets/images/classes/classes_11.png'),
    name: '중위',
    description: '중위',
    srcDay: 60,
    dstDay: 72,
  ),
  Classes(
    image: AssetImage('assets/images/classes/classes_12.png'),
    name: '대위',
    description: '대위',
    srcDay: 73,
    dstDay: 87,
  ),
  Classes(
    image: AssetImage('assets/images/classes/classes_13.png'),
    name: '소령',
    description: '소령',
    srcDay: 88,
    dstDay: 104,
  ),
  Classes(
    image: AssetImage('assets/images/classes/classes_14.png'),
    name: '중령',
    description: '중령',
    srcDay: 105,
    dstDay: 123,
  ),
  Classes(
    image: AssetImage('assets/images/classes/classes_15.png'),
    name: '대령',
    description: '대령',
    srcDay: 124,
    dstDay: 149,
  ),
  Classes(
    image: AssetImage('assets/images/classes/classes_16.png'),
    name: '준장',
    description: '준장',
    srcDay: 150,
    dstDay: 199,
  ),
  Classes(
    image: AssetImage('assets/images/classes/classes_17.png'),
    name: '소장',
    description: '소장',
    srcDay: 200,
    dstDay: 249,
  ),
  Classes(
    image: AssetImage('assets/images/classes/classes_18.png'),
    name: '중장',
    description: '중장',
    srcDay: 250,
    dstDay: 299,
  ),
  Classes(
    image: AssetImage('assets/images/classes/classes_19.png'),
    name: '대장',
    description: '대장',
    srcDay: 300,
    dstDay: 359,
  ),
  Classes(
    image: AssetImage('assets/images/classes/classes_20.png'),
    name: '원수',
    description: '원수',
    srcDay: 400,
    dstDay: -1,
  ),
];

List<Classes> getClassesList() {
  return classesList;
}

AssetImage getClassesImage(progressDay) {
  AssetImage classesImage;
  classesList.forEach((classes) {
    if (progressDay >= classesList[classesList.length - 1].srcDay) {
      // 마지막 계급
      classesImage = classesList[classesList.length - 1].image;
    } else if (progressDay >= classes.srcDay && progressDay <= classes.dstDay) {
      classesImage = classes.image;
    }
  });
  return classesImage;
}
