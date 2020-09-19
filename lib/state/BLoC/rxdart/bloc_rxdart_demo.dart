
import 'package:FlutterDemo/state/BLoC/rxdart/top_page.dart';
import 'package:flutter/material.dart';

class BlocRxDartDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BlocRxDartDemo',
      theme: ThemeData.dark(),
      home: TopPage(),
    );
  }
}