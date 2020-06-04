import 'dart:core';
//import 'dart:mirrors'; 反射暂不支持

/// dart基础语法：数据类型 常用运算符 流程控制 函数 枚举
/// dart高阶语法：匿名函数，闭包函数，箭头函数，自执行函数，递归函数，回调函数【重要】
///
/// Dart是一种真正的面向对象的语言，所以即使是函数也是对象，并且有一个类型Function。
/// 这意味着函数可以赋值给变量或作为参数传递给其他函数，这是函数式编程的典型特征。

void main() {

  print("========================== 数据类型 ================");
  print("===== 数字 字符串 布尔 列表(类似于数组) 集合 映射 符文(用于表示字符串中的Unicode字符) 符号 =======");
  //1.数值型：数值型使用关键字num表示,它包含整型Int和浮点型double两种,它不同于其他的语言有多中数值类型,它只有整型和浮点型两种类型.
  // 运算符：+, -, * , /, ~/, %
  // 常用属性：
  //  isNaN是否是非数字, 源码e: static const double nan = 0.0 / 0.0;
  //  isEven是否是偶数
  //  isOdd是否是奇数
  // 常用的方法：
  //abs() //绝对值
  //round() // 四舍五入
  //floor() //舍去小数点之后的整数
  //ceil() // 舍去小数点之后的整数+1
  //toInt() //转化成Int类型
  //toDouble() //转化成浮点型

  // String 转为 int
  var one = int.parse('1');
  assert(one == 1); //如果不相等会报异常

  // String 转为 double
  var onePointOne = double.parse('1.1');
  assert(onePointOne == 1.1);

  //多行字符串
  var s1 = '''
  You can create
  multi-line strings like this one.
  ''';
  print(s1);

  //在前面加上r来创建“原始”字符串
  var s2 = r'In a raw string, not even \n gets special treatment.';
  print(s2);

  // int 转为 String
  String oneAsString = 1.toString();
  assert(oneAsString == '1');

  // double 转为 String
  String piAsString = 3.14159.toStringAsFixed(2);
  assert(piAsString == '3.14');

  //int 默认null 而不是0
  int num11;
  print(num11); // 输出：null

  //常量 ： final & const
  final val1 = 12;
  print(val1); // 输出：12

  const pi = 3.14;
  const area = pi * 12 * 12;
  print("The output is $area"); // 输出： 452.15999999999997

  /// 【列表类型】
  /// Dart中，数组是List对象，因此大多数人将它称为列表
  var list = [1, 2, 3];
  assert(list.length == 3);
  assert(list[1] == 2);
  list[1] = 1;
  assert(list[1] == 1);
  //编译时常量的列表，请在列表文字之前添加const：
  var constantList = const [1, 2, 3];
  print(constantList);

  /// 【集合】
  /// Dart中的Set是无序的唯一项的集合。
  /// Dart支持由Set文字和Set类型提供的集合。
  var halogens = {'yiibai.com', 'chlorine', 'bromine', 'iodine', 'astatine'};
  // 要创建一个空集合，请使用前面带有类型参数的{}，或者将{}赋给类型为Set的变量：
  var names = <String>{};
  Set<String> names2 = {};
  // 使用add()或addAll()方法将项添加到现有集合：
  var elements = <String>{};
  elements.add('fluorine');
  elements.addAll(halogens);
  // 要创建一个编译时常量的集合，请在set文字之前添加const：
  final constantSet = const {
    'fluorine',
    'chlorine',
    'bromine',
    'iodine',
    'astatine',
  };
  print(constantSet);

  /// 【映射】
  /// 通常映射是关联键和值的对象，键和值都可以是任何类型的对象。
  /// 每个键只出现一次，但可以多次使用相同的值。
  /// Dart支持由映射文字和Map类型提供的映射，比较推荐映射文字方式

  var gifts = {
    // Key:    Value
    'first': 'partridge',
    'second': 'turtledoves',
    'fifth': 'golden rings'
  };
  var nobleGases = {
    2: 'helium',
    10: 'neon',
    18: 'argon',
  };

  //可使用Map构造函数创建相同的对象：
  var gifts3 = Map();
  gifts3['first'] = 'partridge';
  gifts3['second'] = 'turtledoves';
  gifts3['fifth'] = 'golden rings';

  var nobleGases3 = Map();
  nobleGases3[2] = 'helium';
  nobleGases3[10] = 'neon';
  nobleGases3[18] = 'argon';


  print("========================== 常用运算符 ================");
  // is 用于判断变量是否是指定的数据类型
  // is! 含义是 is 取反
  var strValue = "leavesC";
  print(strValue is String); //true
  print(strValue is int); //false
  print(strValue is! String); //false

  // ~/ 用于除法运算时取整，/ 则不取整
  print(10 / 3); //3.3333333333333335
  print(10 ~/ 3); //3

  // as 用于强制类型转换  不同类型不能强制转化
  num numValue3 = 10.5;
  print('The type of a is ${numValue3.runtimeType}'); //double
  num numValue = 10;
  print('The type of a is ${numValue.runtimeType}'); //int
  int intValue = numValue as int;
  print(intValue);
  // 可以使用 Object 的 runtimeType 属性来判断实例 的类型，该属性返回一个 Type 对象。
  print('The type of a is ${numValue.runtimeType}'); //int

  // 如果 ??= 左边的变量值为 null ,则将其赋值为右边的值
  var name;
  var age = 25;
  name ??= "leavesC";
  age ??= 30;
  print("name：$name"); //name：leavesC
  print("age: $age"); //age: 25

  // 如果 ?. 左边的变量值不为 null，则右边的操作生效
  // 用于避免发生空指针异常
  var areaT;
  print(areaT?.runtimeType); //null
  var nameK = "tiankun";
  print(nameK?.runtimeType); //String

  /// 【拓展运算符】
  // Dart 2.3引入了扩展运算符(...)和空值感知扩展运算符(...?)，它提供了一种将多个元素插入集合的简洁方法。
  var list5 = [1, 2, 3];
  var list6 = [0, ...list5]; //[0, 1, 2, 3]
  assert(list6.length == 4);
  // 如果 list 可能为 null，此时则需要使用空值感知扩展运算符，否则会抛出异常
  // 空值感知扩展运算符只有当 list 不为 null 时才会执行插值操作
  var list9;
  var list10 = [0, ...?list9];
  print(list10); //[0]

  /// 【位运算符】
  // 为什么HashMap一定要将容量设置为2的指数呢？
  // 原因：对于一个整数n，如果它为2的指数，那么对于任意正整数h，都有 h % n = h & (n - 1)，
  // 基于这个性质，就可以使用位运算代替取模运算，在很大程度上提升性能。
  var a = 2; // Bit presentation 10
  var b = 3; // Bit presentation 11
  var result = (a & b);
  print("(a & b) => $result"); //0
  result = (a | b);
  print("(a | b) => $result"); //3
  result = (a ^ b);
  print("(a ^ b) => $result"); //1
  result = (~b);
  print("(~b) => $result"); //-4

  var result2 = (a < b);
  print("(a < b) => $result2"); //true
  result2 = (a > b);
  print("(a > b) => $result2"); //false

  print("========================== 流程控制 ================");
  // 使用标签来控制循环流程
  outerLooper: // This is the label name
  for (var i = 0; i < 5; i++) {
    print("Innerloop: $i");
    innerLooper:
    for (var j = 0; j < 5; j++) {
      if (j > 3) break;
      // Quit the innermost loop
      if (i == 2) break innerLooper;
      // Do the same thing
      if (i == 4) break outerLooper;
      // Quit the outer loop
      print("Innerloop: $j");
    }
  }

  outerLooper2: // This is the label name
  for (var i = 0; i < 3; i++) {
    print("Outerloop:$i");
    for (var j = 0; j < 5; j++) {
      if (j == 3) {
        continue outerLooper2;
      }
      print("Innerloop:$j");
    }
  }

  //返回此字符串的UTF-16代码单元的不可修改列表 [72, 101, 108, 108, 111]
  String str = "Hello";
  print(str.codeUnits);

  // 集合映射
  var details = new Map();
  details['Usrname'] = 'admin';
  details['Password'] = 'mypasswd';
  print(details);
  details.forEach((k, v) => print('$k: $v'));

  //String.runes属性：返回此字符串的可迭代Unicode代码点，Runes可迭代扩展。
  "Maxsu".runes.forEach((int rune) {
    var character = new String.fromCharCode(rune);
    print(character);
  });

  /// 【枚举】
  print(Status.values);
  Status.values.forEach((v) => print('value: $v, index: ${v.index}'));
  print('running: ${Status.running}, ${Status.running.index}');
  print('running values[1]: ${Status.values[1]}');

  print("========================== 函数 ================");
  /// 可选位置参数
  testParam(123456789);

  /// 可选的命名参数
  testParam2(123);
  testParam2(123, s2: 'hello');
  testParam2(123, s2: 'hello', s1: 'world');

  /// 带有默认值的可选参数
  testParam3("tiankun");
  testParam3(66666);
  testParam3(66666, s1: 'world');
  testParam3("tiankun", s1: 555);

  /// 方法当做参数调用
  function2(function1);

  /// 匿名函数
  var func = (int a) {
    print("anonymous fun");
    return a + 1;
  };
  print(func(5));
  anonymousFunction("kkkk");

  /// 匿名方法传参
  var listK = ['h', 'e', 'l', 'l', 'o'];
  print(listTimes(listK, (str) {
    return str * 3;
  }));

  /// 自执行函数
  // ignore: unnecessary_statements
  ((x, y) {
    print("$x -- $y");
  }(3, 5));

  /// 箭头函数（Lambda）
  printMsg();
  print(test());
  List listR = ['apple', 'pear', 'banana']; //数组，列表
  List list2 = List();
  listR.forEach((value) => print(value));
  listR.forEach((value) => list2.add(value));
  print(list2);

  /// 递归函数
  print(factorial(6));

  /// 闭包函数
  var myFunctionB = myFunction(5);
  for (var i = 0; i < 5; i++) {
    // 执行闭包
    myFunctionB();
  }
  var funcB = bb();
  for (var i = 0; i < 5; i++) {
    // 执行闭包
    funcB();
  }

  /// 构造函数 & 命名构造函数
  ConsolePrinter cp = ConsolePrinter(null);
  cp.printData();
  cp.printData2();

  ConsolePrinter cp1 = ConsolePrinter("toshi =======");
  cp1.printData();
  cp1.printData2();

  ConsolePrinter cp2 = ConsolePrinter.namedConst("tiankun");
  cp2.printData();
}

