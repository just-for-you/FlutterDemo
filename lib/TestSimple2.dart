
/*
编程语言并不是孤立存在的，Dart也是这样，他由语言规范、虚拟机、类库和工具等组成：
1.SDK：SDK 包含 Dart VM、dart2js、Pub、库和工具。
2.Dartium：内嵌 Dart VM 的 Chromium ，可以在浏览器中直接执行 dart 代码。
3.Dart2js：将 Dart 代码编译为 JavaScript 的工具。
4.Dart Editor：Studio全功能 IDE，并包含以上所有工具。支持代码补全、代码导航、快速修正、重构、调试等功能。
* */


/*
Dart 的特点：
1.开发时 JIT，提升开发效率；发布时 AOT，提升性能。
2.不会面对 JS 与 Native 之间交互的问题了。
3.Dart 的内存策略，采用多生代算法（与 Node 有一些类似）。
4.线程模型依旧是单线程 Event Loop 模型，通过 isolate 进行隔离，可以降低开发难度（与 Node 也非常类似）。
5.Dart 的生态，这个跟 Node.js 差距十分明显，npm 还是行业中最活跃的。
6.而静态语法与排版方式，纯前端入门还是有一定成本。

Flutter 选择 Dart 的原因：
1.健全的类型系统，同时支持静态类型检查和运行时类型检查。
2.代码体积优化（TreeShaking），编译时只保留运行时需要调用的代码（不允许反射这样的隐式引用），所以庞大的 Widgets 库不会造成发布体积过大。
3.丰富的底层库，Dart 自身提供了非常多的库。多生代无锁垃圾回收器，专门为 UI 框架中常见的大量 Widgets 对象创建和销毁优化。
4.跨平台，iOS 和 Android 共用一套代码。
5.JIT & AOT 运行模式，支持开发时的快速迭代和正式发布后最大程度发挥硬件性能。
6.Native Binding。在 Android 上，v8 的 Native Binding 可以很好地实现，但是 iOS 上的 JavaScriptCore 不可以，
所以如果使用 JavaScript，Flutter 基础框架的代码模式就很难统一了。而 Dart 的 Native Binding 可以很好地通过 Dart Lib 实现。

Flutter 的 UI 渲染方案：Skia
渲染方案是 Flutter 目前独特的设计形态，就是由于渲染自闭环，才能真正跨平台。
Skia 是一个用C++ 开发的、性能彪悍的2D绘图引擎库，其前身是一个向量绘图软件，Chrome 和 Android 均采用 Skia 作为绘图引擎。
Skia 提供了非常友好的 API，并且在图形转换、文字渲染、位图渲染方面都提供了友好、高效的表现。
Skia 是跨平台的，所以可以被嵌入到 Flutter 的 iOS SDK 中，而不用去研究 iOS 闭源的 CoreGraphics / Core Animation。
1.Flutter 底层的渲染能力得到了统一，不在需要使用做双端适配；
2.通过 OpenGL、GPU，不需要依赖原生的组件渲染框架。
3.Flutter 可以最大限度的抹平平台差异，提升渲染效率和性能。

绘制流程：
Flutter 渲染流程分为 7 个步骤：
1.用户操作：首先是获取到用户的操作
2.动画：然后你的应用会因此显示一些动画
3.构建：Flutter 开始构建 Widget 对象，Widget 对象构建完成后进入渲染阶段，这个阶段主要包括三步：4.5.6
4.布局元素：决定页面元素在屏幕上的位置和大小；
5.绘制阶段：将页面元素绘制成它们应有的样式；
6.合成阶段：按照绘制规则将之前两个步骤的产物组合在一起
7.光栅化:最后的光栅化由 Engine 层来完成。
* */


/*
应用程序的入口：main 函数
类，构造函数，命名构造函数，重定向构造函数，继承，重写，set/get，泛型
*/
import 'dart:core';

void main() {

  print("====================== 类 class ====================");

  Student s1 = Student.data("tiankun", 30);
  print(s1.getName());//tiankun
  print(s1.studName);//tiankun
  print(s1.name);//tiankun
  print(s1.age);//30

  s1.setName("zhonguo");
  print(s1.getName());//zhonguo
  print(s1.studName);//zhonguo
  print(s1.name);//zhonguo

  s1.studName = 'Maxsu';
  print(s1.getName());//Maxsu
  print(s1.studName);//Maxsu
  print(s1.name);//Maxsu

  Student1 student1 = Student1("tiankun", 45);
  student1.setName("woshi Student1");
  student1.studName = "woshi Student1 Student1";
  print(student1.studName);//woshi Student1 Student1test
  print(student1.age);//45
}


