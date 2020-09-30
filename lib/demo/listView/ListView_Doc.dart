import 'package:flutter/material.dart';



/*
* ListView是最常用的可滚动组件之一，它可以沿一个方向线性排布所有子组件，并且它也支持基于Sliver的延迟构建模型。
* https://blog.csdn.net/hao_m582/article/details/84112278
* */

/*
* 1.默认构造函数
*
* 直接返回最简单的列表结构，粗糙没有修饰。
*
* 效果等同于RN中的ScrollView组件,
* 但是这种方式创建的列表存在一个问题：对于那些长列表或者需要较昂贵渲染开销的子组件，
* 即使还没有出现在屏幕中但仍然会被ListView所创建，这将是一项较大的开销，使用不当可能引起性能问题甚至卡顿。
*
scrollDirection: 列表的滚动方向，可选值有Axis的horizontal和vertical，可以看到默认是垂直方向上滚动；
controller: 控制器，与列表滚动相关，比如监听列表的滚动事件；
physics: 列表滚动至边缘后继续拖动的物理效果，Android与iOS效果不同。Android会呈现出一个波纹状（对应ClampingScrollPhysics），而iOS上有一个回弹的弹性效果（对应BouncingScrollPhysics）。如果你想不同的平台上呈现各自的效果可以使用AlwaysScrollableScrollPhysics，它会根据不同平台自动选用各自的物理效果。如果你想禁用在边缘的拖动效果，那可以使用NeverScrollableScrollPhysics；
shrinkWrap: 该属性将决定列表的长度是否仅包裹其内容的长度。当ListView嵌在一个无限长的容器组件中时，shrinkWrap必须为true，否则Flutter会给出警告；
padding: 列表内边距；
itemExtent: 子元素长度。当列表中的每一项长度是固定的情况下可以指定该值，有助于提高列表的性能（因为它可以帮助ListView在未实际渲染子元素之前就计算出每一项元素的位置）；
cacheExtent: 预渲染区域长度，ListView会在其可视区域的两边留一个cacheExtent长度的区域作为预渲染区域（对于ListView.build或ListView.separated构造函数创建的列表，不在可视区域和预渲染区域内的子元素不会被创建或会被销毁）；
children: 容纳子元素的组件数组。
*
*
* 参考：calculator/main 137   lib/main 83
*
* 默认构造函数的用法非常之简单，直接把子元素组件放在children数组中就可以了,
* 潜在的问题前面也已经解释过，对于长列表这种应用场景还是应该用ListView.build构造函数性能会更好
* */



/*
* 2.ListTile
* Flutter 给我们准备好的widget 提供非常常见的构造和定义方式，包括文字，icon，点击事件，一般是能够满足基本需求，但是就不能自己定义了
* ListTile 属性
this.leading,              // item 前置图标
this.title,                // item 标题
this.subtitle,             // item 副标题
this.trailing,             // item 后置图标
this.isThreeLine = false,  // item 是否三行显示
this.dense,                // item 直观感受是整体大小
this.contentPadding,       // item 内容内边距
this.enabled = true,
this.onTap,                // item onTap 点击事件
this.onLongPress,          // item onLongPress 长按事件
this.selected = false,     // item 是否选中状态
* */



