import 'package:flutter/material.dart';


// view变换
class TransformPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("我是58"),
      ),
      body: Center(
        //child: Text("我是body"),
        child: Container(
            color: Colors.blue,
            width: 200,
            height: 200,
            padding: EdgeInsets.all(30),
            margin: EdgeInsets.only(left: 150, top: 0, right: 0, bottom: 0),
            child: Text("Hello Container ",
                style: TextStyle(fontSize: 20, color: Colors.white)),
            transform: Matrix4.rotationZ(0.2) //变形
        ),
      ),
    );
  }
}