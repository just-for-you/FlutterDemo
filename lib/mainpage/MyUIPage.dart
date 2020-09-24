import 'package:flutter/material.dart';
import '../DetailPage.dart';
import 'dart:io';

// UI 布局学习
class MyUIPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(32.0),
      child: Row(
        children: [
          // 将Column（列）放入Expanded中会拉伸该列以使用该行中的所有剩余空闲空间。
          Expanded(
            child: Column(
              // 设置crossAxisAlignment属性值为CrossAxisAlignment.start，这会将该列中的子项左对齐。
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  // 底部添加padding
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Text(
                    'Oeschinen Lake Campground',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Text(
                  'Kandersteg, Switzerland',
                  style: TextStyle(
                    color: Colors.grey[500],
                  ),
                ),
              ],
            ),
          ),
          Icon(
            Icons.star,
            color: Colors.red[500],
          ),
          Text('41'),
        ],
      ),
    );
  }
}

class ButtonUIPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    // 创建一个颜色为primary color，包含一个Icon和Text的 Widget 列
    Column buildButtonColumn(IconData icon, String label) {
      Color color = Theme.of(context).primaryColor;
      return Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: color),
          Container(
            margin: const EdgeInsets.only(top: 8.0),
            child: Text(
              label,
              style: TextStyle(
                fontSize: 12.0,
                fontWeight: FontWeight.w400,
                color: color,
              ),
            ),
          ),
        ],
      );
    }

    Widget buttonSection = Container(
      child: Row(
        // MainAxisAlignment.spaceEvenly 平均的分配每个列占据的行空间
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          buildButtonColumn(Icons.call, 'CALL'),
          buildButtonColumn(Icons.near_me, 'ROUTE'),
          buildButtonColumn(Icons.share, 'SHARE'),
        ],
      ),
    );

    return buttonSection;
  }
}


class TextUIApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Widget textSection = Container(
      padding: const EdgeInsets.all(32.0),
      child: Text(
        '''
Lake Oeschinen lies at the foot of the Blüemlisalp in the Bernese Alps. Situated 1,578 meters above sea level, it is one of the larger Alpine Lakes. A gondola ride from Kandersteg, followed by a half-hour walk through pastures and pine forest, leads you to the lake, which warms to 20 degrees Celsius in the summer. Activities enjoyed here include rowing, and riding the summer toboggan run.
        ''',
        softWrap: true,
      ),
    );

    return textSection;
  }
}


// 一行有3张图片，行对于其渲染框太宽，并且导致右边出现红色条中的问题，可以使用Expanded widget来包装每个widget。
// 默认情况下，每个widget的弹性系数为1，将行的三分之一分配给每个小部件。

// 也许你想要一个widget占据其兄弟widget两倍的空间。您可以将行或列的子项放置在Expandedwidget中， 以控制沿着主轴方向的widget大小。
// Expanded widget具有一个flex属性，它是一个整数，用于确定widget的弹性系数,默认弹性系数是1。
class ExpandedDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
        child: Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
      new Expanded(
        child: new Image.asset('images/avatar.png'),
      ),
      new Expanded(
        flex: 2,
        child: new Image.asset('images/avatar_circle.png'),
      ),
      new Expanded(
        child: new Image.asset('images/business_avatar.png'),
      )
    ]));
  }
}


class MainAxisDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    // 默认情况下，行或列沿着其主轴会尽可能占用尽可能多的空间，但如果要将孩子紧密聚集在一起，可以将mainAxisSize设置为MainAxisSize.min。
    // 以下示例使用此属性将星形图标聚集在一起（如果不聚集，五张星形图标会分散开）。
    var packedRow = Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        new Icon(Icons.star, color: Colors.green[500]),
        new Icon(Icons.star, color: Colors.green[500]),
        new Icon(Icons.star, color: Colors.green[500]),
        new Icon(Icons.star, color: Colors.black),
        new Icon(Icons.star, color: Colors.black),
      ],
    );

    return Center(child : packedRow);
  }
}


// 标准 widgets
// Container
// 添加 padding, margins, borders, background color, 或将其他装饰添加到widget.
// GridView
// 将 widgets 排列为可滚动的网格.
// ListView
// 将widget排列为可滚动列表
// Stack
// 将widget重叠在另一个widget之上.
// Material Components
// Card
// 将相关内容放到带圆角和投影的盒子中。
// ListTile
// 将最多3行文字，以及可选的行前和和行尾的图标排成一行
// ListTile是Material Components库中的一个专门的行级widget，用于创建包含最多3行文本和可选的行前和行尾图标的行。ListTile在Card或ListView中最常用，但也可以在别处使用。




