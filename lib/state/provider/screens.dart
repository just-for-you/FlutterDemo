import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'color_model.dart';
import 'counter_model.dart';
import 'goods_model.dart';
import 'order_provider.dart';


class FirstScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    print('first screen rebuild');
    // 获取顶层数据最简单的方法就是 Provider.of<T>(context);
    // 这里的范型 <T> 指定了获取 FirstScreen 向上寻找最近的储存了 T 的祖先节点的数据。
    final counter = Provider.of<CounterModel>(context);
    final textSize = Provider.of<int>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('First Page'),
      ),
      body: Center(
        child: Text(
          'Value: ${counter.value}',
          style: TextStyle(
            fontSize: textSize.toDouble(),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => SecondScreen())),
        child: Icon(Icons.navigate_next),
      ),
    );
  }
}



/// This is a single page provider,
/// it will be destroyed when the page is removed,
/// and the status will be reset.
///
/// Flutter tab页面切换默认不保留保留页面状态，这样的话每次点击 Tab 或左右滑动页面后都会触发重新构建渲染
/// 解决方案：
/// 子页面继承自 StatefulWidget
/// State 需要继承自 AutomaticKeepAliveClientMixin
/// 重写 get wantKeepAlive 方法，并返回 true


class SecondScreenProvider extends StatefulWidget {
  final Widget child;

  SecondScreenProvider({@required this.child});

  @override
  _SecondScreenProviderState createState() => _SecondScreenProviderState();
}

class _SecondScreenProviderState extends State<SecondScreenProvider> {
  ColorModel _colorModel = ColorModel();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: _colorModel,
      child: widget.child,
    );
  }
}

class SecondScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print('second screen rebuild');
    return SecondScreenProvider(
      child: DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: buildAppBar(),
          body: TabBarView(children: [
            buildCounterText(),
            showIconWithColor(),
            showIconWithColor(),
          ]),
          floatingActionButton: buildActionButtons(),
        ),
      ),
    );
  }


  // 另外一种获取状态的方式：使用Consumer获取祖先节点中的数据，将会影响你的 app performance
  // Consumer 非常有用，它的经典之处在于能够在复杂项目中，极大地缩小你的控件刷新范围。(局部刷新)
  // Provider.of<T>(context) 会导致调用的 context 页面范围的刷新，Consumer只刷新自己的部分
  //
  // Consumer 使用了 Builder 模式，收到更新通知就会通过 builder 重新构建。Consumer<T> 代表了它要获取哪一个祖先中的 Model。
  // Consumer 的 builder 实际上就是一个 Function，它接收三个参数 (BuildContext context, T model, Widget child)。
  //    context： context 就是 build 方法传进来的 BuildContext 在这里就不细说了
  //    T：获取到的最近一个祖先节点中的数据模型。
  //    child：它用来构建那些与 Model 无关的部分，在多次运行 builder 中，child 不会进行重建。
  Column buildActionButtons() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        Consumer<ColorModel>(
          builder: (context, ColorModel colorModel, child) {
            return FloatingActionButton(
              heroTag: 'no_hero',
              child: Icon(Icons.swap_horizontal_circle),
              onPressed: () {
                colorModel.changeColor();
              },
            );
          },
        ),
        SizedBox(height: 20),
        Consumer<CounterModel>(
          builder: (context, CounterModel counter, child) => FloatingActionButton(
            onPressed: () => counter.increment(),
            child: child,
          ),
          child: Icon(Icons.add),
        ),
      ],
    );
  }


  // Consumer2 范型改为了两个，能够同时获取两种model，最多支持6个
  Consumer2<CounterModel, int> buildCounterText() {
    // 消费者
    return Consumer2<CounterModel, int>(
      builder: (context, CounterModel counter, int textSize, child) {
        return Center(
          child: Text(
            'Value: ${counter.value}',
            style: TextStyle(
              fontSize: textSize.toDouble(),
            ),
          ),
        );
      },
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      title: Text('Second Page'),
      bottom: TabBar(tabs: [
        Tab(text: 'show counter'),
        Tab(text: 'show color'),
        Tab(text: 'show color'),
      ]),
    );
  }

  Container showIconWithColor() {
    return Container(
      alignment: Alignment.center,
      child: Consumer<ColorModel>(
        builder: (context, ColorModel colorModel, child) {
          return Icon(
            Icons.stars,
            color: colorModel.color,
            size: 100,
          );
        },
      ),
    );
  }
}




