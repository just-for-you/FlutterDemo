import 'dart:async';

import 'bloc_base.dart';


// 增量Bloc
class IncrementBloc implements BlocBase {
  int _counter;

  //Stream
  StreamController<int> _counterPipe = StreamController<int>();
  Stream<int> get outCounter => _counterPipe.stream;

  IncrementBloc() {
    _counter = 0;
    //_counterPipe 用于StreamBuilder，已经自动加了listen
  }

  //状态数据变化，并加入到Stream重中
  incrementCounter() {
    _counter = _counter + 1;
    _counterPipe.sink.add(_counter);
  }

  //资源释放
  void dispose() {
    print('bloc disposed!');
    _counterPipe.close();
  }

}
