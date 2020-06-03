

// 【重写运算符】
// 下标的运算符可以被重写。 例如，想要实现两个向量对象相加，可以重写 + 方法。
// <	+	|	[]
// >	/	^	[]=
// <=	~/	&	~
// >=	*	<<	==
// –	%	>>
// 提示： 你可能会被提示 != 运算符为非可重载运算符。 因为 e1 != e2 表达式仅仅是 !(e1 == e2) 的语法糖。

// operator 是 Dart 的一个关键字，它和运算符（如=）一起使用，表示一个 运算符重载函数，在理解时可将operator和运算符（如operator=）视为一个函数名。
// 使用 operator 重载运算符，是 Dar 扩展运算符功能的方法。使用 operator 扩展运算符功能的原因如下：
// 1.使重载后的运算符的使用方法与重载前一致
// 2.扩展运算符的功能只能通过函数的方式实现

class Vector {
  final int x, y;

  Vector(this.x, this.y);

  Vector operator +(Vector v) => Vector(x + v.x, y + v.y);

  Vector operator -(Vector v) => Vector(x - v.x, y - v.y);

  get num {
    return x + y;
  }

// 运算符 == 和 hashCode 部分没有列出。 有关详情，请参考下面的注释。
// 如果要重写 == 操作符，需要重写对象的 hashCode getter 方法。 重写 == 和 hashCode 的实例，
// 参考 Implementing map keys. https://www.dartcn.com/guides/libraries/library-tour#implementing-map-keys

}

void main() {
  final v = Vector(2, 3);
  final w = Vector(2, 2);

  assert(v + w == Vector(4, 5));
  assert(v - w == Vector(0, 1));
}
