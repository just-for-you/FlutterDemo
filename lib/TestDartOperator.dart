


/// operator 操作运算符
/// https://www.jianshu.com/p/64a6ed7581aa
///一元后缀	expr++ expr-- () [] . ?.
///一元前缀	-expr ！expr ~expr ++expr --expr
///加减乘除	+ - * / % ~/
///位运算	<< >> & ^ |
///关系和类型测试 >= <= > < as is is!
///逻辑运算 && ||
///等式 == !=
///条件 expr1 ? expr2 : expr3
///级联	..
///赋值	= *= /= ~/= %= += -= <<= >>= &= ^= |= ??=


void main() {

  print("============= 操作符优先级 ===========");

// 1.使用括号来提高可读性
// if ((n % i == 0) && (d % i == 0))
// 2.难以阅读，但是和上面等价
// if (n % i == 0 && d % i == 0)
// 注：对于二元运算符，其左边的操作数将会决定使用的操作符的种类。例如，当你使用一个 Vector 对象以及一个 Point 对象时， aVector + aPoint 使用的 + 是由Vector 所定义的。

  print("============= 算术运算符 ===========");
  /// +	加
  /// -	减
  /// *	乘
  /// /	除
  /// ~/	返回一个整数值的除法
  /// %	取余，除法剩下的余数
  ///-expr	一元减号，也被命名为负号（使后面表达式的值反过来）
  assert(2 + 3 == 5);
  assert(2 - 3 == -1);
  assert(2 * 3 == 6);
  assert(5 / 2 == 2.5); // 结果是double类型
  assert(5 ~/ 2 == 2); // 结果是一个整数
  assert(5 % 2 == 1); // 余数
  assert('5/2 = ${5 ~/ 2} r ${5 % 2}' == '5/2 = 2 r 1');

  print("============= 前缀和后缀递增和递减运算符 ===========");
  ///++var	var=var+1表达式的值为var+1
  ///var++	var=var+1表达式的值为var
  /// --var	var=var-1表达式的值为var-1
  /// var--	var=var-1表达式的值为var
  var a, b;
  a = 0;
  b = ++a; // 在b获得其值之前自增a
  assert(a == b); // 1 == 1

  a = 0;
  b = a++; //在b获得值后自增a
  assert(a != b); // 1 != 0

  a = 0;
  b = --a; // 在b获得其值之前自减a
  assert(a == b); // -1 == -1

  a = 0;
  b = a--; // 在b获得值后自减a
  assert(a != b); // -1 != 0

  print("============= 等式和关系(比较)运算符 ===========");
  /// ==	等于
  /// !=	不等于
  /// >	大于
  /// <	小于
  /// >=	大于等于
  /// <=	小于等于

  // 要测试两个对象x和y是相等，请使用= =运算符。
  // 在极少数情况下，您需要知道两个对象是否是完全相同的对象，请改用experation()函数。
  // 以下是==运算符的工作原理:
  /*
   * 1.如果x或y为空，如果两者都为空，则返回true；如果只有一个为空，则返回false。
   * 2.返回一个函数调用的结果：x.==(y)。（这个调用是正确的，像==这样的运算符实际上是由第一个操作数所调用的一个方法。你可以重写大部分运算符。
   * */
  assert(2 == 2);
  assert(2 != 3);
  assert(3 > 2);
  assert(2 < 3);
  assert(3 >= 3);
  assert(2 <= 3);

  print("============= 类型测试操作符 ===========");
  ///as	类型转换
  ///is	当对象是相应类型时返回 true
  ///is!	当对象不是相应类型时返回 true

  //as、is 和 is! 操作符在运行时用于检查类型非常方便。
  //如果obj实现了T所定义的借口，那么obj is T将返回 true。比如，obj is Object必然返回 true。
  //使用as操作符可以把一个对象转换为特定类型。一般来说，如果在is测试之后还有一些关于对象的表达式，你可以把as当做是is测试的一种简写。
  num ss = 10;
  if (ss is int) { // Type check
    ss = 100;
  }

  num bb = 5.6;
  // ignore: unnecessary_statements
  bb as double;
  print(bb);

  print("============= 赋值操作符 & 复合赋值运算符===========");
  //如果 ??= 左边的变量值为 null ,则将其赋值为右边的值
  var name;
  var age = 25;
  name ??= "leavesC";
  age ??= 30;
  print("name：$name"); //name：leavesC
  print("age: $age"); //age: 25

  ///复合操作符：op  a op b 等同于 a = a op b （操作+赋值）
  /// -=	/=	%=	>>=	^= +=	*=	~/=	<<=	&=	|=
  var numA = 2; //赋值使用 =
  numA *= 3; // 赋值且相乘 a = a * 3
  assert(numA == 6);

  print("============= 逻辑运算符 ===========");
  /// !expr	反转以下表达式(将false更改为true，反之亦然)
  /// ||	逻辑或
  /// &&	逻辑与
  //可以使用逻辑运算符反转或组合布尔表达式。
  if (!(name is int) && (numA == 0 || numA == 6)) {
    //...Do something...
    print("逻辑运算符 ok ");
  }

  print("============= 位运算 ===========");
  /// &	与
  /// |	或
  /// ^	异或
  /// ~expr	一元位补码( 0s变为1s；1s变为0s )取反
  /// <<	左移
  /// >>	右移
  final value = 0x22;
  final bitmask = 0x0f;
  assert((value & bitmask)  == 0x02);  // 与
  assert((value & ~bitmask) == 0x20);  // 与非
  assert((value | bitmask)  == 0x2f);  // 或
  assert((value ^ bitmask)  == 0x2d);  // 异或
  assert((value << 4)       == 0x220); // 左移
  assert((value >> 4)       == 0x02);  // 右移
  var ak = 2;  // Bit presentation 10
  var bk = 3;  // Bit presentation 11
  var result = (ak & b);
  print("(ak & bk) => $result");//0
  result = (ak | bk);
  print("(ak | bk) => $result");//3
  result = (ak ^ bk);
  print("(ak ^ bk) => $result");//1
  result = (~bk);
  print("(~bk) => $result");//-4

  print("============= 条件表达式 ===========");
  /// 1.condition ? expr1 : expr2 (如果条件为真，返回expr1，否则返回expr2)
  /// 2.expr1 ?? expr2 (如果expr1为非空，则返回其值；否则，计算并返回expr2的值。)
  var visibility = (a == 0) ? 'public' : 'private';
  print(visibility);
  String playerName(String name) => name ?? 'Guest';
  print(playerName("tiankun"));
  print(playerName(null));

  // 稍微长一点的版本使用 ?: 操作符
  String playerName1(String name) => name != null ? name : 'Guest';

  // 非常长的使用if - else语句的版本
  String playerName2(String name) {
    if (name != null) {
      return name;
    } else {
      return 'Guest';
    }
  }

  print("============= 级联符号(..) ===========");
  // 级联(..)允许您对同一对象执行一系列操作。除了函数调用，您还可以访问同一对象上的字段。
  // 这通常会省去创建临时变量的步骤，并允许您编写更多的级联代码。

  //注意:严格来说，级联的“双点”符号不是运算符。这只是Dart语法的一部分。

  print("============= 其他操作符 ===========");
  /// ()	函数应用	表示函数调用
  /// []	列表访问	指列表中指定索引处的值
  /// .	  成员访问	指表达式的属性；示例: foo.bar从表达式foo中选择属性bar
  /// ?.	条件成员访问	跟.差不多,但是最左边的操作数可以为空；例子:foo?.bar从表达式foo中选择属性bar，除非foo为空(在这种情况下，foo?.bar值为空)


}

