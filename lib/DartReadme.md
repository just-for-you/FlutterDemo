

### 编程语言并不是孤立存在的，Dart也是这样，他由语言规范、虚拟机、类库和工具等组成：
1.SDK：SDK 包含 Dart VM、dart2js、Pub、库和工具。
2.Dartium：内嵌 Dart VM 的 Chromium ，可以在浏览器中直接执行 dart 代码。
3.Dart2js：将 Dart 代码编译为 JavaScript 的工具。
4.Dart Editor：Studio全功能 IDE，并包含以上所有工具。支持代码补全、代码导航、快速修正、重构、调试等功能。



### dart 语言具特性:
1.一切变量皆是对象，每个对象都是类的实例。int、double、函数、 null 等都是对象，所有对象都继承自 Object 类
2.dart 是强类型语言，但由于具备类型推导功能所以类型声明是可选的
3.dart 支持顶级函数、静态函数、实例函数，也允许在函数中嵌套函数，即局部函数。类似的，dart 也支持顶级变量、静态变量和实例变量
4.dart 没有关于 public、protected、private 的关键字。通过为变量标识符添加下划线前缀，表明该标识符对其库是私有的

1.开发时 JIT，提升开发效率；发布时 AOT，提升性能。
2.不会面对 JS 与 Native 之间交互的问题了。
3.Dart 的内存策略，采用多生代算法（与 Node 有一些类似）。
4.线程模型依旧是单线程 Event Loop 模型，通过 isolate 进行隔离，可以降低开发难度（与 Node 也非常类似）。
5.Dart 的生态，这个跟 Node.js 差距十分明显，npm 还是行业中最活跃的。
6.而静态语法与排版方式，纯前端入门还是有一定成本。

* 多行注释和单行注释
* 以分号结尾且必需有
* 允许定义顶层函数
* 最基础的数据类型之一：String，其它的内置数据类型还有 int 、double、list、map 等
* 类型推导。通过关键字 var 来声明变量而无需指明变量类型
* 一种方便的插入变量值的方式，字符串字面值：$msg
* 应用程序的入口：main 函数



### Flutter 选择 Dart 的原因：
1.健全的类型系统，同时支持静态类型检查和运行时类型检查。
2.代码体积优化（TreeShaking），编译时只保留运行时需要调用的代码（不允许反射这样的隐式引用），所以庞大的 Widgets 库不会造成发布体积过大。
3.丰富的底层库，Dart 自身提供了非常多的库。多生代无锁垃圾回收器，专门为 UI 框架中常见的大量 Widgets 对象创建和销毁优化。
4.跨平台，iOS 和 Android 共用一套代码。
5.JIT & AOT 运行模式，支持开发时的快速迭代和正式发布后最大程度发挥硬件性能。
6.Native Binding。在 Android 上，v8 的 Native Binding 可以很好地实现，但是 iOS 上的 JavaScriptCore 不可以，
所以如果使用 JavaScript，Flutter 基础框架的代码模式就很难统一了。而 Dart 的 Native Binding 可以很好地通过 Dart Lib 实现。


### Flutter 的 UI 渲染方案：Skia
渲染方案是 Flutter 目前独特的设计形态，就是由于渲染自闭环，才能真正跨平台。
Skia 是一个用C++ 开发的、性能彪悍的2D绘图引擎库，其前身是一个向量绘图软件，Chrome 和 Android 均采用 Skia 作为绘图引擎。
Skia 提供了非常友好的 API，并且在图形转换、文字渲染、位图渲染方面都提供了友好、高效的表现。
Skia 是跨平台的，所以可以被嵌入到 Flutter 的 iOS SDK 中，而不用去研究 iOS 闭源的 CoreGraphics / Core Animation。
1.Flutter 底层的渲染能力得到了统一，不在需要使用做双端适配；
2.通过 OpenGL、GPU，不需要依赖原生的组件渲染框架。
3.Flutter 可以最大限度的抹平平台差异，提升渲染效率和性能。


### 绘制流程：
Flutter 渲染流程分为 7 个步骤：
1.用户操作：首先是获取到用户的操作
2.动画：然后你的应用会因此显示一些动画
3.构建：Flutter 开始构建 Widget 对象，Widget 对象构建完成后进入渲染阶段，这个阶段主要包括三步：4.5.6
4.布局元素：决定页面元素在屏幕上的位置和大小；
5.绘制阶段：将页面元素绘制成它们应有的样式；
6.合成阶段：按照绘制规则将之前两个步骤的产物组合在一起
7.光栅化:最后的光栅化由 Engine 层来完成。


### Flutter基础：

##### 1.main()函数 & runApp函数
main()函数中只调用runApp函数，使用runApp函数可以将给定的根控件填满整个屏幕。
你可能会有疑问，为什么一定要使用runApp函数？
如果不调用runApp函数，项目也可以正常执行，但是屏幕上什么都不会显示。
Flutter是Dart语言的移动应用框架，runApp函数就是Flutter框架的入口，如果不调用runApp函数，那你执行的就是一个Dart控制台应用。

##### 2.Flutter控件类
如果定义类时继承了StatelessWidget或StatefulWidget抽象类，说明该类是StatelessWidget或StatefulWidget抽象类的子类，即Flutter控件类。
在Flutter框架中，控件类又细分为有状态控件类（继承StatefulWidget抽象类）和无状态控件类（继承StatelessWidget抽象类），两者的差别在于是否有状态。

