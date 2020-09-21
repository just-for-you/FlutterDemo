
import 'package:FlutterDemo/state/BLoC/scoped/top_page.dart';
import 'package:flutter/material.dart';

import 'blocs/bloc_provider.dart';


class BlocScopedDemo extends StatelessWidget {

 @override
 Widget build(BuildContext context) {
   return BlocProvider(
     child: MaterialApp(
       title: 'scoped',
       theme: ThemeData.dark(),
       home: TopPage(),
     ),
   );
 }
}