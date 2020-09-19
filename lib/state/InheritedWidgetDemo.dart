
import 'package:flutter/material.dart';



class InheritedWidgetDemo extends InheritedWidget {

  final int accountId;

  InheritedWidgetDemo(this.accountId, {Key key, Widget child}) : super(key: key, child: child);

  // 优化点:在你横屏变竖屏的同时，导致整个UI重新build，
  // 可由于updateShouldNotify的判断，系统将不会重新build MyOtherWidget，也是一种布局优化。
  @override
  bool updateShouldNotify(InheritedWidgetDemo old) => accountId != old.accountId;

  // 子树中的组件通过InheritedWidgetDemo.of(context)访问共享状态。
  static InheritedWidgetDemo of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<InheritedWidgetDemo>();
  }
}


class MyInheritedDemo extends StatelessWidget {
  final int accountId;

  MyInheritedDemo(this.accountId);

  Widget build(BuildContext context) {
    return new InheritedWidgetDemo(
      accountId,
      // const MyTestWidget() 表示该Widget是常量，不会因为页面的刷新导致重新build，这是优化的细节，
      // 如果用State实现，就需要setState才能实现MyOtherWidget的重新build，这样做的坏处就是导致整个UI的刷新。
      child: const MyTestWidget(),
    );
  }
}

class MyTestWidget extends StatelessWidget {
  const MyTestWidget();

  Widget build(BuildContext context) {
    return MyOtherWidget();
  }
}

class MyOtherWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // InheritedWidgetDemo共享状态accountId给了MyOtherWidget，
    // 而MyOtherWidget是MyWidget的子Widget，这就是InheritedWidget的功效，它可以做到跨组件共享状态。
    final myInheritedWidget = InheritedWidgetDemo.of(context);
    print(myInheritedWidget.accountId);
  }
}
