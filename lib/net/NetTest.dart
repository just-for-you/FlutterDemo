import 'package:dio/dio.dart';
import 'dart:io';
import 'dart:convert';


//原始网络请求，繁琐不方便，网上有很多关于网络请求的封装
//参考：https://flutterchina.club/networking/
void getDataByHttpClient() async {

  //1.创建 client.
  //2.构造 Uri.
  //3.发起请求, 等待请求，同时您也可以配置请求headers、 body.
  //4.关闭请求, 等待响应.
  //5.解码响应的内容.

  //接口地址
  const url = "http://www.easy-mock.com/mock/5d4a9adec10f57576cca530f/example/localtest";
  //const url = "http://apimanage.58corp.com/mock/5e7ea1517115d60305523abf";
  //const url = "https://huangyeapi.58.com/app/api/productDetail/";
  var httpClient = HttpClient();
  try {
    print(url);
    var request = await httpClient.getUrl(Uri.parse(url));
    var response = await request.close();
    print("==========================statusCode===========================");
    print(response.statusCode);
    if (response.statusCode == HttpStatus.ok) {
      print("===========ok");
      var responseBody = await response.transform(utf8.decoder).join();//返回值，字符串
      print(responseBody);
      //字符串需要转化为JSON
      var json = jsonDecode(responseBody);
      print("======================json===============================");
      print(json);

      int.parse("");
      double.parse("");
      12.toString();
      String piAsString = 3.14159.toStringAsFixed(2);
      assert(piAsString == '3.14');
    } else {
      print("===========not ok");
    }
  } catch(exception) {

  }

  //dio库
  try {
    Response response = await Dio().get(url);
    print("======================dio===============================");
    print(response.data.toString());
  } catch (e) {
    print(e);
  }
}






