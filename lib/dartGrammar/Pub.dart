
import 'package:xml/xml.dart' as xml; //xml解析包


/// 【Dart包管理】
/// 包是一种封装一组编程单元的机制
/// 应用程序有时可能需要集成某些第三方库或插件。
/// 每种语言都有一种机制来管理外部软件包，如Maven或Gradle for Java，Nuget for .NET，npm for Node.js等. Dart的软件包管理器是pub
///
/// Pub有助于在存储库中安装包。托管软件包的存储库可以在 https://pub.dartlang.org/ 找到。
/// 包元数据在文件pubsec.yaml中定义。YAML是Yet Another Markup Language的缩写。pub工具可用于下载应用程序所需的所有各种库。

/// pub: https://www.dartcn.com/tools/pub/

void main() {

  print("-------------- start parse xml -----");
  var bookshelfXml = '''<?xml version = "1.0"?> 
   <bookshelf> 
      <book> 
         <title lang = "english">Growing a Language</title> 
         <price>29.99</price> 
      </book> 
      <book> 
         <title lang = "english">Learning XML</title> 
         <price>39.95</price> 
      </book> 
      <price>132.00</price> 
   </bookshelf>''';

  var document = xml.parse(bookshelfXml);
  print(document.runtimeType);//XmlDocument
  print(document.toString());

}










