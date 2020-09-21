import 'package:FlutterDemo/state/Redux/top_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

import 'count_state.dart';


/*
* 本质上：通过数据单向流动形成一个环来进行状态管理
*
*
* Redux 主要由3部分组成，Store、Action、Reducer。
* Store：位于整个APP的顶层，存储和管理state；将页面UI与存储在Store中的状态绑定
* Action：简单点就是动作，通过发起一个Action来告诉Reducer该更新状态了，同时是数据从应用传递到 store/state 的载体，也是开启一次数据流的开始。
* Reducer：根据Action产生新的状态；本质上是一个函数。
*
* 原理：
* 所有的状态都存储在Store里。这个Store会放在根Widget.
* View拿到Store的状态数据会映射成视图渲染.
* Redux不直接让view操作数据，通过dispatch一个action通知Reducer,状态变更
* Reducer接收到这个action，根据action状态，生成新的状态，并替换在Store的旧状态.
* Store存储了新的状态后，就通知所有使用到了这个状态的View更新（类似setState）。这样我们就能够同步不同view中的状态了.
* 注意：
* Store更新状态的时候，并不是更改原来的状态对象，而是直接将reducer生成的新的状态对象替换掉老的状态对象。所以，我们的状态应该是immutable的。
*
* middleware中间件：类似拦截器，作用域位于reducer更新状态之前，本质上也是一个函数。
*/
void main() {
  // 创建全局Store，引入中间件 middleware
  final store = Store<CountState>(reducer, middleware: middleware, initialState: CountState.initState());
  runApp(new MyApp(store));
}

class MyApp extends StatelessWidget {

  final Store<CountState> store;

  MyApp(this.store);

  @override
  Widget build(BuildContext context) {
    // store与根Widget关联 InheritedWidget
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
