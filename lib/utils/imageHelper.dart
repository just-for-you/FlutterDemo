import 'package:flutter/material.dart';

//void main() => runApp(app);
//class

/*
* img工具类
*/
class ImageHelper {

  static String png(String name) {
    return "assets/images/$name.png";
  }

  static Widget icon(String name, {double width, double height, BoxFit boxFit}) {
    return Image.asset(
      png(name),
      width: width,
      height: height,
      fit: boxFit,
    );
  }


}