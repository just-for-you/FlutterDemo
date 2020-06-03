

/// 【Dart typedef】函数类型别名
/// typedef或函数类型别名有助于定义指向内存中可执行代码的指针。简单地说，typedef可以用作引用函数的指针。
///
/// Dart程序中实现typedef的步骤：
/// 第1步：定义typedef: typedef function_name(parameters)
/// 第2步：将函数分配给typedef变量: type_def var_name = function_name
/// 第3步：调用函数: typedef变量可用于调用函数 var_name(parameters)


// function signature
// 定义一个typedef，定义的是一个函数签名，该函数将采用整数类型的两个输入参数，返回类型不是函数签名的一部分。
typedef ManyOperation(int firstNo , int secondNo);

// 接下来定义函数，使用与ManyOperation typedef相同的函数签名定义一些函数。
// 加
add(int firstNo,int second){
  print("Add result is ${firstNo+second}");
}

// 减
subtract(int firstNo,int second){
  print("Subtract result is ${firstNo-second}");
}

// 除
divide(int firstNo,int second){
  print("Divide result is ${firstNo/second}");
}

// 计算器
calculator(int a, int b, ManyOperation operation){
  print("Inside calculator");
  operation(a,b);
}

void main() {
  // 通过typedef调用该函数。声明ManyOperations类型的变量。将函数名称分配给声明的变量。
  // oper变量可以指向任何采用两个整数参数的方法。
  // add函数的引用赋给变量。typedef可以在运行时切换函数引用。
  // 注：如果typedef变量尝试指向具有不同函数签名的函数，则代码将导致错误。
  ManyOperation operation = add;
  operation(10,20);//30
  operation = subtract;
  operation(30,20);//10
  operation = divide;
  operation(50,5);//10.0

  // typedef也可以作为参数传递给函数。
  calculator(5,5,add);//10
  calculator(5,5,subtract);//0
  calculator(5,5,divide);//1.0

  // 未使用typedef
  SortedCollection coll = SortedCollection(sort);
  // 虽然知道 compare 是函数，
  // 但是函数是什么类型 ？
  assert(coll.compare is Function);

  // 使用typedef
  SortedCollection2 coll2 = SortedCollection2(sort);
  assert(coll2.compare is Function);
  assert(coll2.compare is Compare);

  //由于 typedefs 只是别名， 他们还提供了一种方式来判断任意函数的类型。
  assert(sort is CompareN<int>); // True!
}


class SortedCollection {
  Function compare;
  SortedCollection(int f(Object a, Object b)) {
    // 当把 f 赋值给 compare 的时候，类型信息丢失了。 f 的类型是 (Object, Object) → int (这里 → 代表返回值类型)， 但是 compare 得到的类型是 Function 。
    // 如果我们使用显式的名字并保留类型信息， 这样开发者和工具都可以使用这些信息：
    compare = f;
  }
}

// Initial, broken implementation. // broken ？
int sort(Object a, Object b) => 0;

//提示： 目前，typedefs 只能使用在函数类型上， 我们希望将来这种情况有所改变。
typedef Compare = int Function(Object a, Object b);
class SortedCollection2 {
  Compare compare;
  SortedCollection2(this.compare);
}

// 由于 typedefs 只是别名，他们还提供了一种方式来判断任意函数的类型。例如：
typedef CompareN<T> = int Function(T a, T b);