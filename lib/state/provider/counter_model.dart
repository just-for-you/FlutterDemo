import 'package:flutter/material.dart';

// 计数Model 发布者
class CounterModel with ChangeNotifier {

  int _count = 0;
  int get value => _count;

  void increment() {
    _count++;
    notifyListeners();
  }

}