/*
* Selector 过滤刷新
* 在 Provider 3.1 版本中推出，进一步强化 Consumer 的功能
*
* Selector<A, S> 先来解释一下这里的 A 和 S。
* A 是我们从顶层获取的 Provider 的类型
* S 是我们关心的具体类型，也即是获取到的 Provider 中真正对我们有用的类型，需要在 selector 中返回该类型。这个 Selector 的刷新范围也从整个 Provider 变成了 S。
*
* 各个属性：
* selector：是一个 Function，入参会将我们获取的顶层 provider 传入，我们再返回具体关注的那部分 S。
* shouldRebuild：这个属性会储存 selector 过滤后的值，也就是 selector 返回的 S 并拿收到通知之后新的 S 与 cache 的 S 比较，来判断这个 Selector 是否需要刷新，默认 preview != next 就刷新。
* builder：这个就是具体返回 Widget 的地方了，第二个参数 provider，就是我们刚才 selector 中返回的 S。
* child：这个用于优化一些不用刷新的部分。
*
*/
class GoodsListScreen extends StatefulWidget {
  @override
  _GoodsListScreenState createState() => _GoodsListScreenState();
}

// AutomaticKeepAliveClientMixin能做到切换的时候保存UI状态
class _GoodsListScreenState extends State<GoodsListScreen> with AutomaticKeepAliveClientMixin {

  @override
  Widget build(BuildContext context) {
    print(('_GoodsListScreenState build'));

    return ChangeNotifierProvider(
      create: (_) => GoodsListProvider(),
      child: Scaffold(

        // 这里我的两个类型都是 GoodsListProvider 是因为我想要获取整个 Provider
        body: Selector<GoodsListProvider, GoodsListProvider>(
          shouldRebuild: (pre, next) => pre.shouldRebuild,//false 列表不会因notify而rebuild
          selector: (context, provider) => provider,
          builder: (context, provider, child) {
            provider.rebuild();
            return ListView.builder(
              itemCount: provider.total,
              itemBuilder: (context, index) {

                // 每一个商品我们希望它根据自己的状态进行刷新，所以这时候就需要再次使用 Selector 来获取我们真正关心的那个 Good。
                // 这个 Selector 的刷新范围就是 该商品
                // 思考：如果数据多可以滑动，滑动到顶部和底部时，边缘的item会rebuild，为啥？看Selector里面对比规则
                return Selector<GoodsListProvider, Goods>(
                  selector: (context, provider) => provider.goodsList[index],
                  builder: (context, data, child) {
                    print(('No.${index + 1} rebuild'));
                    return ListTile(
                      title: Text(data.goodsName),
                      trailing: GestureDetector(
                        onTap: () => provider.collect(index),
                        child: Icon(data.isCollection ? Icons.star : Icons.star_border),
                      ),
                    );
                  },
                );
              },
            );
          },
        ),
        floatingActionButton: Consumer<GoodsListProvider>(
          builder: (context, GoodsListProvider model, child) {
            return FloatingActionButton(
              child: Icon(Icons.add),
              onPressed: () {
                model.addAll();
              },
            );
          },
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;

}


class OrderListScreen extends StatefulWidget {
  @override
  _OrderListScreenState createState() => _OrderListScreenState();
}

class _OrderListScreenState extends State<OrderListScreen> {
  OrderProvider _provider = OrderProvider();

  @override
  Widget build(BuildContext context) {
    print(('_OrderListScreenState build'));

    return ChangeNotifierProvider.value(
      value: _provider,
      child: Scaffold(
        body: Selector<OrderProvider, List<Order>>(
          selector: (BuildContext _, OrderProvider provider) => provider.orderList,//整个列表做参考，为啥只有item刷新？看Selector对比规则
          builder: (BuildContext _, List<Order> orderList, Widget __) {
            return ListView.builder(
              itemCount: _provider.listSize,
              itemBuilder: (context, index) {
                return Selector<OrderProvider, Order>(
                  selector: (BuildContext _, OrderProvider provider) => provider.orderList[index],//刷新具体的item
                  builder: (BuildContext _, Order data, Widget __) {
                    print(('No.${index + 1} rebuild'));
                    return ListTile(
                      title: Text(data.goodsName),
                      trailing: GestureDetector(
                        onTap: () => _provider.collect(index),
                        child: Icon(data.isCollection ? Icons.star : Icons.star_border),
                      ),
                    );
                  },
                );
              },
            );
          },
        ),
        floatingActionButton: Consumer<OrderProvider>(
          builder: (BuildContext _, OrderProvider provider, Widget __) {
            return FloatingActionButton(
              child: Icon(Icons.add),
              onPressed: () {
                provider.addAll();
              },
            );
          },
        ),
      ),
    );
  }
}
