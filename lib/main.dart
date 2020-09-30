import 'package:FlutterDemo/demo/calculator/main.dart';
import 'package:FlutterDemo/demo/listView/main.dart';
import 'package:FlutterDemo/state/BLoC/bloc_provider/bloc_provider.dart';
import 'package:FlutterDemo/state/BLoC/single_global_instance/single_global_demo.dart';
import 'package:FlutterDemo/state/InheritedWidgetDemo.dart';
import 'package:FlutterDemo/state/StreamBuilderDemo.dart';
import 'package:FlutterDemo/state/scopedModel/scoped_model_demo.dart';
import 'package:flutter/material.dart';

import 'DetailPage.dart';
import 'demo/LoadAssetUtil.dart';
import 'mainpage/AnimPage.dart';
import 'mainpage/AnimPage2.dart';
import 'mainpage/IncCounterPage.dart';
import 'mainpage/ListPage.dart';
import 'mainpage/MyUIPage.dart';
import 'mainpage/TransformPage.dart';
import 'net/NetTest.dart';
import 'state/BLoC/rxdart/bloc_rxdart_demo.dart';
import 'state/BLoC/scoped/bloc_scoped_demo.dart';
import 'state/NotificationDemo.dart';

import 'package:flutter/rendering.dart';


void main() {
  // 开启界面绘制边界线，效果等同于Flutter Inspector中的DebugPaint，代码效果同步需要 hot restart
  debugPaintSizeEnabled = false;
  runApp(MainApp());
}


class MainApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Im Test in 58",
      home: RoutesPage(),
    );
  }
}

// 路由page
class RoutesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "routes page",
      routes: { //路由映射
        "ListPage": (context) => ListPage(),
        "AnimPage": (context) => AnimPage(),
        "AnimPage2": (context) => AnimPage2(),
        "TransformPage": (context) => TransformPage(),
        "IncCounterPage": (context) => IncCounterPage(),
        "DetailPage": (context) => DetailPage(), //增加详情页的路由配置
        "InheritedDemo": (context) => MyInheritedDemo(123456),
        "NotificationDemo": (context) => NotificationDemo(),
        "StreamBuilderDemo": (context) => StreamBuilderDemo(),
        "ScopedModelDemo": (context) => ScopedModelDemo(),
        "BlocProviderDemo": (context) => BlocProviderDemo(),
        "BlocRxDartDemo": (context) => BlocRxDartDemo(),
        "BlocScopedDemo": (context) => BlocScopedDemo(),
        "SingleGlobalDemo": (context) => SingleGlobalDemo(),
        "CalculatorDemo": (context) => CalculatorDemo(),
        "MyListHomePage": (context) => MyListHomePage(),
      },
      home: MyRoutePage(),
    );
  }
}

class MyRoutePage extends StatefulWidget {
  @override
  MyRouteState createState() => MyRouteState();
}

class MyRouteState extends State {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Route test"),
      ),
      body: Center(
        child: ListView(
          shrinkWrap: true,//这里无效果
          children: <Widget>[
            RaisedButton( //凸起的按钮
                child: Text("RaisedButton click to listpage"),
                onPressed: () {
                  Navigator.pushNamed(context, "ListPage"); //根据命名路由做跳转
                  getDataByHttpClient();
                }),
            RaisedButton(
                child: Text("RaisedButton click to AnimPage"),
                onPressed: () {
                  Navigator.pushNamed(context, "AnimPage");
                  loadContactsAsset().then((data) => print(data));
                }),
            FlatButton( //扁平化按钮
                onPressed: () {
                  Navigator.pushNamed(context, "AnimPage2");
                },
                child: Text("FlatButton click to AnimPage2")),
            OutlineButton( //带边框按钮
                child: Text("OutlineButton click to TransformPage"),
                onPressed: () {
                  Navigator.pushNamed(context, "TransformPage");
                }),
            Row(children: <Widget>[
              IconButton( //带图标按钮
                  icon: Icon(Icons.camera),
                  onPressed: () {
                    Navigator.pushNamed(context, "IncCounterPage");
                  }),
              Text("click to IncCounterPage"),
            ],),
            //状态管理demo
            OutlineButton(
                child: Text("click to InheritedDemo"),
                onPressed: () {
                  Navigator.pushNamed(context, "InheritedDemo");
                }),
            OutlineButton(
                child: Text("click to NotificationDemo"),
                onPressed: () {
                  Navigator.pushNamed(context, "NotificationDemo");
                }),
            OutlineButton(
                child: Text("click to StreamBuilderDemo"),
                onPressed: () {
                  Navigator.pushNamed(context, "StreamBuilderDemo");
                }),
            OutlineButton(
                child: Text("click to ScopedModelDemo"),
                onPressed: () {
                  Navigator.pushNamed(context, "ScopedModelDemo");
                }),
            OutlineButton(
                child: Text("click to BlocProviderDemo"),
                onPressed: () {
                  Navigator.pushNamed(context, "BlocProviderDemo");
                }),
            OutlineButton(
                child: Text("click to BlocRxDartDemo"),
                onPressed: () {
                  Navigator.pushNamed(context, "BlocRxDartDemo");
                }),
            OutlineButton(
                child: Text("click to BlocScopedDemo"),
                onPressed: () {
                  Navigator.pushNamed(context, "BlocScopedDemo");
                }),
            OutlineButton(
                child: Text("click to SingleGlobalDemo"),
                onPressed: () {
                  Navigator.pushNamed(context, "SingleGlobalDemo");
                }),
            OutlineButton(
                child: Text("click to CalculatorDemo"),
                onPressed: () {
                  Navigator.pushNamed(context, "CalculatorDemo");
                }),
            OutlineButton(
                child: Text("click to ListViewDemo"),
                onPressed: () {
                  Navigator.pushNamed(context, "MyListHomePage");
                }),

            // 加载图片&网络图片
            Image(image: NetworkImage("https://mat1.gtimg.com/pingjs/ext2020/qqindex2018/dist/img/qq_logo_2x.png"), width: 200.0,),
            Image(image: AssetImage("images/star.jpg"), width: 100.0,), // width属性没有效果？
            // BoxFit.cover 告诉框架，图像应该尽可能小，但覆盖整个渲染框
            Image.asset("images/avatar_circle.png", width: 100.0, height: 100.0, fit: BoxFit.contain, color: Colors.greenAccent,
              colorBlendMode: BlendMode.colorBurn,),
            MyUIPage(),
            ButtonUIPage(),
            TextUIApp(),
            ExpandedDemo(),
            MainAxisDemo()
          ],
        ),
      ),
    );
  }
}
