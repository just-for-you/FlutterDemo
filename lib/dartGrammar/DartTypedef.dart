

/// 【Dart typedef】默认类型，函数类型别名
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
}



