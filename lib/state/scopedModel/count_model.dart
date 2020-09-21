
import 'package:scoped_model/scoped_model.dart';


/*
*
* 在Scoped中，Model是一个只包含与状态相关信息的单位。我们应该把状态数据与操作数据的方法抽象出来封装到Model中。
*
* 我们需要让我们自定义的CountModel继承至Model。
* 在状态发生变化时（increment）通知所有用到了该model的子项更新状态。(notifyListeners)
*
* Listenable是Flutter框架自带的抽象接口，主要用来提供添加和移除观察者对象的接口
*/
class CountModel extends Model {

  int _count = 0;
  get count => _count;

  void increment(){
    _count++;
    notifyListeners();
  }

  CountModel of(context) =>
      ScopedModel.of<CountModel>(context);

}