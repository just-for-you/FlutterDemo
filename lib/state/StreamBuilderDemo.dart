import 'dart:async';
import 'package:flutter/material.dart';

/*
* ui页面是经常要改内容的 但是如果用setState方法去刷新 每次都会重新 Build构造一遍 会造成app卡顿 资源占用高，
* 所以可以使用StreamBuild 去订阅 刷新需要刷新的那个UI部件 就不用重构一遍整个页面,
* 除了StreamBuild以外 还有很多种方式 如谷歌的亲儿子Provider ，以及第三方的Bloc ，
* 当然 bloc 也是可以和StreamBuild组合使用的，但是小项目没有必要 比较适合大型项目进行状态的管理
*/

class StreamBuilderDemo extends StatefulWidget {
  @override
  _StreamBuilderDemoState createState() => _StreamBuilderDemoState();
}

class _StreamBuilderDemoState extends State<StreamBuilderDemo> {

  String _str = "我会变哦";

  // 步骤1: 初始化一个StreamController<可以是 int string...  一般是model>
  final StreamController<String> _streamController = StreamController<String>();

  @override
  void dispose() {

    //步骤2.关流，不关闭流会消耗资源，同时会引起内存泄漏
    _streamController.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(title: Text('StreamBuilderDemo')),
      body: Center(

        //步骤3.使用StreamBuilder构造器
        child: StreamBuilder<String>(

            // 监听Stream，每次值改变的时候，更新Text中的内容
            stream: _streamController.stream,//数据流
            initialData: _str,//初始值
            builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
              return Text('点击的时候这个值会改变: ${snapshot.data}');
            }),
      ),

      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {

          // 点击按钮，更改_str 的值，同时通过Sink将它发送给Stream；
          // 注入一个值时，会引起StreamBuilder的监听，StreamBuilder重建并刷新_str
          // 步骤4.往StreamBuilder里添加流，数据变了，就用通知小部件
          _str = "喝喝喝";
          _streamController.sink.add(_str);
        },
      ),
    );
  }

}
