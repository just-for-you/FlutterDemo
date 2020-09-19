import 'package:flutter/material.dart';

import 'blocs/bloc_base.dart';
import 'blocs/bloc_increment.dart';

class CounterPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    //获取Bloc状态对象
    final IncrementBloc bloc = BlocProvider.of<IncrementBloc>(context);

    return Scaffold(
      appBar: AppBar(title: Text('BlocProviderDemo')),
      body: Center(
        child: StreamBuilder<int>(
            stream: bloc.outCounter,//监听stream变化
            initialData: 0,
            builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
              return Text('You hit me: ${snapshot.data} times'); //构建UI界面
            }),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          bloc.incrementCounter();
        },
      ),
    );
  }
}