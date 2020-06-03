// 自定义计算器库
library calculator_lib;

import 'dart:math';

//import statement after the libaray statement
int add(int firstNumber, int secondNumber) {
  print("inside add method of Calculator Library ");
  return firstNumber + secondNumber;
}

// 取余
int modulus(int firstNumber, int secondNumber) {
  print("inside modulus method of Calculator Library ");
  return firstNumber % secondNumber;
}

//取随机数
int random(int no) {
  return new Random().nextInt(no);
}
