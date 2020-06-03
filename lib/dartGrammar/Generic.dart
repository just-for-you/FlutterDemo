import 'dart:core';

/// dart 泛型【重要】
///
/// io
/// 多线程
/// 网络
/// 反射 暂时不支持
/// 类加载

void main() {
  // 在 API 文档中你会发现基础数组类型 List 的实际类型是 List<E> 。
  // <…> 符号将List标记为泛型 (或 参数化) 类型，这种类型具有形式化的参数。
  // 通常情况下，使用一个字母来代表类型参数， 例如 E, T, S, K, 和 V 等。

  /// 为什么使用泛型
  /// 在类型安全上通常需要泛型支持， 它的好处不仅仅是保证代码的正常运行：
  /// 1.正确指定泛型类型可以提高代码质量。
  /// 2.使用泛型可以减少重复的代码。
  //
  // 如果想让 List 仅仅支持字符串类型，可以将其声明为 List<String> （读作“字符串类型的 list ”）。
  // 那么，当一个非字符串被赋值给了这个 list 时，开发工具就能够检测到这样的做法可能存在错误。 例如：
  var names = List<String>();
  names.addAll(['Seth', 'Kathy', 'Lars']);
  //names.add(42); // 错误

  // 使用集合字面量
  // List, Set 和 Map字面量也是可以参数化的。 参数化字面量和之前的字面量定义类似，
  // 对于 List 或 Set 只需要在声明语句前加 <type> 前缀，对于Map只需要在声明语句前加 <keyType, valueType> 前缀， 下面是参数化字面量的示例：
  var namesA = <String>['Seth', 'Kathy', 'Lars'];
  var uniqueNames = <String>{'Seth', 'Kathy', 'Lars'};
  var pages = <String, String>{
    'index.html': 'Homepage',
    'robots.txt': 'Hints for web robots',
    'humans.txt': 'We are people, not machines'
  };

  //使用泛型类型的构造函数
  //在调用构造函数的时，在类名字后面使用尖括号（<...>）来指定泛型类型。 例如：
  var nameSet = Set<String>.from(names);
  //下面代码创建了一个key为integer，value为String的map对象：
  var views = Map<int, String>();
  print(nameSet);
  print(views);

  /// 运行时中的泛型集合
  // Dart中泛型类型是【固化的】，也就是说它们在运行时是携带着类型信息的。 例如，在运行时检测集合的类型。
  // 提示：相反Java中的泛型会被擦除，也就是说在运行时泛型类型参数的信息是不存在的。
  // 在Java中，可以测试对象是否为List类型，但无法测试它是否为List<String> 。
  var nameB = List<String>();
  nameB.addAll(['Seth', 'Kathy', 'Lars']);
  print(nameB is List<String>); // true

  //可以使用 SomeBaseClass 或其任意子类作为通用参数：
  var someBaseClassFoo = Foo<SomeBaseClass>();
  var extenderFoo = Foo<Extender>();
  //也可以不指定泛型参数：
  var foo = Foo();
  print(foo); // Instance of 'Foo<SomeBaseClass>'
  //指定任何非 SomeBaseClass 类型会导致错误：
  //var foo = Foo<Object>();

  // 使用泛型函数
  // 最初，Dart的泛型只能用于类。 新语法_泛型方法_，允许在方法和函数上使用类型参数：
  //
  // 这里的 first (<T>) 泛型可以在如下地方使用参数 T ：
  // 函数的返回值类型 (T).
  // 参数的类型 (List<T>).
  // 局部变量的类型 (T tmp).

  T first<T>(List<T> ts) {
    // Do some initial work or error checking, then...
    T tmp = ts[0];
    // Do some additional checking or processing...
    return tmp;
  }

}


// 另外一个使用泛型的原因是减少重复的代码。
// 泛型可以在多种类型之间定义同一个实现， 同时还可以继续使用检查模式和静态分析工具提供的代码分析功能。 例如，假设你创建了一个用于缓存对象的接口：
abstract class ObjectCache {
  Object getByKey(String key);
  void setByKey(String key, Object value);
}

//后来发现需要一个相同功能的字符串类型接口，因此又创建了另一个接口：
abstract class StringCache {
  String getByKey(String key);
  void setByKey(String key, String value);
}
//后来，又发现需要一个相同功能的数字类型接口 … 这里你应该明白了。

//泛型可以省去创建所有这些接口的麻烦。 通过创建一个带有泛型参数的接口，来代替上述接口：
abstract class Cache<T> {
  T getByKey(String key);
  void setByKey(String key, T value);
}
//在上面的代码中，T 是一个备用类型。 这是一个类型占位符，在开发者调用该接口的时候会指定具体类型。

//限制泛型类型
//使用泛型类型的时候， 可以使用 extends 实现参数类型的限制。
class Foo<T extends SomeBaseClass> {
  // Implementation goes here...
  String toString() => "Instance of 'Foo<$T>'";
}

class Extender extends SomeBaseClass {}

class SomeBaseClass {}
