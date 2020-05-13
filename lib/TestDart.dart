import 'package:flutter/material.dart';
import 'DetailPage.dart';

// main()函数是Dart中的预定义方法。此方法充当应用程序的入口点。Dart脚本需要main()方法来执行。
void main() => runApp(DetailPage());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Im Test in 58",
      home: TestDart(),
    );
  }
}

class TestDart extends StatefulWidget {

  @override
  TestDartState createState() => TestDartState();
}

class TestDartState extends State<TestDart> {

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return null;
  }

}


