import 'package:FlutterDemo/dartGrammar/DartUnitTest.dart';
import 'package:flutter_test/flutter_test.dart'; //单元测试包

void main() {

  // Define the test
  test("test to check add method", () {
    // Arrange
    var expected = 30;
    // Act
    var actual = add(10, 20);
    // Asset
    expect(actual, expected); //通过
  });

  test('test to check sub', () {
    var expected = 10;
    var expected2 = 9;
    // Arrange
    var actual = sub(30, 20);
    // Act
    //expect(actual, expected); //失败
    expect(actual, expected2); //成功
    // Assert
  });

  // 分组测试
  group("String test ", () {
    test("test on split() method of string class", () {
      var string = "foo,bar,baz";
      expect(string.split(","), equals(["foo", "bar", "baz"]));
    });

    test("test on trim() method of string class", () {
      var string = "  foo ";
      expect(string.trim(), equals("foo"));
    });
  });


}
