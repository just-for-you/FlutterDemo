import 'package:flutter/material.dart';


class DetailPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //获取路由传参
    final Map args = ModalRoute.of(context).settings.arguments;

    return Scaffold(
        appBar: AppBar(
          title: Text("Detail Page"),
        ),
        body: Column(
          children: <Widget>[
            Text("我是Detail页面"),
            Text("id:${args['id']}"),
            Text("id:${args['title']}"),
            Text("id:${args['subtitle']}"),
            Stack(
              //支持元素堆叠
              children: <Widget>[
                Image.network(
                    "https://ossweb-img.qq.com/upload/adw/image/20191022/627bdf586e0de8a29d5a48b86700a790.jpeg"),
                Positioned(
                    top: 20,
                    right: 10,
                    child: Image.asset("images/road.jpg", width: 100.0))
              ],
            ),
            Flex(
              direction: Axis.horizontal,
              children: <Widget>[
                Container(
                  width: 30,
                  height: 100,
                  color: Colors.blue,
                ),
                Expanded(
                  flex: 1,
                  child: Container(
                    height: 100.0,
                    color: Colors.red,
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Container(
                    height: 100.0,
                    color: Colors.green,
                  ),
                ),
              ],
            )
          ],
        ));
  }
}