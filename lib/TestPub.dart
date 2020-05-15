
import 'package:xml/xml.dart' as xml;

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










