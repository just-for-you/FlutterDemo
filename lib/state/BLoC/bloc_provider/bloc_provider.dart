import 'package:flutter/material.dart';
import 'count_page.dart';
import 'blocs/bloc_increment.dart';
import 'blocs/bloc_base.dart';

// Bloc + Provider
class BlocProviderDemo extends StatelessWidget {

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'BlocProviderDemo',
      theme: new ThemeData.dark(),

      //顶层BlocProvider包裹
      home: BlocProvider<IncrementBloc>(
        bloc: IncrementBloc(),//状态
        child: CounterPage(),//UI
      ),
    );
  }
}

