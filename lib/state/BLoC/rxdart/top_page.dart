import 'package:flutter/material.dart';

import 'blocs/count_bloc_impl.dart';
import 'under_page.dart';




class TopPage extends StatefulWidget {
  @override
  _TopPageState createState() => _TopPageState();
}

class _TopPageState extends State<TopPage> {

  // 创建顶层状态
  final bloc = CountBLoCImpl();

  @override
  void dispose() {
    //关流，不关闭流会消耗资源，引起内存泄漏
    bloc?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('BlocRxDartDemo'),
      ),
      body: Center(
        // 通过StreamBuilder建立联系
        child: StreamBuilder<int>(
            stream: bloc.stream,//监听stream
            initialData: bloc.value,//初始数据
            builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
              return Text(
                'You hit me: ${snapshot.data} times',
                style: Theme.of(context).textTheme.display1,
              );
            }),
      ),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.navigate_next),
          onPressed: () => Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => UnderPage(
                    bloc: bloc,
                  )))),
    );
  }
}
