import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/*
* 字符串的定义：
* 使用三个引号创建多行字符串，或者单引号中内容加‘ \n ’也能实现创建多行字符串
* 在字符串前加‘r’实现创建原始字符串，不会被转义，直接输出原始定义的字符串
*
* 字符串的运算：“+”，“*”，“==”，“[]”
* "+":字符串的拼接
* "*":乘法运算：字符串按因子n次重复 e.g:String str4 = 'ab', String str5 = str4*3 => str5 = 'ababab';
* "==":等号运算：判断两个字符串是否相等，返回bool值，str1==str2=>true或false；
* “[]”:取值运算：取出字符串索引位指向的单个字符，String str1 = 'abcde'，str1[1]=>'b';
*
* 字符串的常用方法：
* 1.contains(var)：判断字符串是否包含var
* 2.subString()：字符串截取
* 3.startsWith(var)：判断字符串是否以var的字符串起始
* 4.endsWith(var)：判断字符串是否以var的字符串结束
* 5.indexOf(var)：获取var在字符串的第一个位置索引值，如果没找到返回-1
* 6.lastIndexOf()：获取var在字符串的倒序第一个位置的索引值，如果没找到返回-1，
* 7.toLowerCase()：将字符串小写处理
* 8.toUpperCase()：将字符串大写处理
* 9.trim():将字符串两边去除空格处理
* 10.trimLeft():将字符串的左边空格去除
* 11.trimRight():将字符串的右边空格去除
* 12.split(var)：将字符串按照var分割成数组
* 13.replaceXXX()：字符串的替换操作
*
*
*/

/*
* 在开发中 很多时候会遇到使用本地资源 和 网络资源的情况，使用 RegExp对象 做正则表达式判断 可以减少很多重复的代码，
*/

/// 缩略图 item
/// 使用正则表达式 判断资源类型
/// [network],[file],[asset] 三种
Widget createImageVideoItem(dataSource) {
  /// 使用正则判断资源类型
  final netRegx = RegExp(r'^(http|https):\/\/([\w.]+\/?)\S*');
  final fileRegx = RegExp(r'^(file):\/\/([\w.]+\/?)\S*');
  final isNetwork = netRegx.hasMatch(dataSource);
  final isFile = fileRegx.hasMatch(dataSource);

  if (isNetwork) {
    return Image.network(dataSource);
  } else if (isFile) {
    return Image.file(dataSource);
  } else {
    return Image.asset(dataSource);
  }
}

void main() {
  // [...] 匹配中括号内所有字符
  isABC('A1234656B123456C'); //true
  isMatch('123阿范德萨范德萨'); //false

  // [^...] 匹配除开中括号内所有字符
  isMatch2('@#%()+-');
  isMatch2('中级#初级@资深*专家');
}

/*
* 1、匹配所有字符ABC（字符串中是否包含ABC所有字符中任意一个字符）
* 至少包含一个字符为true，否则为false
*/
void isABC(String input) {
  RegExp mobile = RegExp(r'[ABC]');
  bool isAbc = mobile.hasMatch(input);
  print("是否包含ABC中任意字符：${isAbc}"); //true
}

/*
* 2.匹配字符串#@￥%&*()-+（字符串中是否包含#@￥%&*()-+所有字符串中任意一个字符）
*/
void isMatch(String input) {
  RegExp regExpStr = RegExp(r'[#@￥%&*()-+]');
  bool isContainer = regExpStr.hasMatch(input);
  print("'${input}' 是否包含字符串：'#@￥%&*()-+' 中任意一个字符 ${isContainer}");
}

/*
* 3、匹配除开字符串 #@￥%&*()-+ 以外的其他字符串（字符串中是否包含除开#@￥%&*()-+所有字符串以外的其他字符）
* 至少包含除开字符串 #@￥%&*()-+ 任意字符的之外字符串
* */
void isMatch2(String input) {
  RegExp regExpStr = RegExp(r'[^-#@￥%&*()+]');
  bool isContainer = regExpStr.hasMatch(input);
  print("'${input}' 是否包含除开字符串：'#@￥%&*()-+' 中任意一个字符 ${isContainer}\n");
}

/*
* 4.忽略特殊字符
*/
class IgnoreOtherFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    const _regExp = r"^[\u4E00-\u9FA5A-Za-z0-9_]+$";
    if (newValue.text.length > 0) {
      if (RegExp(_regExp).firstMatch(newValue.text) != null) {
        return newValue;
      }
      return oldValue;
    }
    return newValue;
  }
}

/*
* 5.只能输入数字和小写字母
*/
class OnlyInputNumberAndLowWorkFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    const _regExp = r"^[Za-z0-9_]+$";
    if (newValue.text.length > 0) {
      if (RegExp(_regExp).firstMatch(newValue.text) != null) {
        return newValue;
      }
      return oldValue;
    }
    return newValue;
  }
}

/*
* 6.只能输入数字和字母
*/
class OnlyInputNumberAndWorkFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    const _regExp = r"^[ZA-ZZa-z0-9_]+$";
    if (newValue.text.length > 0) {
      if (RegExp(_regExp).firstMatch(newValue.text) != null) {
        return newValue;
      }
      return oldValue;
    }
    return newValue;
  }
}

/*
* 7.只能输入数字
* WhitelistingTextInputFormatter.digitsOnly;
*/

/*
* 8.长度限制(限制6位)
* LengthLimitingTextInputFormatter(6)
*/

/*
* 9.限制单行
* BlacklistingTextInputFormatter.singleLineFormatter
*/

/*
* 10.手机号验证
*/
bool isChinaPhoneLegal(String str) {
  return RegExp(r"^1([38][0-9]|4[579]|5[0-3,5-9]|6[6]|7[0135678]|9[89])\d{8}$")
      .hasMatch(str);
}

/*
* 11.邮箱验证
*/
bool isEmail(String str) {
  return RegExp(r"^\w+([-+.]\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*$").hasMatch(str);
}
