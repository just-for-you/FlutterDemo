import 'package:flutter/material.dart';
import 'DetailPage.dart';
import 'dart:io';

void main() => runApp(DetailPage());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    if (Platform.isIOS) {

    }

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


