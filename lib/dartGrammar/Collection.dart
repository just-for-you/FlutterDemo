import 'dart:collection';

/// dart 集合【重要】
///
/// 与其他编程语言不同，Dart不支持数组。
/// Dart集合可用于复制数组结构等数据结构。dart:core库和其他类在Dart脚本中启用集合支持。
///
/// Dart集合归类：
/// 1.List: List只是一组有序的对象。dart:core库提供了List类，可以创建和操作列表。
/// 2.Set: Set表示对象的集合，其中每个对象只能出现一次。dart:core库提供了Set类来实现相同的功能。
/// 3.Map: Map对象是一个简单的键/值对。映射中的键和值可以是任何类型。映射是动态集合。
/// 换句话说，Maps可以在运行时增长和缩小。dart:core库中的Map类提供了相同的支持。
/// 4.Queue:队列是一个可以在两端操纵的集合。当想要构建先进先出集合时，队列非常有用。
/// 简而言之，队列从一端插入数据并从另一端删除。按插入顺序删除/读取值。

main() {
  print("============= 1.List列表 ===========");

  //固定长度列表 - 列表的长度不能在运行时更改。
  //可增长列表 - 列表的长度可以在运行时更改。
  List logTypes = List();
  logTypes.add("WARNING");
  logTypes.add("ERROR");
  logTypes.add("INFO");
  logTypes.add("DEBUG");
  print(logTypes); //[WARNING, ERROR, INFO, DEBUG]
  print(logTypes.runtimeType);//List<dynamic>
  for (String type in logTypes) {
    print(type);
  }
  print(logTypes.length); //4
  logTypes.removeRange(1, 2); ////删除索引从1-2的元素 含头不含尾
  logTypes
      .removeWhere((element) => element == 'WARNING'); //条件只有一个表达式时，可以用箭头函数简化写法
  logTypes.insert(1, "element");
  print(logTypes.length); //3
  print(logTypes.isEmpty);
  print(logTypes.isNotEmpty);
  print(logTypes
      .reversed); //(DEBUG, element, INFO) 返回一个List的倒序排列的Iterable  不改变原List
  logTypes.forEach((element) {
    //遍历每个元素  此时不可add或remove  否则报错 但可以修改元素值，
    print(element);
  });
  //非常强大的list
  //logTypes.reduce(combine),takeWhile,take,skip,skipWhile,where,sublist,join,retainWhere
  // singleWhere,whereType,cast(),expand(),toSet(),asMap(),shuffle(),sort(),every,any

  var list;
  var list2 = [0, ...?list]; //空感知拓展运算符
  assert(list2.length == 1);

  var list3 = list2.followedBy(logTypes);//followedBy:将自身和参数内list合成一个List
  print(list3);//(0, INFO, element, DEBUG)

  List testList = List();
  testList.add("Test");
  //var list4 = List()..add("Test")..followedBy([5,6]);//这样写有问题
  var list4 = testList.followedBy(logTypes);
  print(list4);//(Test, INFO, element, DEBUG)

  //Dart 2.3还引入了if和collection的集合，使用它在条件(if)和重复(for)构建集合。
  bool promoActive = true;
  var nav = ['Home', 'Furniture', 'Plants', if (promoActive) 'Outlet'];
  print(nav); //[Home, Furniture, Plants, Outlet]

  List listOfInts = [6, 3, 7];
  List listOfStrings = ['#0', for (var i in listOfInts) '#$i'];
  print(listOfStrings); //[#0, #6, #3, #7]

  print("============= 2.Set集合 ===========");

  Set numberSet = Set();
  numberSet.add(100);
  numberSet.add(20);
  numberSet.add(5);
  numberSet.add(60);
  numberSet.add(70);
  print(
      "Default implementation : ${numberSet.runtimeType}"); //_CompactLinkedHashSet<dynamic>
  for (var no in numberSet) {
    print(no);
  }

  Set numberSet2 = Set.from([12, 13, 14]);
  print(
      "Default implementation : ${numberSet2.runtimeType}"); //_CompactLinkedHashSet<dynamic>
  for (var no in numberSet2) {
    print(no);
  }
  print(numberSet2); //{12, 13, 14}

  //空集合
  var halogens = {'yiibai.com', 'chlorine', 'bromine', 'iodine', 'astatine'};
  var names = <String>{};
  Set<String> names2 = {};
  names.add('fluorine');
  names.addAll(halogens);
  assert(names.length == 6);

  //编译时常量的集合
  final constantSet = const {
    'fluorine',
    'chlorine',
    'bromine',
    'iodine',
    'astatine'
  };
  print(constantSet); //{fluorine, chlorine, bromine, iodine, astatine}

  print("============= 3.Map映射/字典 ===========");

  var gifts = {
    // Key:    Value
    'first': 'partridge',
    'second': 'turtledoves',
    'fifth': 'golden rings'
  };
  print(gifts); //{first: partridge, second: turtledoves, fifth: golden rings}

  var details = Map();
  details['Usrname'] = 'admin';
  details['Password'] = 'admin@yiibai.com';
  assert(details.length == 2);
  print(details); //{Usrname: admin, Password: admin@yiibai.com}

  //编译时常量的映射
  final constantMap = const {
    2: 'helium',
    10: 'neon',
    18: 'argon',
  };
  print(constantMap); //{2: helium, 10: neon, 18: argon}

  print("============= 4.Queue队列 ===========");

  Queue queue = new Queue();
  print("Default implementation ${queue.runtimeType}"); //ListQueue<dynamic>
  queue.add(10);
  queue.add(20);
  queue.add(30);
  print(queue); //{10, 20, 30}
  /*
  * add()函数可用于将值插入队列。此函数将指定的值插入队列末尾。
  * addAll()函数允许一次向队列添加多个值，此函数采用可迭代的值列表。
  * addFirst()方法将指定的值添加到队列的开头。此函数传递一个对象，该对象表示要添加的值。
  * addLast()函数将指定的对象添加到队列的末尾。
  * */
  queue.addAll([100, 200, 300]);
  print("Printing queue.. $queue"); //{10, 20, 30, 100, 200, 300}
  queue.addFirst(900);
  queue.addLast(700);
  print("Printing Q.. $queue"); //{900, 10, 20, 30, 100, 200, 300, 700}

  print("============= 迭代集合 ===========");

  //dart:core库的Iterator类可以进行集合遍历。每个集合都有一个迭代器属性。此属性返回指向集合中对象的迭代器。
  //moveNext()函数返回一个布尔值，指示是否存在后续条目。
  Iterator i = queue.iterator;
  while (i.moveNext()) {
    print(i.current);
  }

  print("============= 高级Dart集合 ─ dart:collection 库 ===========");
  print("============= HashMap ===========");

  //HashMap是基于哈希表的Map实现。当遍历HashMap的键或值时不能指定顺序。
  var accounts = new HashMap();
  accounts['name'] = 'Maxsu';
  accounts.addAll({'dept': 'HR', 'email': 'maxsu@xyz.com'});
  print(accounts); //{email: maxsu@xyz.com, dept: HR, name: Maxsu}
  accounts.remove('dept');
  print(accounts); //{email: maxsu@xyz.com, name: Maxsu}
  accounts.clear();
  print(accounts); //{}

  print("============= HashSet ===========");
  //HashSet是一种基于无序散列表的Set实现。
  Set numberSet5 = HashSet();
  numberSet5.add(100);
  numberSet5.add(20);
  numberSet5.add(5);
  print(numberSet5); //{20, 100, 5}
  for (var no in numberSet5) {
    print(no);
  }
  numberSet5.addAll([200, 300]);
  print(numberSet5); //{200, 300, 20, 100, 5}
  numberSet5.remove(100);
  print(numberSet5); //{200, 300, 20, 5}
  numberSet5.clear();
  print(numberSet5); //{}
}
