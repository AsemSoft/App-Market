import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/cupertino.dart';

Widget imageCarousel = new Container(
  height: 280,
  child: new Carousel(
    boxFit: BoxFit.fill,
    images: [
      AssetImage('images/1.JFIF'),
      AssetImage('images/2.JFIF'),
      AssetImage('images/5.JFIF'),
      AssetImage('images/9.JPEG'),
    ],
    autoplay: true,
    animationCurve: Curves.fastOutSlowIn,
    animationDuration: Duration(microseconds: 1000),
    dotSize: 4.0,
    indicatorBgPadding: 2.0,
  ),
);
