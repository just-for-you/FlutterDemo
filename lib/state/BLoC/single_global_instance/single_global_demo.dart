import 'package:FlutterDemo/state/BLoC/single_global_instance/top_page.dart';
import 'package:flutter/material.dart';


class SingleGlobalDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'single_global_instance',
      theme: ThemeData.dark(),
      home: TopPage(),
    );
  }
}