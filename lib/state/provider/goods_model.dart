import 'package:flutter/material.dart' show ChangeNotifier;

// 物品 发布者
class GoodsListProvider with ChangeNotifier {

  bool shouldRebuild = false;

  // 生成数据
  List<Goods> _goodsList = List.generate(10, (index) => Goods(false, 'Goods No. $index'));

  get goodsList => _goodsList;
  get total => _goodsList.length;

  // 收藏
  collect(int index) {
    var good = _goodsList[index];
    _goodsList[index] = Goods(!good.isCollection, good.goodsName);
    notifyListeners();
  }

  // 添加全部
  addAll(){
    _goodsList.addAll(List.generate(10, (index)=>Goods(false, 'Goods No. $index')));
    shouldRebuild = true;
    notifyListeners();
  }

  rebuild(){
    shouldRebuild = false;
  }

}

class Goods {
  final bool isCollection;
  final String goodsName;

  Goods(this.isCollection, this.goodsName);
}
