
/*
* Q&A
*
* 1. 这里看上去似乎只添加了一个model，我应该如何添加多个model
* 使用Mixin！class MainModel extends Model with AModel,BModel,CModel{}
*
* 2.Scoped是如何做到同步不同页面中的状态的
* abstract class Model extends Listenable {
* Model实现了Listenable接口，并重写了void addListener(VoidCallback listener)，removeListener(VoidCallback listener)方法，实现了观察者模式。
* 每当我们调用notifyListeners()方法时，将会通知观察者更新状态。
*
* 3.Scoped如何做到数据能够互相共享的
* 在不同页面间的数据传递使用了InheritedWidget。
*
* 4.侵入性
* 由于Model必须继承至Model类，所以它就具有了侵入性。以后假如不用scoped进行状态管理那么必然会带来需要更改多处代码的情况。这并不是我们希望看到的结果。
*
*
*/