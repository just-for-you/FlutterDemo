
/// 【Dart 单元测试】
///
/// 单元测试涉及测试应用程序的每个单元。它可以帮助开发人员在不运行整个复杂应用程序的情况下测试小功能。
/// 名为“test”的Dart外部库提供了编写和运行单元测试的标准方法。
///

// Function to be tested
int add(int x, int y) {
  return x + y;
}

int sub(int x,int y){
  return x-y-1;
}

void main() {

  // Dart单元测试涉及以下步骤 -
  // 第1步：安装 test 包
  // 要在当前项目中安装第三方软件包，需要pubspec.yaml文件。要安装 text 包，首先在pubspec.yaml文件中进行以下输入 -
  // dependencies:
  // test: ----> 试了下不需要，需要的是flutter_test
  // 输入后，右键单击pubspec.yaml文件并获取依赖项。它将安装 test 包。
  // 第2步：导入 test 包
  // 第3步，编写测试

  // 参考：test.dart
  // 注意：
  // 1.使用顶级函数test()指定测试，而使用expect()函数进行测试断言。
  // 2.group()函数可用于对测试进行分组。每个组的描述都会添加到测试描述的开头。

}