##### 3.在Flutter中，Widget是整个视图描述的基础，在Flutter的世界里，包括应用本身、视图、视图控制器、布局等在内的概念，都建立在Widget的基础之上。
Flutter的核心设计思想是：一切皆Widget。

##### 4.Widget
组件视觉效果的封装，是UI界面的载体，因此我们还需要为它提供一个方法，来告诉Flutter框架如何构建UI界面，这个方法就是build。
在build方法中，我们通常通过对基础Widget进行相应的UI配置，或是组合各类基础Widget的方式进行UI的定制化。比如在MyApp中，我通过MaterialApp这个Flutter APP框架设置了应用首页，即Scaffold。

##### 5.MaterialApp
一个方便的Widget，是用于构建Material设计风格应用的组件封装框架，它封装了应用程序级别的一些Widget。一般作为顶层Widget来使用。
其常用的属性如下：
home，主页，即应用的首页
title，标题
color，颜色
theme，主题

##### 6.Scaffold
Material Design布局结构的基本实现。此类提供了用于显示drawer、snackbar和底部sheet的API。
Scaffold有下面几个主要属性：
appBar，显示在界面顶部的一个AppBar，即页面的导航栏
body，当前界面所显示主要内容的widget
drawer，抽屉菜单控件





### Flutter工程的目录结构

android——包含Android特定文件的Android子工程
ios——包含iOS特定文件的iOS子工程
build——是运行项目的时候生成的编译文件，即Android和iOS的构建产物
lib——Flutter应用源文件目录，我们自己写的Dart文件都放进lib文件夹中
test——测试文件
pubspec.yaml——管理第三方库及资源的配置文件



### 命令式 & 声明式

1.有原生Android和iOS框架开发经验的同学，可能更习惯命令式的UI编程风格：手动创建UI组件，在需要更改UI时调用其方法修改视觉属性。
而Flutter采用声明式UI设计，我们只需要描述当前的UI状态（即State）即可，不同UI状态的视觉变更由Flutter在底层完成。

2.虽然命令式的UI编程风格更直观，但是声明式UI编程方式的好处是:
可以让我们把复杂的视图操作细节交给框架去完成，这样一来不仅可以提高我们的效率，也可以让我们专注于整个应用和页面的结构和功能。



### dart2.6
##### 1.使用dart2native编译命令行应用程序
dart2native可以用于构建和部署命令行程序。通常会使用诸如：dart:io(基本I/O)、package:http(网络操作)、package:args(参数解析)之类的库。

##### 2.dart2native对dart:ffi的增强及兼容
native应用程序通常需要从操作系统访问本地API功能。这些系统api通常在本地的基于C的库中存在，
而Dart通过dart:ffi 支持与这些库的互交互性，这是Dart 2.5的预览版中推出的Dart与C交互的新功能。

Dart2.6对许多dart:ffi的API进行了重大更改，
使我们的API易于使用，提供更多的类型安全性并提供对内存的便捷访问。
dart2native编译器与dart:ffi兼容，因此您可以创建和编译使用它的本地的dart应用程序。

Dart的某位团队成员最近开始使用dart:ffi创建了一个用于控制台应用程序开发的dart_console库(https://pub.dev/packages/dart_console)，
它具有诸如获取窗口尺寸、读取和设置光标位置、管理颜色、读取键和控制序列等功能。
使用dart的能力:ffi使dart成为一种非常强大的控制台应用程序语言。dart_console是Kilo文本编辑器的Dart版本实现。
Kilohttps://github.com/antirez/kilo库使用C语言编写而成，大约有1000行代码。

##### 3.使用少于500行的代码编写7M的代码编辑器
使用Dart核心库、dart:ffi 和 dart_console 库，我们可以创建非常有趣的控制台应用程序。
dart_console库包括一个完整的 Kilo 演示，这是一个用大约500行Dart代码编写的控制台文本编辑器。
使用新的dart2native编译器，我们可以轻松地打包它，最后得到一个7MB的self-contained代码编辑器。

##### 4.dart2native的服务端构建性能大大提升
对于无服务器后端，服务快速启动至关重要。传统上，基于Dart的服务与我们的JIT（即时）编译器一起运行，但是基于JIT的执行在启动时会存在较高的延迟，
因为需要对其进行编译和预热后才能开始执行代码。通过将服务的代码提前编译为native代码，您可以避免这种延迟并立即开始运行。
此外，使用native代码，您可以创建具有较小磁盘占用空间且独立的Dart services，从而大大减小了运行Dart services的容器的大小。
实验表明，使用dart2native编译器，能够将Docker镜像的大小减少91％，从使用JIT编译的220MB的代码减少至使用native编译的20MB的代码！

##### 5.令人兴奋的新语言功能 “静态扩展方法”的预览版本
该功能允许像在特殊静态类型的表达式的实例成员一样，调用特别声明的静态函数。但是此功能仍然需要完善，官方也表示在下一个Dart SDK版本中将会正式启动这个功能。

##### 6.暂时还未解决的问题
6.1.dart2.6 不提供交叉编译支持
dart2native编译器仅支持为其运行的操作系统创建native代码。因此，如果要为macOS，Windows和Linux上这三个平台的程序创建可执行文件，
则需要分别在各个平台运行该编译器。一种实现方法是使用能够同时支持三种操作系统的CI（连续集成）程序。

6.2.不支持签名
生成的可执行文件使用的格式与标准签名工具（例如codesign和signtool）不兼容。

6.3.不支持 dart:mirrors(反射) 和 dart:developer这两个库。



