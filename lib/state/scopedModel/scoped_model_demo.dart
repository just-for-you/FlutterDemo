import 'package:FlutterDemo/state/scopedModel/top_screen.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import 'count_model.dart';


// ignore: must_be_immutable
class ScopedModelDemo extends StatelessWidget {

  // 创建顶层状态
  CountModel countModel = CountModel();

  @override
  Widget build(BuildContext context) {

    // ScopedModel<T extends Model>是一个StatelessWidget，它接收一个model，并提供给需要它的所有部件。
    // build中_InheritedModel派生自InheritedWidget
    return ScopedModel<CountModel>(
      // 将ScopedModel<T extends Model>的model属性绑定我们的CountModel对象。
      model: countModel,
      child: new MaterialApp(
        title: 'ScopedModelDemo',
        theme: new ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: TopScreen(),
      ),
    );
  }
}