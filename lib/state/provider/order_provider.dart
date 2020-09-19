import 'package:flutter/material.dart';

///
///
/// Time:2020-09-18
/// ----------------------
/// description: 订单 发布者
///
class OrderProvider with ChangeNotifier {

  List<Order> orderList = List.generate(10, (index) => Order(false, 'Goods No. $index'));

  get listSize => orderList.length;

  collect(int index) {
    var order = orderList[index];
    orderList[index] = Order(!order.isCollection, order.goodsName);
    notifyListeners();
  }

  addAll(){
    orderList += List.generate(10, (index) => Order(false, 'Goods No. $index'));
    notifyListeners();
  }
}

class Order {
  final bool isCollection;
  final String goodsName;

  Order(this.isCollection, this.goodsName);
}