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
  Future<String> f = file.readAsString(); //异步

  // returns a futrue, this is Async method
  f.then((data) =>
      print(data)); // once file is read , call back method is invoked
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
  String name = stdin.readLineSync(); //同步阻塞
  // this is a synchronous method that reads user input
  print("Hello Mr. $name");
  print("End of main");


  // delayed  then  catchError
  Future.delayed(new Duration(seconds: 2), () {
    //return "hi world!";
    throw AssertionError("Error");
  }).then((data) {
    //执行成功会走到这里
    print("success");
  }).catchError((e) {
    //执行失败会走到这里
    print(e);
  });

  // 异步任务中抛出了一个异常，then的回调函数将不会被执行，取而代之的是 catchError回调函数将被调用；
  // 但是，并不是只有 catchError回调才能捕获错误，then方法还有一个可选参数onError，我们也可以它来捕获异常：
  Future.delayed(new Duration(seconds: 2), () {
    //return "hi world!";
    throw AssertionError("Error");
  }).then((data) {
    print("success");
  }, onError: (e) {
    print(e);
  });

  // 有些时候，我们会遇到无论异步任务执行成功或失败都需要做一些事的场景，
  // 比如在网络请求前弹出加载对话框，在请求结束后关闭对话框。这种场景，
  // 有两种方法，第一种是分别在then或catch中关闭一下对话框，第二种就是使用Future的whenComplete回调
  Future.delayed(new Duration(seconds: 2), () {
    //return "hi world!";
    throw AssertionError("Error");
  }).then((data) {
    //执行成功会走到这里
    print(data);
  }).catchError((e) {
    //执行失败会走到这里
    print(e);
  }).whenComplete(() {
    //无论成功或失败都会走到这里
  });


  //有些时候，我们需要等待多个异步任务都执行结束后才进行一些操作，
  // 比如我们有一个界面，需要先分别从两个网络接口获取数据，获取成功后，
  // 我们需要将两个接口数据进行特定的处理后再显示到UI界面上，应该怎么做？
  // 答案是Future.wait，它接受一个Future数组参数，只有数组中所有Future都执行成功后，才会触发then的成功回调，
  // 只要有一个Future执行失败，就会触发错误回调。
  // 下面，我们通过模拟Future.delayed 来模拟两个数据获取的异步任务，
  // 等两个异步任务都执行成功时，将两个异步任务的结果拼接打印出来，代码如下：
  Future.wait([
    // 2秒后返回结果
    Future.delayed(new Duration(seconds: 2), () {
      return "hello";
    }),
    // 4秒后返回结果
    Future.delayed(new Duration(seconds: 4), () {
      return " world";
    })
  ]).then((results) {
    print(results[0] + results[1]);
  }).catchError((e) {
    print(e);
  });


  // 回调地狱(Callback Hell)
  // 如果代码中有大量异步逻辑，并且出现大量异步任务依赖其它异步任务的结果时，
  // 必然会出现Future.then回调中套回调情况。举个例子，比如现在有个需求场景是用户先登录，
  // 登录成功后会获得用户ID，然后通过用户ID，再去请求用户个人信息，获取到用户个人信息后，为了使用方便，我们需要将其缓存在本地文件系统，代码如下：
  // 先分别定义各个异步任务
  Future<String> login(String userName, String pwd) {
    //用户登录
  }
  Future<String> getUserInfo(String id) {
    //获取用户信息
  }
  Future saveUserInfo(String userInfo) {
    // 保存用户信息
  }
  //接下来，执行整个任务流：
  login("alice", "******").then((id) {
    //登录成功后通过，id获取用户信息
    getUserInfo(id).then((userInfo) {
      //获取用户信息后保存
      saveUserInfo(userInfo).then((data) {
        //保存用户信息，接下来执行其它操作
      });
    });
  });


  // 过多的嵌套会导致的代码可读性下降以及出错率提高，并且非常难维护，这个问题被形象的称为回调地狱（Callback Hell）
  // 回调地狱问题在之前JavaScript中非常突出，也是JavaScript被吐槽最多的点，但随着ECMAScript6和ECMAScript7标准发布后，
  // 这个问题得到了非常好的解决，而解决回调地狱的两大神器正是ECMAScript6引入了Promise，以及ECMAScript7中引入的async/await
  // Dart中几乎是完全平移了JavaScript中的这两者：Future相当于Promise，而async/await连名字都没改。

  // 使用Future消除Callback Hell
  // Future 的所有API的返回值仍然是一个Future对象，所以可以很方便的进行链式调用” ，
  // 如果在then中返回的是一个Future的话，该future会执行，执行结束后会触发后面的then回调，
  // 这样依次向下，就避免了层层嵌套。
  login("alice","******").then((id){
    return getUserInfo(id);
  }).then((userInfo){
    return saveUserInfo(userInfo);
  }).then((e){
    //执行接下来的操作
  }).catchError((e){
    //错误处理
    print(e);
  });


  // 使用async/await消除callback hell
  // 通过Future回调中再返回Future的方式虽然能避免层层嵌套，但是还是有一层回调，
  // 有没有一种方式能够让我们可以像写同步代码那样来执行异步任务而不使用回调的方式？
  // 答案是肯定的，这就要使用async/await了
  task() async {
    try {
      String id = await login("alice", "******");
      String userInfo = await getUserInfo(id);
      await saveUserInfo(userInfo);
      //执行接下来的操作
    } catch (e) {
      //错误处理
      print(e);
    }
  }

  // 思考：
  // async用来表示函数是异步的，定义的函数会返回一个Future对象，可以使用then方法添加回调函数。
  // await 后面是一个Future，表示等待该异步任务完成，异步完成后才会往下走；await必须出现在 async 函数内部。
  // 其实，无论是在JavaScript还是Dart中，async/await都只是一个语法糖，编译器或解释器最终都会将其转化为一个Promise（Future）的调用链。



  // Stream
  // 也是用于接收异步事件数据，和Future 不同的是，它可以接收多个异步操作的结果（成功或失败）。
  // 也就是说，在执行异步任务时，可以通过多次触发成功或失败事件来传递结果数据或错误异常。
  // Stream 常用于会多次读取数据的异步任务场景，如网络内容下载、文件读写等。
  // 思考题：既然Stream可以接收多次事件，那能不能用Stream来实现一个订阅者模式的事件总线？
  Stream.fromFutures([
    // 1秒后返回结果
    Future.delayed(new Duration(seconds: 1), () {
      return "hello 1";
    }),
    // 抛出一个异常
    Future.delayed(new Duration(seconds: 2),(){
      throw AssertionError("Error");
    }),
    // 3秒后返回结果
    Future.delayed(new Duration(seconds: 3), () {
      return "hello 3";
    })
  ]).listen((data){
    print(data);
  }, onError: (e){
    print(e.message);
  },onDone: (){

  });
  // 上面的代码依次会输出：
  // I/flutter (17666): hello 1
  // I/flutter (17666): Error
  // I/flutter (17666): hello 3

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



