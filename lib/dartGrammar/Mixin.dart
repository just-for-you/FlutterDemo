

/// mixin
//Dart 是一种面向对象的语言，并且支持基于mixin的继承方式
//基于mixin的继承方式具体是指：一个类可以继承自多个父类

//https://juejin.im/post/6844903686787825678
//mixins的声明顺序非常重要, Why？它是如何工作的？

// 线性化
// 当您将mixin混入类中时，请记住下面这句话：
// Dart中的Mixins通过创建一个新类来实现，该类将mixin的实现层叠在一个超类之上以创建一个新类 ，
// 它不是“在超类中”，而是在超类的“顶部”，因此如何解决查找问题不会产生歧义。


/*
实际上：我们并没有使用多重继承！

Mixins不是一种在经典意义上获得多重继承的方法。
Mixins是一种抽象和重用一系列操作和状态的方法。
它类似于扩展类所获得的重用，但它与单继承兼容，因为它是线性的。

声明mixins的顺序代表了从最高级到最高级的继承链，这件事非常重要，你需要记住。
* */


class A {
  String getMessage() => 'A';
}

class B {
  String getMessage() => 'B';
}

class P {
  String getMessage() => 'P';
}

class AB extends P with A, B {}

class BA extends P with B, A {}

/*
  等同于：
    class PA = P with A;
    class PAB = PA with B;
    class AB extends PAB {}

    class PB = P with B;
    class PBA = PB with A;
    class BA extends PBA {}
 * */


void main() {
  String result = '';

  AB ab = AB();
  result += ab.getMessage();
  print(result);//B
  print(ab is P);
  print(ab is A);
  print(ab is B);

  BA ba = BA();
  result += ba.getMessage();//BA
  print(ba is P);
  print(ba is A);
  print(ba is B);

  print(result);


  /*
由于每个mixin应用程序都创建一个新类，它还会创建一个新接口（因为所有Dart类也定义了接口）。
如上所述，新类扩展了超类并包含了mixin类成员的副本，但它也实现了mixin类接口。
在大多数情况下，无法引用mixin-application类或其接口。
Super with Mixin的类只是类的匿名超类，声明类似C类使用Mixin {}扩展Super。
如果你将一个mixin应用程序命名为类CSuper = Super with Mixin {}，那么你可以参考mixin应用程序类及其接口，它将是Super和Mixin的子类型。
— Lasse R. H. Nielsen

  * */
}

/*
*
* 什么时候应该使用mixins？
* https://juejin.im/post/6844903686787825678
*
* mixins是一个强大的概念，允许您跨多个类层次结构重用代码。

Flutter经常使用到这个功能，更好地理解它非常重要
* */