enum Status { none, running, stopped, paused }

//=============================  函数 ============================
/// 【可选参数：】
/// 1.可选的位置参数
/// 2.可选的命名参数
/// 3.默认可选参数

/// 1.可选位置参数: 要指定可选的位置参数，请使用方括号[]，如果未传递可选参数值，则将其设置为NULL
void testParam(n1, [s1]) {
  print(n1);
  print(s1);
}

/// 2.可选命名参数: 与位置参数不同，必须在传递值时指定参数的名称。花括号{}可用于指定可选的命名参数。
void testParam2(n1, {s1, s2}) {
  print(n1);
  print(s1);
  print(s2);
}

/// 3.默认可选参数（默认位置，命名），还可以为函数参数指定值。但是，这些参数也可以显式传递值。
void testParam3(n1, {s1: 12}) {
  print(n1);
  print(s1);
}

/// 4.内置函数：
ss() {
  print("     这也是一个内置函数".trim());
}

/// 5.自定义函数（普通函数）：有返回值（有参，无参）；无返回值（有参，无参）

/// 6.方法当做参数调用
//(1)先定义了一个function1的方法 输出一句话
void function1() {
  print("function1");
}

//(2)又定义了一个function2的方法 调用function1的方法
void function2(function1) {
  function1();
}
//(3)调用function2的方法 将function1的方法当做参数传进去
//function2(function1);

