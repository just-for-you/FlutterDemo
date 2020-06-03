
// 【Dart 隐式接口】
//
// 1.Dart中也有接口，但是不能像Java中那样使用interface来定义
// 2.Dart中的类会生成一套相同成员的接口，简单理解：类就是接口。
// 3.实现一个接口，同样需要我们用implements ,但是需要我们覆盖一遍接口中所有的成员。
// 4.我们建议使用抽象类来定义接口。

// 官方：
// 每个类都隐式的定义了一个接口，接口包含了该类所有的实例成员及其实现的接口。
// 如果要创建一个 A 类，A 要支持 B 类的 API ，但是不需要继承 B 的实现， 那么可以通过 A 实现 B 的接口。
// 一个类可以通过 implements 关键字来实现一个或者多个接口， 并实现每个接口要求的 API。


// person 类。 隐式接口里面包含了 greet() 方法声明。
class Person {
  // 包含在接口里，但只在当前库中可见。
  final _name;

  // 不包含在接口里，因为这是一个构造函数。
  Person(this._name);

  // 包含在接口里。
  String greet(String who) => 'Hello, $who. I am $_name.';
}

// person 接口的实现。
class Impostor implements Person {
  get _name => '';

  String greet(String who) => 'Hi $who. Do you know who I am?';
}

String greetBob(Person person) => person.greet('Bob');

void main() {
  print(greetBob(Person('Kathy')));
  print(greetBob(Impostor()));
}





