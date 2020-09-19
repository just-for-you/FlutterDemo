import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import 'count_model.dart';
import 'under_screen.dart';

class TopScreen extends StatefulWidget {
  @override
  _TopScreenState createState() => _TopScreenState();
}

class _TopScreenState extends State<TopScreen> {

  /*
  * 获取model的方式2 —— 使用ScopedModel.of，静态获取model用法实例
  *
  * 注意：在使用第二种方式的时候，rebuildOnChange属性默认为false，所以会导致无法刷新（同步）状态的情况发生，需要手动指定rebuildOnChange：true。
  */
  Model getModel(BuildContext context){
    // 直接使用of / 使用CountModel中重写的of
    final countModel = ScopedModel.of<CountModel>(context);
    final countModel2 = CountModel().of(context);

    countModel.increment();
    countModel2.increment();
    return countModel;
    // return countMode2;
  }

  @override
  Widget build(BuildContext context) {
    /*
    * Scoped_model在子页面中获取model的方式1
    *
    * builder是一个ScopedModelDescendantBuilder，它接收三个参数。
    * 在builder中能够通过model来获取CountModel实例。
    *
    * rebuildOnChange属性能够控制当该状态发生变化时，是否rebuild，作用等同于setState，调用改变状态的一些方法时，不必再setState。
    */
    return ScopedModelDescendant<CountModel>(
      builder: (context,child,model){
        return Scaffold(
          appBar: AppBar(
            title: Text('ScopedModelDemo'),
          ),
          body: Center(
            child: Text(
              model.count.toString(),
              style: TextStyle(fontSize: 48.0),
            ),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context){
                return UnderScreen(title: "Under Screen",);
              }));
            },
            child: Icon(Icons.forward),
          ),
        );
      },
    );
  }

}