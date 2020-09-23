import 'package:flutter/material.dart';


//测试页面有动画使用
class AnimPage2 extends StatefulWidget {
  @override
  TestState createState() => TestState();
}

class TestState extends State<AnimPage2> with SingleTickerProviderStateMixin {
  Animation<double> animation;
  AnimationController controller;

  initState() {
    super.initState();
    controller =
        AnimationController(duration: Duration(seconds: 3), vsync: this);

    //使用弹性曲线，数据变化从0到300
    animation =
        CurvedAnimation(parent: controller, curve: Curves.fastOutSlowIn);
    animation = Tween(begin: 0.0, end: 300.0).animate(animation)
      ..addListener(() {
        setState(() {});
      });

    //启动动画(正向执行)
    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("test page"),
      ),
      //body: Row(//一排
      body: Column(
        //一列
        children: <Widget>[
          Text("我是1"),
          Text("我是2"),
          Container(
              color: Colors.blue,
              width: 150,
              height: 100,
              child: Align(
                alignment: Alignment.bottomRight,
                child: Text("Hello Align ",
                    style: TextStyle(fontSize: 20, color: Colors.white)),
              )),
          Image.asset("images/sea.png",
              width: animation.value, height: animation.value),
        ],
      ),
    );
  }

  @override
  void dispose() {
    //路由销毁时需要释放动画资源
    controller.dispose();
    super.dispose();
  }
}


