import 'package:meta/meta.dart';
import 'package:redux/redux.dart';

/*
 * State中所有属性都应该是只读的
 */
@immutable
class CountState {

  final int _count;
  get count => _count;

  CountState(this._count);

  CountState.initState() : _count = 0;
}

/*
 * 定义操作该State的全部Action
 * 这里只有增加count一个动作
 */
enum Action { increment }

/*
 * reducer会根据传进来的action生成新的CountState
 */
CountState reducer(CountState state, action) {
  //匹配Action
  if (action == Action.increment) {
    return CountState(state.count + 1);
  }
  return state;
}


// 定义了一个中间件数组，包含2个中间件
final List<Middleware<CountState>> middleware = [
  CountMiddleware1(),
  CountMiddleware2(),
];

// 中间件1
class CountMiddleware1 implements MiddlewareClass<CountState> {
  @override
  void call(Store<CountState> store, dynamic action, NextDispatcher next) {
    print("中间件 1 开始执行了");
    if (action is Action) {
      print("中间件拦截到 ------ 增加count");
    }
    /// next看情况要不要执行
    /// 如果执行了，那后续的中间件和该action对应的逻辑都会执行
    /// 如果不执行，那就执行到这边就完了，后续的中间件和该action对应的逻辑都不会执行
    ///
    /// 注意：
    /// 执行过程跟 next() 这方法有关，代码在 next() 的前面和后面对输出结果都是有影响的
    /// 1.当Action对应的业务逻辑处理完后，会按中间件组的倒序来一个一个执行next()后面的方法
    /// 2.在中间件中，调用 dispatch 发送其他Action，会递归先处理新发出的 Action
    /// 3.中间也是处理异步操作的好地方，可以使用 async/await 将异步的代码优雅的用同步的方式来表示。
    /// 如果要在中间件中使用异步操作， 需要放在 next(action) 之后， 这样不会影响其他的中间件调用， 把异步的逻辑放到最后执行。
    /// redux_thunk插件能对异步更好的支持
    print("执行next方法，触发下一个中间件");
    next(action);
  }
}

// 中间件2
class CountMiddleware2 implements MiddlewareClass<CountState> {
  @override
  void call(Store<CountState> store, dynamic action, NextDispatcher next) {
    print("中间件 2 开始执行了");
    if(action is Action) {
      print("中间件拦截到 ------ 增加count");
    }
    next(action);
  }
}

