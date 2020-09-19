import 'package:rxdart/rxdart.dart';

import 'count_bloc.dart';


// https://juejin.im/post/6844903700733886471

class CountBLoCImpl implements CountBloc {

  int _count = 0;

  //增强版StreamController——Subject
  var _subject = BehaviorSubject<int>();//rxdart 封装了StreamController，极大的拓展了Stream的功能

  //Observable实现并扩展了Stream。它将常用的stream和streamTransformer组合成了非常好用的api
  Stream<int> get stream => _subject.stream;

  int get value => _count;

  void increment() => _subject.add(++_count);

  void dispose() {
    _subject.close();
  }
}
