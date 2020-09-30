import 'package:FlutterDemo/demo/listView/gridview_demo.dart';
import 'package:FlutterDemo/demo/listView/listview_demo.dart';
import 'package:flutter/material.dart';



class MyListHomePage extends StatefulWidget {
  @override
  _MyListHomePageState createState() => new _MyListHomePageState();
}

class _MyListHomePageState extends State<MyListHomePage> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        centerTitle: true,
        title: new Text("ListView GridView Demo"),
      ),
      body: new Center(
        child: new Column(
          children: <Widget>[
            OutlineButton(
              onPressed: () {
                Navigator.push(
                    context,
                    new MaterialPageRoute(
                        builder: (context) => ListViewDemo()));
              },
              child: new Text("ListView code"),
              textColor: Colors.blue,
              highlightColor: Colors.yellow,
            ),
            OutlineButton(
              onPressed: () {
                Navigator.push(
                    context,
                    new MaterialPageRoute(
                        builder: (context) => new GridViewDemo()));
              },
              child: new Text("GridView code"),
              textColor: Colors.blue,
              highlightColor: Colors.yellow,
            ),
          ],
        ),
      ),
    );
  }
}