import 'package:flutter/material.dart';

//  行(Row)元素相互之间保持间距的几种方式
//  http://findsrc.com/flutter/detail/8830


/*
* 1.使用SizedBox保持固定间距
*/
getRow1() => Row(
  children: <Widget>[
    Text("1"),
    SizedBox(width: 50), // 50宽度
    Text("2"),
  ],
);


/*
* 2.使用Spacer填充尽可能大的空间
*/
getRow2() => Row(
  children: <Widget>[
    Text("1"),
    Spacer(), // use Spacer
    Text("2"),
  ],
);


/*
* 3.使用mainAxisAlignment对齐方式控制彼此间距
*/
getRow3() => Row(
  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  children: <Widget>[
    Text("1"),
    Text("2"),
  ],
);


/*
* 4.如果不用行的话，还可以使用Wrap并指定spacing
*/
getRow4() => Wrap(
  spacing: 200, // set spacing here
  children: <Widget>[
    Text("1"),
    Text("2"),
  ],
);


/*
* 5.同样是使用Wrap，设置spaceAround
*/
getRow5() => Wrap(
  alignment: WrapAlignment.spaceAround,
  children: <Widget>[
    Text("1"),
    Text("2"),
  ],
);