/// 7.匿名函数(有参，无参)
// ignore: top_level_function_literal_block
var anonymousFunction = (String name) {
  print("This is anonymousFunction $name");
};
//匿名函数传参
List listTimes(List list, String times(str)) {
  for (var i = 0; i < list.length; i++) {
    list[i] = times(list[i]);
  }
  return list;
}

/*
 * 8.自执行函数（匿名函数的一种）：即定义和调用合为一体，通过()进行调用，不推荐使用。
 * 我们创建了一个匿名的函数，并立即执行它，由于外部无法引用它内部的变量，
 * 因此在执行完后很快就会被释放，关键是这种机制不会污染全局对象。
 */
//(function () { /* code */ } ()) // 推荐使用这个
//(function () { /* code */ })() // 但是这个也是可以用的

/*
 * 9.箭头函数 类似于java8的Lambda表达式
 * Lambda函数是表示函数的简洁机制。这些函数也称为箭头函数。
 * 如果函数只包含一个表达式，则可以使用简写语法
 */
printMsg() => print("hello");

int test() => 123;

/*
 * 10.递归函数:
 * 一种通过对函数自身重复调用直到它到达结果来迭代操作的技术。
 * 当需要使用循环内的不同参数重复调用相同的函数时，最好应用递归。
 */
