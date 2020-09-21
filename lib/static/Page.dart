

// 使用 static 关键字来实现 类级别的变量和函数
//
// 静态成员不能访问非静态成员（ static 关键字修饰的成员 不能访问 非 static 关键字修饰的成员）
// 非静态成员可以访问静态成员
// 类中的常量是需要使用 static const 声明

class Page {

  // 添加 static 关键字
  static int currentPage = 1;

  // 添加 static 关键字
  static const int maxPage = 10;

  static void scrollDown(){
    currentPage = 1;
    print("ScrollDown...");
  }

  void scrollUp(){
    currentPage ++;
    print("ScrollUp...");
  }

}


void main(List<String> args) {
  var page = new Page();
}