/*
* 3.ListView.builder()
*
* builder 顾名思义 构造 可以非常方便的构建我们自己定义的child布局，所以在Flutter中非常的常用。
*
* 多了两个新的参数：
* itemCount: 列表中元素的数量；
* itemBuilder: 子元素的渲染方法，允许自定义子元素组件（等同于rn中FlatList组件的renderItem属性）
* 不同于ListView默认构造函数通过children参数指定子元素的这种方式，ListView.build通过暴露统一的itemBuilder方法将渲染子元素的控制权交还给调用方。
*
* builder属性详细介绍
  //设置滑动方向 Axis.horizontal 水平  默认 Axis.vertical 垂直
  scrollDirection: Axis.vertical,
  //内间距
  padding: EdgeInsets.all(10.0),
  //是否倒序显示 默认正序 false  倒序true
  reverse: false,
  //false，如果内容不足，则用户无法滚动 而如果[primary]为true，它们总是可以尝试滚动。
  primary: true,
  //确定每一个item的高度 会让item加载更加高效
  itemExtent: 50.0,
  //内容适配
  shrinkWrap: true,
  //item 数量
  itemCount: list.length,
  //滑动类型设置
  physics: ClampingScrollPhysics(),
   //cacheExtent  设置预加载的区域
   cacheExtent: 30.0,
  //滑动监听
  controller
*
* shrinkWrap特别推荐：
* child 高度会适配 item填充的内容的高度,我们非常的不希望child的高度固定，因为这样的话，如果里面的内容超出就会造成布局的溢出。
* shrinkWrap多用于嵌套listView中 内容大小不确定 比如 垂直布局中 先后放入文字 listView （需要Expend包裹否则无法显示无穷大高度 但是需要确定listview高度 shrinkWrap使用内容适配不会有这样的影响）
*
* physics
这个属性几个滑动的选择
AlwaysScrollableScrollPhysics() 总是可以滑动
NeverScrollableScrollPhysics禁止滚动
BouncingScrollPhysics 内容超过一屏 上拉有回弹效果
ClampingScrollPhysics 包裹内容 不会有回弹
*
*
* cacheExtent
这个属性的意思就是预加载的区域
设置预加载的区域 cacheExtent 强制设置为了 0.0，从而关闭了“预加载”
*
* controller
滑动监听，我们多用于上拉加载更多，通过监听滑动的距离来执行操作。
*
* 问题：
* 正常的需求中大部分是需要item的分割线的，而在builder模式中使用divide 会有种情况（divide放在item的布局中 通过Column），我们会发现divide并没有直接延时到item两端而是会有左右padding。
* */




/*
* 4.ListView.separated()
*
* 绝大多数列表类的需求我们都可以用ListView.build构造函数来解决问题，不过有的列表子项之间需要分割线，此时我们可以用Flutter提供的另一个构造函数ListView.separated来创建列表。
* separated 有分离的意思，其实它就相当于我们Android中的多类型adapter，那么关键就是在我们的这个属性上separatorBuilder
*
* */



/*
* 5.custom（自定义SliverChildDelegate）
* ListView 内部是靠这个 childrenDelegate 属性动态初始化子元素的。
* 我们使用builder和separated比较多，这个custom相对来说就比较少了。
*
* */

///listView custom 构建
Widget listViewLayoutCustom(list) {
  // return ListView.custom(childrenDelegate: new MyChildrenDelegate());
  return ListView.custom(
    itemExtent: 40.0,
    childrenDelegate: MyChildrenDelegate((BuildContext context, int i) {
        return new Container(
            child: new Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                new Text(
                  "${list[i].name}",
                  style: new TextStyle(fontSize: 18.0, color: Colors.red),
                ),
                new Text(
                  "${list[i].age}",
                  style: new TextStyle(fontSize: 18.0, color: Colors.green),
                ),
                new Text(
                  "${list[i].content}",
                  style: new TextStyle(fontSize: 18.0, color: Colors.blue),
                ),
              ],
            ));
      },
      childCount: list.length,
    ),
    cacheExtent: 0.0,
  );
}


// ignore: slash_for_doc_comments
/**
 * 继承SliverChildBuilderDelegate  可以对列表的监听
 */
class MyChildrenDelegate extends SliverChildBuilderDelegate {
  MyChildrenDelegate(
      Widget Function(BuildContext, int) builder, {
        int childCount,
        bool addAutomaticKeepAlive = true,
        bool addRepaintBoundaries = true,
      }) : super(builder,
      childCount: childCount,
      addAutomaticKeepAlives: addAutomaticKeepAlive,
      addRepaintBoundaries: addRepaintBoundaries);

  ///监听 在可见的列表中 显示的第一个位置和最后一个位置
  @override
  void didFinishLayout(int firstIndex, int lastIndex) {
    print('firstIndex: $firstIndex, lastIndex: $lastIndex');
  }

  ///可不重写 重写不能为null  默认是true  添加进来的实例与之前的实例是否相同 相同返回true 反之false
  ///listView 暂时没有看到应用场景 源码中使用在 SliverFillViewport 中
  @override
  bool shouldRebuild(SliverChildBuilderDelegate oldDelegate) {
    print("oldDelegate$oldDelegate");
    return super.shouldRebuild(oldDelegate);
  }
}
