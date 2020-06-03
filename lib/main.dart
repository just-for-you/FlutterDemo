import 'dart:io';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

void main() => runApp(MyApp2());

//原始网络请求，繁琐不方便，网上有很多关于网络请求的封装
//参考：https://flutterchina.club/networking/
void getDataByHttpClient() async {

  //1.创建 client.
  //2.构造 Uri.
  //3.发起请求, 等待请求，同时您也可以配置请求headers、 body.
  //4.关闭请求, 等待响应.
  //5.解码响应的内容.

  //接口地址
  const url = "http://www.easy-mock.com/mock/5d4a9adec10f57576cca530f/example/localtest";
  //const url = "http://apimanage.58corp.com/mock/5e7ea1517115d60305523abf";
  //const url = "https://huangyeapi.58.com/app/api/productDetail/";
  var httpClient = HttpClient();
  try {
    print(url);
    var request = await httpClient.getUrl(Uri.parse(url));
    var response = await request.close();
    print("==========================statusCode===========================");
    print(response.statusCode);
    if (response.statusCode == HttpStatus.ok) {
      print("===========ok");
      var responseBody = await response.transform(utf8.decoder).join();//返回值，字符串
      print(responseBody);
      //字符串需要转化为JSON
      var json = jsonDecode(responseBody);
      print("======================json===============================");
      print(json);

      int.parse("");
      double.parse("");
      12.toString();
      String piAsString = 3.14159.toStringAsFixed(2);
      assert(piAsString == '3.14');
    } else {
      print("===========not ok");
    }
  } catch(exception) {

  }

  //dio库
  try {
    Response response = await Dio().get(url);
    print("======================dio===============================");
    print(response.data.toString());
  } catch (e) {
    print(e);
  }
}


class MyApp2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Im Test in 58",
      home: RoutesPage(),
    );
  }
}

//路由页面
class RoutesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "routes page",
      //路由表定义
      routes: {
        "ListPage": (context) => ListPage(),
        "MyPage2": (context) => MyPage2(),
        "MyPage": (context) => MyPage(),
        "MyApp": (context) => MyApp(),
        "DetailPage": (context) => DetailPage(), //增加详情页的路由配置
        "TestPage": (context) => TestPage(),
      },
      home: MyRoutePage(),
    );
  }
}

class MyRoutePage extends StatefulWidget {
  @override
  MyRouteState createState() => MyRouteState();
}

class MyRouteState extends State {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Route test"),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            //凸起的按钮
            RaisedButton(
                child: Text("click to listpage"),
                onPressed: () {
                  //根据命名路由做跳转
                  Navigator.pushNamed(context, "ListPage");
                  getDataByHttpClient();
                }),
            RaisedButton(
                child: Text("click to TestPage"),
                onPressed: () {
                  //根据命名路由做跳转
                  Navigator.pushNamed(context, "TestPage");
                }),
            //扁平化按钮
            FlatButton(
                onPressed: () {
                  Navigator.pushNamed(context, "MyPage2");
                },
                child: Text("click to MyPage2")),
            //带边框按钮
            OutlineButton(
                child: Text("click to MyPage"),
                onPressed: () {
                  Navigator.pushNamed(context, "MyPage");
                }),
            //带图标按钮
            IconButton(
                icon: Icon(Icons.camera),
                onPressed: () {
                  Navigator.pushNamed(context, "MyApp");
                }),
            Image(
              image: NetworkImage(
                  "https://mat1.gtimg.com/pingjs/ext2020/qqindex2018/dist/img/qq_logo_2x.png"),
              width: 200.0,
            ),
            Image(
              image: AssetImage("images/star.jpg"),
              width: 150.0,
            ),
            Image.asset("images/avatar_circle.png", width: 100.0)
          ],
        ),
      ),
    );
  }
}