/*
* 构造函数: 是类的特殊函数，负责初始化类的变量。
* Dart定义了一个与该类名称相同的构造函数。构造函数是一个函数，因此可以参数化。
* 但是与函数不同，构造函数不能具有返回类型。如果未声明构造函数，则它会提供默认的无参数构造函数。
*/
class Student {
  String name;
  int age;
  int score;

  //主构造函数
//  Student(String name, int age){
//    this.name = name;
//    this.age = age;
//  }
  Student(String name, int age) : this.name = name,this.age = age;
  //命名构造函数
  Student.name(String name) {
    // this关键字引用类的当前实例。这里，参数名称和类字段的名称是相同的。
    // 因此，为了避免歧义，类的字段以this关键字为前缀。
    this.name = name;
  }
  //dart 支持新的语法：
  Student.score(int score) : this.score = score, age = 20;
  // 重定向构造函数，指向主构造函数，函数体为空
  // 貌似swift中的便利构造函数，但略有不同
  Student.alongXAxis(num x) : this("", x);
  Student.data(String name, int age){
    this.name = name;
    this.age = age;
  }

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
* Dart支持继承的概念，它是程序从现有类创建新类的能力。
* 扩展为创建较新类的类称为父类/超类。新创建的类称为子/子类。
* 一个类使用extends关键字从另一个类继承。子类继承除父类的构造函数之外的所有属性和方法。
*
* 注 -  Dart不支持多重继承。
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

  //思考：子类不能继承父类所有的构造函数，又不能灵活创建自己的构造函数，这点不方便。
  Student1(String name, int age) : super(name, age);
  Student1.name(String name) : super.name(name);
  Student1.num(num) : super('', 0){
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

//箭头函数 语法
bool isNoble(int atomicNumber) => List() != null || [1, 2, 3] != null;
bool isNoble2(int atomicNumber) {
  return List() != null || [1, 2, 3] != null;
}


//常值实例创建方法  静态构造函数(单例)
//如果想要让类产生一个永远不会改变的对象，可以让这些对象成为编译时常量。为此，需要定义一个 const 构造函数并确保所有的实例变量都是 final 的
class ImmTablePoint {
      /*
        如果调用参数一致，创建出的实例也是同一个（内存地址相同）。
       1,类似于swift中单例的初始化方法。
       2,static final修饰的shared是静态的地址不可修改的实例变量.
       3,const ImmtablePoint(0,0) 表示初始化一个为常值的实例。
       4,shared变量是一个地址不可修改且内容为常值的ImmtablePoint类的实例。
       5,由于需要构造一个内容不可修改的实例，所以构造函数也需要被const修饰。
       6,常量构造函数内容不可修改则实例变量也不可修改，则实例变量也需要final来修饰。
    */
  static final shared = const ImmTablePoint(0,0);

  final num a,b;

  const ImmTablePoint(this.a, this.b);
}


//抽象方法
abstract class Doer {
  /*
  * 抽象类，方法无需实现
  * */
  void doSomething();
}

class EffDoer extends Doer {
  /*
  * 1，指定抽象类拓展。
  * 2，拓展后需实现抽象类中的方法。
  * */
  void doSomething() {
    print('doSomething');
  }
}

//操作符覆盖 operator
class Vector {
  final int x,y;
  Vector(this.x,this.y);

    /*
    1,+，-操作覆盖
    2，operator关键词
    */
  Vector operator +(Vector v) => Vector(x + v.x, y + v.y);
  Vector operator -(Vector v) => Vector(x - v.x, y - v.y);

    /*
    * 1,覆盖==符号，必须也好覆盖hashCode方法
    */
  @override
  int get hashCode {
    int res = 1;
    res = res + x.hashCode;
    res = res + y.hashCode;
    return res;
  }

  @override
  bool operator == (dynamic other) {
    if (other is! Vector) return false;
    Vector newObj = other;
    return (newObj.x == x && newObj.y == y);
  }
}

