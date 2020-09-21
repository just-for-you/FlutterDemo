import 'package:flutter/material.dart';

import 'count_bloc.dart';

// ignore: must_be_immutable
class BlocProvider extends InheritedWidget {

  CountBLoC bLoC = CountBLoC();

  BlocProvider({Key key, Widget child}) : super(key: key, child: child);

  @override
  bool updateShouldNotify(_) => true;

  // 关键代码部分通过context.xxxx 向上遍历 Element tree，并找到Widget。
  // 也就是说of实际上是对context跨组件获取数据的一个封装。
  static CountBLoC of(BuildContext context) =>
      (context.inheritFromWidgetOfExactType(BlocProvider) as BlocProvider).bLoC;
}

//
// BuildContext有许多方法可以跨组件获取对象
// ancestorInheritedElementForWidgetOfExactType(Type targetType) → InheritedElement
// ancestorRenderObjectOfType(TypeMatcher matcher) → RenderObject
// ancestorStateOfType(TypeMatcher matcher) → State
// ancestorWidgetOfExactType(Type targetType) → Widget
// findRenderObject() → RenderObject
// inheritFromElement(InheritedElement ancestor, { Object aspect }) → InheritedWidget
// inheritFromWidgetOfExactType(Type targetType, { Object aspect }) → InheritedWidget
// rootAncestorStateOfType(TypeMatcher matcher) → State
// visitAncestorElements(bool visitor(Element element)) → void
// visitChildElements(ElementVisitor visitor) → void
//