//页面ListPage
class ListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //定义列表widget的list
    List<Widget> list = <Widget>[];
    var data = [
      {"id": 1, "title": "测试数据AAA", "subtitle": "ASDFASDFASDF"},
      {"id": 2, "title": "测试数据bbb", "subtitle": "ASDFASDFASDF"},
      {"id": 3, "title": "测试数据ccc", "subtitle": "ASDFASDFASDF"},
    ];

    for (var item in data) {
      print(item["title"]);
      list.add(ListTile(
        title: Text(item["title"], style: TextStyle(fontSize: 18.0)),
        subtitle: Text(item["subtitle"]),
        leading: Icon(Icons.fastfood, color: Colors.orange),
        trailing: Icon(Icons.keyboard_arrow_right),
        onTap: () {
          //点击的时候，进行路由跳转传参
          Navigator.pushNamed(context, "DetailPage", arguments: item);
        },
      ));
    }

    return Scaffold(
        appBar: AppBar(
          title: Text("List Page"),
        ),
        body: Center(
          child: ListView(
            children: list,
          ),
        ));
  }
}

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

//测试页面有动画使用
class TestPage extends StatefulWidget {
  @override
  TestState createState() => TestState();
}

class TestState extends State<TestPage> with SingleTickerProviderStateMixin {
  Animation<double> animation;
  AnimationController controller;

  initState() {
    super.initState();
    controller =
        AnimationController(duration: Duration(seconds: 3), vsync: this);

    //使用弹性曲线，数据变化从0到300
    animation =
        CurvedAnimation(parent: controller, curve: Curves.fastOutSlowIn);
    animation = Tween(begin: 0.0, end: 300.0).animate(animation)
      ..addListener(() {
        setState(() {});
      });

    //启动动画(正向执行)
    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("test page"),
      ),
      //body: Row(//一排
      body: Column(
        //一列
        children: <Widget>[
          Text("我是1"),
          Text("我是2"),
          Container(
              color: Colors.blue,
              width: 150,
              height: 100,
              child: Align(
                alignment: Alignment.bottomRight,
                child: Text("Hello Align ",
                    style: TextStyle(fontSize: 20, color: Colors.white)),
              )),
          Image.asset("images/sea.png",
              width: animation.value, height: animation.value),
        ],
      ),
    );
  }

  @override
  void dispose() {
    //路由销毁时需要释放动画资源
    controller.dispose();
    super.dispose();
  }
}

//页面MyPage2 hello world with state with anim
class MyPage2 extends StatefulWidget {
  @override
  MyPageState createState() => MyPageState();
}

class MyPageState extends State<MyPage2> {
  var msg = "Hello World"; //msg默认文字
  bool _visible = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("我是Title"),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            //Animation: 保存动画的值和状态
            //AnimationController: 控制动画，包含：启动forward()、停止stop()、反向播放reverse()等方法
            //Tween: 提供begin，end作为动画变化的取值范围
            //Curve：设置动画使用曲线变化，如非匀速动画，先加速，后减速等的设定。
            AnimatedOpacity(
              opacity: _visible ? 1.0 : 0.0,
              duration: Duration(milliseconds: 1000),
              child: Image.asset("images/horse.jpg", width: 100),
            ),
            Text(msg), //根据变量显示文字
            FlatButton(
              color: Colors.blue,
              textColor: Colors.white,
              //点击按钮，修改msg的文字
              onPressed: () {
                setState(() {
                  this.msg = "you click mee too";
                  _visible = !_visible;
                });
                /*Navigator.push(context, MaterialPageRoute(
                  builder:(context){
                    return ListPage();
                  }
                ));*/
              },
              child: Text(
                "Click me",
                style: TextStyle(fontSize: 20.0),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

//页面MyPage  hello world
class MyPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("我是58"),
      ),
      body: Center(
        //child: Text("我是body"),
        child: Container(
            color: Colors.blue,
            width: 200,
            height: 200,
            padding: EdgeInsets.all(30),
            margin: EdgeInsets.only(left: 150, top: 0, right: 0, bottom: 0),
            child: Text("Hello Container ",
                style: TextStyle(fontSize: 20, color: Colors.white)),
            transform: Matrix4.rotationZ(0.2) //变形
            ),
      ),
    );
  }
}

//页面MyApp
class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Invoke "debug painting" (press "p" in the console, choose the
          // "Toggle Debug Paint" action from the Flutter Inspector in Android
          // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
          // to see the wireframe for each widget.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.display1,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
