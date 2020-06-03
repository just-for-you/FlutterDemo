

/// 【Dart 异常：】
/// 异常(或异常事件)是在执行程序期间出现的问题。
/// 发生异常时，程序的正常流程中断，程序/应用程序异常终止。
///
/// 【Dart内置异常:】
/// 1:DeferredLoadException 延迟库无法加载时抛出。
/// 2:FormatException 当字符串或某些其他数据没有预期格式且无法解析或处理时抛出异常。
/// 3:IntegerDivisionByZeroException 当数字除以零时抛出。
/// 4:IOException 所有与输入输出相关的异常的基类。
/// 5:IsolateSpawnException 无法创建隔离时抛出。
/// 6:Timeout 在等待异步结果时发生计划超时时抛出。

void main() {

  /// 【try/on/catch块：】
  /// try块嵌入可能导致异常的代码，try块必须紧跟一个on/catch块或一个finally块(或两者之一)，当try块中发生异常时，控制将转移到catch。
  /// 需要指定异常类型时使用on块。
  /// 当处理程序需要异常对象时使用catch块。
  ///
  /// 备注：
  /// 1.代码段可以有多个on/catch块来处理多个异常。
  /// 2.on块和catch块是相互包含的，即try块可以与on块和catch块相关联。

  int x = 12;
  int y = 0;
  int res;
  try {
    res = x ~/ y;
  } on IntegerDivisionByZeroException {
    print('Cannot divide by zero');
  }

  try {
    res = x ~/ y;
  } catch(e) {
    print(e);
  }

  try {
    res = x ~/ y;
  } on IntegerDivisionByZeroException catch(e) {
    print(e);
  } finally {
    print('======  Finally block executed');
  }


  /// 【抛出异常:】
  /// throw关键字用于显式引发异常。
  /// 应该处理引发的异常，以防止程序突然退出。

  void testException(int age) {
    if(age < 0) {
      throw AmtException();
    }
  }

  try {
    testException(-1);
  } catch(e) {
    print(e.errMsg());
  } finally {
    print('============== test exception end.....');
  }

}


/// 【自定义异常：】
/// Dart中的每个异常类型都是内置类Exception的子类，Dart可以通过扩展现有异常来创建自定义异常。
class AmtException implements Exception {
  String errMsg() => 'Amount should be greater than zero';
}


