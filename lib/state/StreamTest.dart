import 'dart:async';

class WannabeFunction {
  call(String a, String b, String c) => '$a $b $c!';
}

void main() async {
  var wf = WannabeFunction();
  var out = wf("Hi", "there,", "gang");
  print('$out'); //Hi there, gang!

  //异步生成器
  await for (int i in countForOneMinute()) {
    print(i); // 每间隔一秒，从1打印到60
  }

  //异步函数
  int result = await doSomeLongTask(); //异步调用
  print(result); // 一秒后打印42

  Future<int> sumStream(Stream<int> stream) async {
    var sum = 0;
    await for (var value in stream) {
      sum += value;
    }
    return sum;
  }

  //任意类型的流
  // ignore: close_sinks
  StreamController controller = StreamController();
  controller.sink.add(123);
  controller.sink.add("xyz");
  //controller.sink.add(Anything);

  //创建一条处理int类型的流
  // ignore: close_sinks
  StreamController<int> controller2 = StreamController();
  controller2.sink.add(345);
  //controller2.sink.close();

  //泛型定义了我们能向流上推送什么类型的数据。它可以是任何类型！
  // ignore: close_sinks
  StreamController controller3 = StreamController();

  //监听这个流的出口，当有data流出时，打印这个data
  StreamSubscription subscription =
      controller3.stream.listen((data) => print("$data"));
  controller3.sink.add(123);


  // Transforming an existing stream
  // 假如你已经有了一个流，你可以通过它转化成为一条新的流。非常简单！流提供了map()，where()，expand()，和take()方法，能够轻松将已有的流转化为新的流。
  // where 筛选 stream.where((event){...})
  // take  限制  stream.take(4); 让用户最多输四次，那么我们可以使用take来限制, take函数接收一个int，代表最多能经过take函数的事件次数。当传输次数达到这个数字时，这个流将会关闭，无法再传输。
  // transform 更多的控制转换 配合StreamTransformer进行使用。
  // ignore: close_sinks
  StreamController<int> controller5 = StreamController<int>();
  final transformer =
      StreamTransformer<int, String>.fromHandlers(handleData: (value, sink) {
    if (value == 100) {
      sink.add("你猜对了");
    } else {
      sink.addError('还没猜中，再试一次吧');
    }
  });
  controller5.stream
      .transform(transformer)
      .listen((data) => print(data), onError: (err) => print(err));
  controller5.sink.add(23);
  //controller.sink.add(100);
  //输出: 还没猜中，再试一次吧

  /**
   * StreamTransformer<S,T>是我们stream的检查员，他负责接收stream通过的信息，然后进行处理返回一条新的流。
       * S代表之前的流的输入类型，我们这里是输入一个数字，所以是int。
       * T代表转化后流的输入类型，我们这里add进去的是一串字符串，所以是String。
       * handleData接收一个value并创建一条新的流并暴露sink，我们可以在这里对流进行转化。
       * 我们还可以addError进去告诉后面有问题。
     然后我们监听transform之后的流，当转换好的event流出时，我们打印这个event，这个event就是我们刚才add进sink的数据。onError能够捕捉到我们add进去的err。
   */

}



// flutter函数中使用async,async*使得函数异步执行，两者的差别在于。
// async*返回Stream，并通过yield关键字生成Stream流的值
// 异步生成器
Stream<int> countForOneMinute() async* {
  for (int i = 1; i <= 60; i++) {
    await Future.delayed(const Duration(seconds: 1)); //延迟一秒
    yield i; //生成Stream的一个值
  }
}


Future<int> doSomeLongTask() async {
  await Future.delayed(const Duration(seconds: 1));
  return 42;
}
