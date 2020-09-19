import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'counter_model.dart';
import 'screens.dart';


/// Provider：跨组件状态共享
///
///
/// 和BLoC的流式思想相比, Provider是一个观察者模式（借助于ChangeNotifier实现发布者-订阅者模式），状态改变时要notifyListeners().
/// Provider的实现在内部还是基于InheritedWidget.
/// Provider的好处: dispose指定后会自动被调用, 支持MultiProvider.
///
/// Provider 不仅做到了提供数据，而且它拥有着一套完整的解决方案，覆盖了你会遇到的绝大多数情况。
/// 就连 BLoC 未解决的那个棘手的 dispose 问题，和 ScopedModel 的侵入性问题，它也都解决了。
/// 然而Flutter Widget构建模式很容易在UI层面上组件化，但是仅仅使用 Provider，Model 和 View 之间还是容易产生依赖。
/// 不过对于大多数情况来说，Provider 足以优秀，它能够让你开发出简单、高性能、层次清晰 的应用。
///
void main() {

  // 顶层共享数据model（状态）
  final counter = CounterModel();
  final textSize = 48;

  runApp(
    // 订阅者
    MultiProvider(providers: [

      // Provider：只用于数据共享管理，提供给子孙节点使用，UpdateShouldNotify Function，用于控制刷新时机
      Provider<int>(create: (_) => textSize),

      // ChangeNotifierProvider: 不仅能够提供数据供子孙节点使用，还可以在数据改变的时候通知所有消费者
      // Model变化后会自动通知ChangeNotifierProvider（订阅者），ChangeNotifierProvider内部会重新构建InheritedWidget，而依赖该InheritedWidget的子孙Widget就会更新。
      ChangeNotifierProvider<CounterModel>.value(value: counter),
    ], child: MyApp()),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      home: DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: TabBar(tabs: [
            Tab(
              text: 'CounterDemo',
              icon: Icon(Icons.create),
            ),
            Tab(
              text: 'SelectorDemo',
              icon: Icon(Icons.shopping_cart),
            ),
            Tab(
              text: 'SelectorUpdateDemo',
              icon: Icon(Icons.sentiment_satisfied),
            ),
          ]),
          body: TabBarView(
            children: [
              FirstScreen(),
              GoodsListScreen(),
              OrderListScreen(),
            ],
          ),
        ),
      ),
    );
  }
}
