import 'package:flutter/material.dart';

// AnimPage with state with anim
class AnimPage extends StatefulWidget {
  @override
  MyPageState createState() => MyPageState();
}

class MyPageState extends State<AnimPage> {
  var msg = "Hello World"; //msg默认文字
  bool _visible = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("我是Title"),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            //Animation: 保存动画的值和状态
            //AnimationController: 控制动画，包含：启动forward()、停止stop()、反向播放reverse()等方法
            //Tween: 提供begin，end作为动画变化的取值范围
            //Curve：设置动画使用曲线变化，如非匀速动画，先加速，后减速等的设定。
            AnimatedOpacity(
              opacity: _visible ? 1.0 : 0.0,
              duration: Duration(milliseconds: 1000),
              child: Image.asset("images/horse.jpg", width: 100),
            ),
            Text(msg), //根据变量显示文字
            FlatButton(
              color: Colors.blue,
              textColor: Colors.white,
              //点击按钮，修改msg的文字
              onPressed: () {
                setState(() {
                  this.msg = "you click mee too";
                  _visible = !_visible;
                });
                /*Navigator.push(context, MaterialPageRoute(
                  builder:(context){
                    return ListPage();
                  }
                ));*/
              },
              child: Text(
                "Click me",
                style: TextStyle(fontSize: 20.0),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
