import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

import 'count_state.dart' as countState;
import 'count_state.dart';

class UnderScreen extends StatefulWidget {
  @override
  _UnderScreenState createState() => _UnderScreenState();
}

class _UnderScreenState extends State<UnderScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Under Screen'),
      ),
      body: Center(
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new Text(
              'You have pushed the button this many times:',
            ),
            StoreConnector<CountState,int>(
              converter: (store) => store.state.count,
              builder: (context, count) {
                return Text(
                  count.toString(),
                  style: Theme.of(context).textTheme.display1,
                );
              },
            ),
          ],
        ),
      ),

      // converter 转化函数，转化为回调，从 Store 中dispatch action，通知reducer生成了新的状态
      floatingActionButton: StoreConnector<CountState,VoidCallback>(
        converter: (store) {
          // 如果有中间件：会拦截该操作，在运行中间件后（责任链），操作将被发送到给定的reducer生成新的状态，并更新状态树。
          print("store.dispatch -----> Action.increment");
          return () => store.dispatch(countState.Action.increment);
        },
        builder: (context, callback) {
          return FloatingActionButton(
            onPressed: callback,
            child: Icon(Icons.add),
          );
        },
      ),
    );
  }
}
