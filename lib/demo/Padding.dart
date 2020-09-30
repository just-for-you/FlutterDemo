



/*
* https://www.jianshu.com/p/06259a762c8b
*
* Padding  A widget that insets its child by the given padding.
*
* 简介：
* Padding在Flutter中用的也挺多的，作为一个基础的控件，功能非常单一，给子节点设置padding属性。
* 写过其他端的都了解这个属性，就是设置内边距属性，内边距的空白区域，也是widget的一部分。
*
* Flutter中并没有单独的Margin控件，在Container中有margin属性，看源码关于margin的实现。
* if (margin != null)
* current = new Padding(padding: margin, child: current);
* 不难看出，Flutter中淡化了margin以及padding的区别，margin实质上也是由Padding实现的。
*
*
* 布局行为:
* 1.当child为空的时候，会产生一个宽为left+right，高为top+bottom的区域；
* 2.当child不为空的时候，Padding会将布局约束传递给child，根据设置的padding属性，缩小child的布局尺寸。
* 然后Padding将自己调整到child设置了padding属性的尺寸，在child周围创建空白区域。
* 当child不为null的时候，经历了三个过程，即调整child尺寸、调整child位置以及调整Padding尺寸，最终达到实际的布局效果。
*
* 继承关系
* Object > Diagnosticable > DiagnosticableTree > Widget > RenderObjectWidget > SingleChildRenderObjectWidget > Padding
* 从继承关系可以看出，Padding控件是一个基础控件，不像Container这种组合控件。Container中的margin以及padding属性都是利用Padding控件去实现的。
* SingleChildRenderObjectWidget:
* RenderObjectWidgets的一个子类，用于限制只能有一个子节点。它只提供child的存储，而不提供实际的更新逻辑。
* RenderObjectWidgets:
* 为RenderObjectElement提供配置，而RenderObjectElement包含着（wrap）RenderObject，RenderObject则是在应用中提供实际的绘制（rendering）的元素。
*
*
* 属性解析:
* padding：padding的类型为EdgeInsetsGeometry，EdgeInsetsGeometry是EdgeInsets以及EdgeInsetsDirectional的基类。
* 在实际使用中不涉及到国际化，例如适配阿拉伯地区等，一般都是使用EdgeInsets。
* EdgeInsetsDirectional光看命名就知道跟方向相关，因此它的四个边距不限定上下左右，而是根据方向来定的。
*
*/




