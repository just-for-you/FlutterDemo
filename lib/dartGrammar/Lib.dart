
import 'dart:math';

import 'Calculator.dart';
import 'LibHelp.dart' as logger;//使用as关键字指定前缀

/// 【Dart lib】库
/// 编程语言中的库表示例程集合(编程指令集)。Dart有一组内置库，可用于存储经常使用的例程。
/// Dart库包含一组类，常量，函数，typedef，属性和异常。
///
/// import 和 library 指令可以用来创建一个模块化的，可共享的代码库。
/// 库不仅提供了 API ，而且对代码起到了封装的作用： 以下划线 (_) 开头的标识符仅在库内可见。 每个 Dart 应用程序都是一个库 ，虽然没有使用 library 指令。
/// 库可以通过包来分发。https://www.dartcn.com/tools/pub/
///


void main() {

  /// 1.导入库
  // 导入使库中的组件可用于调用者代码。import关键字用于实现相同的目标。dart文件可以有多个import语句。
  //
  // 内置Dart库URI使用dart:scheme来引用库。其他库可以使用文件系统路径或package:scheme来指定其URI。包管理器(如pub工具)提供的库使用package:scheme。
  // import 'dart:io'
  // import 'package:lib1/libfile.dart'
  //
  /// 如果只想使用库的一部分，则可以有选择地导入库。语法如下所示 -
  // import 'package: lib1/lib1.dart' show foo, bar; //Import only foo and bar.
  // import 'package: mylib/mylib.dart' hide foo; //Import all names except foo
  //
  /// 常用库：
  // dart:io：服务器应用程序的文件，套接字，HTTP和其他I/O支持。此库在基于浏览器的应用程序中不起作用。默认情况下会导入此库。
  // dart:core：每个Dart程序的内置类型，集合和其他核心功能。默认情况下会导入此库。
  // dart:math：数学常数和函数，随机数生成器。
  // dart:convert：用于在不同数据表示之间进行转换的编码器和解码器，包括JSON和UTF-8。
  // dart:typed_data：有效处理固定大小数据的列表(例如，无符号8字节整数)。

  // 导入内置库dart:math，从math库中调用sqrt()函数：此函数返回传递给它的数字的平方根
  print("Square root of 36 is: ${sqrt(36)}"); //6.0

  /// 2.封装库
  /// Dart脚本可以使用下划线(_)为标识符添加前缀，以将其组件标记为私有。参考：DartLibHelp
  /// 简而言之，Dart库可以通过外部脚本限制对其内容的访问，它称为封装。
  // logger._log("hello from webloggerlib"); 定义了私有函数，无法正常调用
  logger.log("hello from webloggerlib");

  /// 3.创建自定义库 参考：calculator
  // Dart还可以将自己的代码用作为库，创建自定义库涉及以下步骤 -
  //
  /// 第1步：声明库
  // 要显式声明库，请使用库语句。声明库的语法如下所示 -
  // library library_name
  //
  /// 第2步：关联库
  // 可以通过两种方式关联库 -
  // 在同一目录中: import 'library_name'
  // 在不同的目录中: import 'dir/library_name'

  var num1 = 10;
  var num2 = 20;
  var sum = add(num1,num2);
  var mod = modulus(num1,num2);
  var r = random(10);
  print("$num1 + $num2 = $sum"); //10 + 20 = 30
  print("$num1 % $num2= $mod"); //10 % 20= 10
  print("random no $r"); //random no .

  /// 4.库前缀
  // 如果导入两个具有冲突标识符的库，则可以为一个或两个库指定前缀。使用as关键字指定前缀。
  // eg: import 'library_uri' as prefix
  logger.log("hello im DartLibHelp logger ======= ");


  /// 5.延迟加载库
  // Deferred loading (也称之为 lazy loading) 可以让应用在需要的时候再加载库。
  // 下面是一些使用延迟加载库的场景：
  // 1.减少 APP 的启动时间。
  // 2.执行 A/B 测试，例如 尝试各种算法的不同实现。
  // 3.加载很少使用的功能，例如可选的屏幕和对话框。

  // 要延迟加载一个库，需要先使用 deferred as 来导入：
  // import 'package:greetings/hello.dart' deferred as hello;
  // 当需要使用的时候，使用库标识符调用 loadLibrary() 函数来加载库：
  // Future greet() async {
  //  await hello.loadLibrary(); //使用 await 关键字暂停代码执行一直到库加载完成。
  //  hello.printGreeting();
  // }
  // 注：在一个库上你可以多次调用 loadLibrary() 函数。但是该库只是载入一次。
  // 使用延迟加载库的时候，请注意一下问题：
  // 延迟加载库的常量在导入的时候是不可用的。 只有当库加载完毕的时候，库中常量才可以使用。
  // 在导入文件的时候无法使用延迟库中的类型。 如果你需要使用类型，则考虑把接口类型移动到另外一个库中， 让两个库都分别导入这个接口库。
  // Dart 隐含的把 loadLibrary() 函数导入到使用 deferred as 的命名空间 中。 loadLibrary() 方法返回一个 Future。
  //

}
