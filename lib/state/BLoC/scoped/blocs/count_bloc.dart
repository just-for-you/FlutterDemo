import 'dart:async';


class CountBLoC {

  int _count = 0;
  // 创建StreamController的时候，默认是创建的单订阅流。改成广播流
  var _countController = StreamController<int>.broadcast();

  Stream<int> get stream => _countController.stream;
  int get value => _count;

  increment() {
    _countController.sink.add(++_count);
  }

  dispose() {
    _countController.close();
  }
}
