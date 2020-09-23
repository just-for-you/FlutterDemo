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

