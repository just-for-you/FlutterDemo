import 'dart:io';

/// 【Dart异步】
/// 异步操作在线程中执行，与主应用程序线程分开。
/// 当应用程序调用方法异步执行操作时，应用程序可以在异步方法执行其任务时继续执行。
///
/// Dart 库中包含许多返回 Future 或 Stream 对象的函数. 这些函数在设置完耗时任务（例如 I/O 曹组）后， 就立即返回了，不会等待耗任务完成。
/// 使用 async 和 await 关键字实现异步编程。 可以让你像编写同步代码一样实现异步操作。
///

/*
 在计算中，当某个事件在继续之前等待事件发生时，它是同步的。缺点是: 如果代码的一部分花费太长时间来执行，则后续的块虽然不相关，但会阻止暂停执行。
 考虑一个必须响应多个资源请求的Web服务器，同步执行模型将阻止每个其他用户的请求，直到它完成当前请求的处理。
 在这种情况下，与Web服务器的情况一样，每个请求必须独立于其他请求。Web服务器在响应其他用户的请求之前不应等待当前请求完成执行。
 简而言之，在完成先前用户的请求之前，它应该接受来自新用户的请求，称为异步。
 异步编程基本上意味着没有等待或非阻塞编程模型。dart:async包有助于在Dart脚本中实现异步编程块。
*/

void main() {

  // demo2: 异步非阻塞
  // 当脚本继续读取文件时，首先执行“End of main async"。
  // Future类是dart:async的一部分，用于在异步任务完成后获取计算结果。然后，此Future值用于在计算完成后执行某些操作。
  // 当读取操作完成，执行控制就在then()内传送。这是因为读取操作可能需要更多时间，因此不希望阻止程序的其他部分。
  print(Directory.current.path); // D:\workspace1\FlutterDemo

  File file = new File(Directory.current.path + "\\data\\contact.txt");
  Future<String> f = file.readAsString();//异步

  // returns a futrue, this is Async method
  f.then((data) => print(data)); // once file is read , call back method is invoked
  //1, One
  //2, Two
  //3, Three
  //4, Four
  print("End of main async");
  // this get printed first, showing fileReading is non blocking or async


  // demo1： 同步阻塞执行
  // readLineSync()是一种同步方法。它将阻止执行readLineSync()函数调用之后的所有指令，直到readLineSync()方法完成执行。
  // stdin.readLineSync等待输入。它停止执行并且在收到用户输入之前不再执行任何操作。

  print("Enter your name :");
  // prompt for user input
  String name = stdin.readLineSync();//同步阻塞
  // this is a synchronous method that reads user input
  print("Hello Mr. $name");
  print("End of main");


}

// Dart Future:
// Dart社区将Future定义为“在未来的某个时间获取值的手段”。
// 简单地说，Future对象是一种表示由表达式返回的值的机制，该表达式的执行将在稍后的时间点完成。当调用异步方法时，Dart的几个内置类返回Future。
//
// Dart是一种单线程编程语言。如果代码阻塞执行的线程(例如，通过等待耗时的操作或阻塞I/O)，程序将有效地冻结。
// 异步操作可让程序运行而不会被阻止。Dart使用Future对象来表示异步操作。

//处理 Future
//可以通过下面两种方式，获得 Future 执行完成的结果：
//
//使用 async 和 await.
//使用 Future API，具体描述，参考 库概览.
//使用 async 和 await 关键字的代码是异步的。 虽然看起来有点想同步代码。
//例如，下面的代码使用 await 等待异步函数的执行结果。
//await lookUpVersion();
//要使用 await ， 代码必须在 异步函数（使用 async 标记的函数）中：
//Future checkVersion() async {
//  var version = await lookUpVersion();
//  // Do something with version
//}
// 提示： 虽然异步函数可能会执行耗时的操作， 但它不会等待这些操作。 相反，异步函数只有在遇到第一个 await 表达式（详情见）时才会执行。
// 也就是说，它返回一个 Future 对象， 仅在await表达式完成后才恢复执行。
//
//使用 try， catch， 和 finally 来处理代码中使用 await 导致的错误。
//
//try {
//  version = await lookUpVersion();
//} catch (e) {
//  // React to inability to look up the version
//}
//
//在一个异步函数中可以多次使用 await 。 例如，下面代码中等待了三次函数结果：
//
//var entrypoint = await findEntrypoint();
//var exitCode = await runExecutable(entrypoint, args);
//await flushThenExit(exitCode);
//
// 在 await 表达式 中， 表达式 的值通常是一个 Future 对象； 如果不是，这是表达式的值会被自动包装成一个 Future 对象。
// Future 对象指明返回一个对象的承诺（promise）。 await 表达式 执行的结果为这个返回的对象。
// await 表达式会阻塞代码的执行，直到需要的对象返回为止。
//
//
// 如果在使用 await 导致编译时错误， 确认 await 是否在一个异步函数中。
// 例如，在应用的 main() 函数中使用 await ， main() 函数的函数体必须被标记为 async ：
//
//Future main() async {
//  checkVersion();
//  print('In main: version is ${await lookUpVersion()}');
//}
//
//
//声明异步函数
//函数体被 async 标示符标记的函数，即是一个_异步函数_。 将 async 关键字添加到函数使其返回Future。 例如，考虑下面的同步函数，它返回一个 String ：
//
//String lookUpVersion() => '1.0.0';
//例如，将来的实现将非常耗时，将其更改为异步函数，返回值是 Future 。
//
//Future<String> lookUpVersion() async => '1.0.0';
//注意，函数体不需要使用Future API。 如有必要， Dart 会创建 Future 对象。
//
//如果函数没有返回有效值， 需要设置其返回类型为 Future<void>
//
//
//处理 Stream
//当需要从 Stream 中获取数据值时， 可以通过一下两种方式：
//
//使用 async 和 一个 异步循环 （await for）。
//使用 Stream API, 更多详情，参考 in the library tour。
//提示： 在使用 await for 前，确保代码清晰， 并且确实希望等待所有流的结果。 例如，通常不应该使用 await for 的UI事件侦听器， 因为UI框架会发送无穷无尽的事件流。
//
//一下是异步for循环的使用形式：
//
//await for (varOrType identifier in expression) {
//  // Executes each time the stream emits a value.
//}
//上面 表达式 返回的值必须是 Stream 类型。 执行流程如下：
//
//等待，直到流发出一个值。
//执行 for 循环体，将变量设置为该发出的值
//重复1和2，直到关闭流。
//
//使用 break 或者 return 语句可以停止接收 stream 的数据， 这样就跳出了 for 循环， 并且从 stream 上取消注册。 **如果在实现异步 for 循环时遇到编译时错误， 请检查确保 await for 处于异步函数中。** 例如，要在应用程序的 main() 函数中使用异步 fo r循环， main() 函数体必须标记为 async` ：
//
//Future main() async {
//  // ...
//  await for (var request in requestServer) {
//    handleRequest(request);
//  }
//  // ...
//}
//



