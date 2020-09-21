
import 'package:flutter/material.dart';


// 定义TestNotification通知的实现
class TestNotification extends Notification {
  final int test;

  TestNotification(this.test);
}

var a = 0;


// WidgetListener通过Widget NotificationListener来监听数据变化，最终通过setState变更数据
// WidgetNotification 实例化了两次，一次在NotificationListener的树内部，一个在NotificationListener的外部，
// 经过测试发现，在外部的WidgetNotification并不能通知到内容变化。

class NotificationDemo extends StatefulWidget {
  @override
  _NotificationDemoState createState() => _NotificationDemoState();
}

class _NotificationDemoState extends State<NotificationDemo> {
  int _test = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('NotificationDemo'),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            SizedBox.fromSize(size: Size(100, 100)),
            NotificationListener<TestNotification>(
              child: Column(
                children: <Widget>[
                  Text("监听$_test"),
                  SizedBox.fromSize(size: Size(10, 10)),
                  WidgetNotification(btnText: "子Widget",)
                ],
              ),
              onNotification: (TestNotification notification) {
                setState(() {
                  _test = notification.test;
                });
                return true;
              },
            ),
            SizedBox.fromSize(size: Size(10, 10)),
            WidgetNotification(btnText: "非子Widget",)
          ],
        ),
      ),
    );
  }
}


// WidgetNotification 负责通知结果，通过RaisedButton的点击事件，将数据a传递出去，通过Notification提供的dispatch方法向上传递
// ignore: must_be_immutable
class WidgetNotification extends StatelessWidget {

  final String btnText;

  WidgetNotification({Key key, this.btnText}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: RaisedButton(
        child: Text(btnText),
        onPressed: () {
          var b = ++a;
          debugPrint(b.toString());
          TestNotification(b).dispatch(context);
        },
      ),
    );
  }
}