import 'dart:core';

/// 应用程序的入口：main 函数【重要】
///
/// 类，构造函数，命名构造函数，重定向构造函数，继承，重写，set/get static -重要

void main() {
  print("====================== 类 class ====================");

  /*
  * 面向对象编程：将对象定义为“具有已定义边界的任何实体”。
  *
  * 对象具有以下内容：
  * 状态 - 描述对象，类的字段表示对象的状态。
  * 行为 - 描述对象可以执行的操作。
  * 标识 - 将对象与一组类似的其他对象区分开的唯一值。两个或多个对象可以共享状态和行为，但不能共享身份。
  * 句点运算符(.)与对象一起使用以访问类的数据成员。
  * */

  Student s1 = Student.data("tiankun", 30);
  print(s1.getName()); //tiankun
  print(s1.studName); //tiankun
  print(s1.name); //tiankun
  print(s1.age); //30

  s1.setName("zhonguo");
  print(s1.getName()); //zhonguo
  print(s1.studName); //zhonguo
  print(s1.name); //zhonguo

  s1.studName = 'Maxsu';
  print(s1.getName()); //Maxsu
  print(s1.studName); //Maxsu
  print(s1.name); //Maxsu

  Student1 student1 = Student1("tiankun", 45);
  student1.setName("woshi Student1");
  student1.studName = "woshi Student1 Student1";
  print(student1.studName); //woshi Student1 Student1test
  print(student1.age); //45

  //static 静态成员：属性，方法， 子类无法继承
  Student.numK = 888;
  Student.getNumK();
}

/*
* 构造函数: 是类的特殊函数，负责初始化类的变量。
*
* Dart定义了一个与该类名称相同的构造函数。构造函数是一个函数，因此可以参数化。
* 但是与函数不同，构造函数不能具有返回类型。如果未声明构造函数，则它会提供默认的无参数构造函数。
*/
class Student {
  String name;
  int age;
  int score;

  // static关键字可以应用于类的数据成员，即字段和方法。
  // 静态变量保留其值，直到程序完成执行。静态成员由类名引用。
  static int numK;

  static getNumK() {
    print("The value of num is ${Student.numK}");
  }

  // 主构造函数 - 两种写法：
//  Student(String name, int age){
//    this.name = name;
//    this.age = age;
//  }
  Student(String name, int age) : this.name = name, this.age = age;

  //命名构造函数
  Student.name(String name) {
    // this关键字引用类的当前实例。这里，参数名称和类字段的名称是相同的。
    // 因此，为了避免歧义，类的字段以this关键字为前缀。
    this.name = name;
  }

  //dart 支持新的语法：
  Student.score(int score) : this.score = score, age = 20;

  // 重定向构造函数：指向主构造函数，函数体为空
  // 貌似swift中的便利构造函数，但略有不同
  Student.alongXAxis(num x) : this("", x);

  Student.data(String name, int age) {
    this.name = name;
    this.age = age;
  }

  // set get 的不同写法
  String get studName {
    return name;
  }

  String getName() {
    return name;
  }

  setName(String name) {
    this.name = name;
  }

  set studName(String name) {
    this.name = name;
  }
}

/*
* Dart支持继承的概念：
*
* 它是程序从现有类创建新类的能力。
* 扩展为创建较新类的类称为父类/超类。新创建的类称为子/子类。
* 一个类使用extends关键字从另一个类继承。子类继承除父类的构造函数之外的所有属性和方法。
*
* 注 - Dart不支持多重继承。
*
* 子类不会继承父类的无名有参构造函数和命名构造函数(即子类只能继承父类无名、无参数的构造函数)
* 父类构造函数会在子类的构造函数前调用
* 默认情况下，子类只能调用父类的无名、无参数的构造函数
*
* 如果父类不显示提供无名无参的构造函数，在子类中必须手动调用父类的一个构造函数。这种情况下，
* 调用父类的构造函数的代码放在子类构造函数名后，子类构造函数体前，中间使用 : 分隔
*/
class Student1 extends Student {
  var num;

  // 思考：子类不能继承父类所有的构造函数，又不能灵活创建自己的构造函数，这点不方便。
  Student1(String name, int age) : super(name, age);

  Student1.name(String name) : super.name(name);

  Student1.num(num) : super('', 0) {
    this.num = num;
  }

  /*
  * 方法重写是子类在其父类中重新定义方法的机制。
  * */
  @override
  setName(String name) {
    name = name + "sub";
    super.setName(name);
  }

  @override
  String get studName => super.studName;

  @override
  set studName(String name) {
    name = name + "test";
    super.studName = name;
  }
}

// 箭头函数 语法
bool isNoble(int atomicNumber) => List() != null || [1, 2, 3] != null;

bool isNoble2(int atomicNumber) {
  return List() != null || [1, 2, 3] != null;
}

/// 常值实例创建方法  静态构造函数(单例)
/// 如果想要让类产生一个永远不会改变的对象，可以让这些对象成为编译时常量。
/// 为此，需要定义一个 const 构造函数并确保所有的实例变量都是 final 的.
class ImmTablePoint {

  /// 如果调用参数一致，创建出的实例也是同一个（内存地址相同）。
  ///
  /// 1,类似于swift中单例的初始化方法。
  /// 2,static final修饰的shared是静态的地址不可修改的实例变量.
  /// 3,const ImmtablePoint(0,0) 表示初始化一个为常值的实例。
  /// 4,shared变量是一个地址不可修改且内容为常值的ImmtablePoint类的实例。
  /// 5,由于需要构造一个内容不可修改的实例，所以构造函数也需要被const修饰。
  /// 6,常量构造函数内容不可修改则实例变量也不可修改，则实例变量也需要final来修饰。

  static final shared = const ImmTablePoint(0, 0);
  final num a, b;
  const ImmTablePoint(this.a, this.b);
}

/// 抽象类
abstract class Doer {
  // 抽象类，方法无需实现
  void doSomething();
}

class EffDoer extends Doer {
  // 1，指定抽象类拓展。
  // 2，拓展后需实现抽象类中的方法。
  @override
  void doSomething() {
    print('doSomething');
  }
}

/// 操作符覆盖 operator
class Vector {
  final int x, y;
  Vector(this.x, this.y);

  // 1. +，-操作覆盖
  // 2. operator关键词
  Vector operator +(Vector v) => Vector(x + v.x, y + v.y);
  Vector operator -(Vector v) => Vector(x - v.x, y - v.y);

  // 1. 覆盖==符号，必须也好覆盖hashCode方法
  @override
  int get hashCode {
    int res = 1;
    res = res + x.hashCode;
    res = res + y.hashCode;
    return res;
  }

  @override
  bool operator ==(dynamic other) {
    if (other is! Vector) return false;
    Vector newObj = other;
    return (newObj.x == x && newObj.y == y);
  }
}
