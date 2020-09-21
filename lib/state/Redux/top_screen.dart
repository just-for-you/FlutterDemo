import 'package:FlutterDemo/state/Redux/under_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

import 'count_state.dart';

class TopScreen extends StatefulWidget {
  @override
  _TopScreenState createState() => _TopScreenState();
}

class _TopScreenState extends State<TopScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Top Screen'),
      ),
      body: Center(
        // store与其他Widget关联，通过StoreProvider找到顶层的store。而且能够在state发生变化时rebuilt Widget
        // StoreConnector主要是有个数据转化的作用，从store中获取我们想要的state再赋值到组件上，StoreBuilder是直接将数据给显示在组件上
        // converter: 转化函数，从 Store 中拿出修改的数据 store.state.count
        // builder: 将 converter 返回的 count 进一步转化为界面：Text(count)。本质上基于Stream
        child: StoreConnector<CountState,int>(
          // ViewModel如果很复杂，可以使用distinct属性进行性能优化
          converter: (store) => store.state.count,
          builder: (context, count) {
            return Text(
              count.toString(),
              style: Theme.of(context).textTheme.display1,
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context){
            return UnderScreen();
          }));
        },
        child: Icon(Icons.forward),
      ),
    );
  }
}
