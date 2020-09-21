import 'package:flutter/material.dart';

// color 发布者
// 这里的 Model 实际上就是我们的状态，它不仅储存了我们的数据模型，而且还包含了更改数据的方法，并暴露出它想要暴露出的数据。
// 使用 mixin
class ColorModel with ChangeNotifier {

  // 数据私有，通过get暴露，并提供更改方法
  int _seed = 0xFFFF9000;
  Color _color = Color(0xFFFF9000);

  get color => _color;

  changeColor() {
    _seed += 30;
    _color = Color(_seed);
    notifyListeners();
  }

}