factorial(number) {
  if (number <= 0) {
    // termination case
    return 1;
  } else {
    return (number * factorial(number - 1));
    // function invokes itself
  }
}

/*
* 11.闭包函数：在方法体内再定义一个方法，不会污染全局，而且变量常驻内存。
* 又叫嵌套函数或者内嵌函数。内部函数会调用外部函数的变量或参数，变量或参数不会被系统回收。
* 写法：函数嵌套函数，并return内嵌函数，从而形成闭包效果。
*
* 理解：变量作用域，常用场景
* 闭包是将函数内部和函数外部连接起来的桥梁
* 注意点：
* 1.由于闭包会使得函数中的变量都被保存在内存中，内存消耗很大，所以不能滥用闭包，否则会造成网页的性能问题，在IE中可能导致内存泄露。
* 解决方法是，在退出函数之前，将不使用的局部变量全部删除。
* 2.闭包会在父函数外部，改变父函数内部变量的值。所以，如果你把父函数当作对象（object）使用，
* 把闭包当作它的公用方法（Public Method），把内部变量当作它的私有属性（private value），这时一定要小心，不要随便改变父函数内部变量的值。
* 3.闭包和回调函数时是两个概念，不是同一个概念。iOS中也有闭包block，而且block也能回调，但是闭包和回调函数是不同的概念。
*/
myFunction(var numb) {
  return () {
    numb++;
    print(numb);
  };
}

bb() {
  int count = 22;
  // 将闭包返回
  return () {
    print(--count);
  };
}

/*
* 12.回调函数
*/

//=============================  函数 ============================

class Printer {
  void printData() {
    print("------------printing data ================");
  }
}

class Printer2 {
  void printData2() {
    print("------------printing data2 ================");
  }
}

//实现多个接口
class ConsolePrinter implements Printer, Printer2 {
  var data;
  var a;

  //普通构造函数
  ConsolePrinter(String data) {
    this.data = data;
  }

  // 这里不能重载，通过命名构造函数多样化
//  ConsolePrinter(int a, int b) {
//    this.a = a;
//  }

  // 命名构造函数：用于方便调用者生成不同用途或含义的变量
  // 我理解为了满足java重载构造函数，构造不同的对象
  ConsolePrinter.namedNum(int a, int b) {
    print("The namedConst name is : $a");
  }

  //命名构造函数：是在初始化时可直接使用类调用。
  //构造函数不能继承！如果想用父类中的命名构造函数创建一个子类，那你也必须在子类中实现这个命名构造函数！
  ConsolePrinter.namedConst(String name) {
    print("The namedConst name is : $name");
  }

  // 重定向构造函数:alongXPrinter函数被重定向到ConsolePrinter执行构造处理
  ConsolePrinter.rXPrinter(String x) : this(x);

  @override
  void printData() {
    //三目运算符
    print((data != null)
        ? data
        : "------------printing console data ================");
  }

  @override
  void printData2() {
    print((data != null)
        ? data
        : "------------printing console data2 ================");
  }
}
