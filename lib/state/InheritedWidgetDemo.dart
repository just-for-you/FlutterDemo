import 'package:flutter/material.dart';


class InheritedWidgetModel extends InheritedWidget {

  final int accountId;

  InheritedWidgetModel(this.accountId, {Key key, Widget child}) : super(key: key, child: child);

  // 优化点:在你横屏变竖屏的同时，导致整个UI重新build，
  // 可由于updateShouldNotify的判断，系统将不会重新build MyOtherWidget，也是一种布局优化。
  @override
  bool updateShouldNotify(InheritedWidgetModel old) => accountId != old.accountId;

  // 子树中的组件通过InheritedWidgetDemo.of(context)访问共享状态。
  static InheritedWidgetModel of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<InheritedWidgetModel>();
  }
}



class MyInheritedDemo extends StatelessWidget {
  final int accountId;

  MyInheritedDemo(this.accountId);

  Widget build(BuildContext context) {
    return new InheritedWidgetModel(
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
    final myInheritedWidget = InheritedWidgetModel.of(context);
    print(myInheritedWidget.accountId);

    return Scaffold(
      appBar: AppBar(title: Text('InheritedDemo')),
      body: Center(
        child: Text("my accountId is : ${myInheritedWidget.accountId}")
      ),

      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {

        },
      ),
    );
  }
}



// InheritedWidget是flutter中用来从上层传递数据到下层的组件（类似于React中的Context）。对于简单的情况，如果需要将数据传递到下层，可以通过参数的方式。
// 这种方式在Widget层级不是很深的时候比较方便，但是如果Widget层级很多，就需要从上层一层一层的向下传递，容易造成混乱。所以flutter提供了InheritedWidget方便上层Widget跨层级为下层子节点提供数据。
//

// 解析状态传递共享机制：
// 每个 Element 实例上都有一个 _inheritedWidgets 属性。该属性的类型为：
// HashMap<Type, InheritedElement>
// 其中保存了祖先节点中出现的 InheritedWidget 与其对应 element 的映射关系。在 element 的 mount 阶段和 active 阶段，会执行 _updateInheritance() 方法更新这个映射关系。
// 对于普通 Element 实例，_updateInheritance() 只是单纯把父 element 的 _inheritedWidgets 属性保存在自身 _inheritedWidgets 里。从而实现映射关系的层层向下传递。
// void _updateInheritance() {
//     assert(_active);
//     _inheritedWidgets = _parent?._inheritedWidgets;
//   }
// 由 InheritedWidget 创建的 InheritedElement 重写了该方法：
// void _updateInheritance() {
//     assert(_active);
//     final Map<Type, InheritedElement> incomingWidgets = _parent?._inheritedWidgets;
//     if (incomingWidgets != null)
//       _inheritedWidgets = new HashMap<Type, InheritedElement>.from(incomingWidgets);
//     else
//       _inheritedWidgets = new HashMap<Type, InheritedElement>();
//     _inheritedWidgets[widget.runtimeType] = this;
//   }
// 可以看出 InheritedElement 实例会把自身的信息添加到 _inheritedWidgets 属性中，
// 这样其子孙 element 就可以通过前面提到的 _inheritedWidgets 的传递机制获取到此 InheritedElement 的引用。
//
// dependOnInheritedElement:首先会将ancestor保存在_dependencies中，再调用ancestor的 updateDependencies方法。
// 而updateDependencies方法再调用setDependencies方法
// setDependencies方法底层的Element保存在_dependents Map中。
// 这是通过BuildContext的dependOnInheritedWidgetOfExactType访问到祖先InhritedWidget的过程
//
// InheritedWidget 的更新通知机制
// 在定义InheritedWidget时还需要重写updateShouldNotify方法，这个方法会在InheritedEelement中的updated方法中被调用
// 调用updateShouldNotify方法，如果返回true就再调用super.updated(oldWidget)方法，否则，不执行任何操作。
// InheritedElement的父类是ProxyElement，ProxyElement的updated方法会调用notifyClinets(oldWidget)方法
// notifyClinets(oldWidget)方法是ProxyElement定义的抽象方法，在InheritedElement类中有具体的实现如下：
// 会循环遍历_dependents列表，调用notifyDependent(oldWidget, dependent)方法
// notifyDependent方法会直接调用dependent的didChangeDependencies方法，这个方法定义在Element类中，实现如下
// didChangeDependencies方法会调用Element的markNeedsBuild方法，而markNeedsBuild方法会将该element标记为dirty，在下一帧将会重新build。
//
//

