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