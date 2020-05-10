import 'package:flutter/material.dart';

class Classes {
  final String name;
  final String description;
  final AssetImage image;
  final int srcDay;
  final int dstDay;

  Classes({this.name, this.description, this.image, this.srcDay, this.dstDay});
}

final List<Classes> classesList = [
  Classes(
    name: '이병',
    description: '이등병',
    image: AssetImage('assets/images/classes/classes_1.jpg'),
    srcDay: 1,
    dstDay: 2,
  ),
  Classes(
    name: '일병',
    description: '일등병',
    image: AssetImage('assets/images/classes/classes_2.jpg'),
    srcDay: 3,
    dstDay: 6,
  ),
  Classes(
    name: '상병',
    description: '상등병',
    image: AssetImage('assets/images/classes/classes_3.jpg'),
    srcDay: 7,
    dstDay: 10,
  ),
  Classes(
    name: '병장',
    description: '병장',
    image: AssetImage('assets/images/classes/classes_4.jpg'),
    srcDay: 11,
    dstDay: 14,
  ),
  Classes(
    name: '하사',
    description: '하사',
    image: AssetImage('assets/images/classes/classes_5.png'),
    srcDay: 15,
    dstDay: 20,
  ),
  Classes(
    name: '중사',
    description: '중사',
    image: AssetImage('assets/images/classes/classes_6.png'),
    srcDay: 21,
    dstDay: 25,
  ),
  Classes(
    name: '상사',
    description: '상사',
    image: AssetImage('assets/images/classes/classes_7.png'),
    srcDay: 26,
    dstDay: 30,
  ),
  Classes(
    name: '원사',
    description: '원사',
    image: AssetImage('assets/images/classes/classes_8.png'),
    srcDay: 31,
    dstDay: 40,
  ),
  Classes(
    name: '준위',
    description: '준위',
    image: AssetImage('assets/images/classes/classes_9.png'),
    srcDay: 41,
    dstDay: 48,
  ),
  Classes(
    name: '소위',
    description: '소위',
    image: AssetImage('assets/images/classes/classes_10.png'),
    srcDay: 49,
    dstDay: 59,
  ),
  Classes(
    name: '중위',
    description: '중위',
    image: AssetImage('assets/images/classes/classes_11.png'),
    srcDay: 60,
    dstDay: 72,
  ),
  Classes(
    name: '대위',
    description: '대위',
    image: AssetImage('assets/images/classes/classes_12.png'),
    srcDay: 73,
    dstDay: 87,
  ),
  Classes(
    name: '소령',
    description: '소령',
    image: AssetImage('assets/images/classes/classes_13.png'),
    srcDay: 88,
    dstDay: 104,
  ),
  Classes(
    name: '중령',
    description: '중령',
    image: AssetImage('assets/images/classes/classes_14.png'),
    srcDay: 105,
    dstDay: 123,
  ),
  Classes(
    name: '대령',
    description: '대령',
    image: AssetImage('assets/images/classes/classes_15.png'),
    srcDay: 124,
    dstDay: 149,
  ),
  Classes(
    name: '준장',
    description: '준장',
    image: AssetImage('assets/images/classes/classes_16.png'),
    srcDay: 150,
    dstDay: 199,
  ),
  Classes(
    name: '소장',
    description: '소장',
    image: AssetImage('assets/images/classes/classes_17.png'),
    srcDay: 200,
    dstDay: 249,
  ),
  Classes(
    name: '중장',
    description: '중장',
    image: AssetImage('assets/images/classes/classes_18.png'),
    srcDay: 250,
    dstDay: 299,
  ),
  Classes(
    name: '대장',
    description: '대장',
    image: AssetImage('assets/images/classes/classes_19.png'),
    srcDay: 300,
    dstDay: 359,
  ),
  Classes(
    name: '원수',
    description: '원수',
    image: AssetImage('assets/images/classes/classes_20.png'),
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
      classesImage = classesList[classesList.length - 1].image;
    } else if (progressDay >= classes.srcDay && progressDay <= classes.dstDay) {
      classesImage = classes.image;
    }
  });
  return classesImage;
}
