import 'package:FlutterDemo/state/Redux/top_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

import 'count_state.dart';


/*
* 这里使用了redux/flutter_redux库，它们都是由Brian Egan大神编写的。其中flutter_redux是用来简化redux的使用的。
*
*
* Redux 主要由3部分组成，Store、Action、Reducer。
* Store：位于整个APP的顶层，存储和管理state；
* Action：简单点就是动作，通过发起一个Action来告诉Reducer该更新状态了；
* Reducer：根据Action产生新的状态；
*
* 原理：
* 所有的状态都存储在Store里。这个Store会放在根Widget.
* View拿到Store的状态数据会映射成视图渲染.
* Redux不直接让view操作数据，通过dispatch一个action通知Reducer,状态变更
* Reducer接收到这个action，根据action状态，生成新的状态，并替换在Store的旧状态.
* Store存储了新的状态后，就通知所有使用到了这个状态的View更新（类似setState）。这样我们就能够同步不同view中的状态了.
*
* 注意：Store更新状态的时候，并不是更改原来的状态对象，而是直接将reducer生成的新的状态对象替换掉老的状态对象。所以，我们的状态应该是immutable的。
*/
void main() {
  final store = Store<CountState>(reducer, initialState: CountState.initState());
  runApp(new MyApp(store));
}

class MyApp extends StatelessWidget {

  final Store<CountState> store;

  MyApp(this.store);

  @override
  Widget build(BuildContext context) {
    return StoreProvider<CountState>(
      store: store,
      child: new MaterialApp(
        title: 'Flutter Demo',
        theme: new ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: TopScreen(),
      ),
    );
  }
}
