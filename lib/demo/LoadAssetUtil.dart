import 'package:flutter/material.dart';

import 'dart:io';
import 'dart:async' show Future;
import 'package:flutter/services.dart' show rootBundle;



// 异步加载json数据
Future<String> loadContactsAsset() async {
  return await rootBundle.loadString('assets/data/contacts.json');
}


// Image, 图片显示Widget, 和Android ImageView相似，但是从实际使用的方法上看，
// 与常用的图片加载库，如Picasso，Glide等相似，支持本地图片，资源图片，网络图片等加载方式。

// 构造方法
// 方式	解释
// Image()	      通用方法，使用ImageProvider实现，如下方法本质上也是使用的这个方法
// Image.asset	  加载资源图片
// Image.file	    加载本地图片文件
// Image.network	加载网络图片
// Image.memory	  加载Uint8List资源图片


// image
// ImageProvider, 抽象类，需要自己实现获取图片数据的操作。
// 如下是常用的一些ImageProvider，当然自定义自己的ImageProvider也是OK的，实现方法，可以参考下面表中这些已经成熟使用的例子。
// ImageProvider:
// ExactAssetImage
// AssetImage
// NetworkImage
// FileImage
// MemoryImage

StatefulWidget loadImage() {

  // 使用ImageProvider加载网络图片
  StatefulWidget image = Image(image: NetworkImage("https://flutter.io/images/homepage/header-illustration.png"), width: 200.0,);

  // 加载网络图片
  Image.network('https://flutter.io/images/homepage/header-illustration.png');

  // 使用ImageProvider加载资源图片
  Image(image: AssetImage("images/star.jpg"), width: 100.0, color: Colors.greenAccent, colorBlendMode: BlendMode.colorBurn); // width属性没有效果？

  // 加载资源图片
  // Image显示区域的宽度和高度设置，这里需要把Image和图片两个东西区分开，图片本身有大小，Image Widget本身也是有大小的，
  // Image Widget是图片的容器。宽度和高度的配置经常和下面的fit属性配合使用。
  // BoxFit.cover 告诉框架，图像应该尽可能小，但覆盖整个渲染框
  Image.asset("images/avatar_circle.png", width: 100.0, fit: BoxFit.cover);

  // 加载本地文件图片 io库
  Image.file(File("/Users/gs/Downloads/1.jpeg"));

  return image;
}


// Image BoxFit
// BoxFit.fill: Box被完全填充，相当于ScaleType的FIT_XY
// BoxFit.contain: 保持Box的纵横比至至少有一边填充满父控件，相当于ScaleType的FIT_CENTER
// BoxFit.cover: 保持Box的纵横比进行缩放至Box完全填充满父控件，超出部分进行裁剪，相当于ScaleType的CENTER_CROP
// BoxFit.none: 不进行任何缩放操作
// BoxFit.fitWidth: 缩放Box宽直至填充满父控件，高度可能会被截断
// BoxFit.fitHeight: 缩放Box高直至填充满父控件，宽度可能会被截断
// BoxFit.scaleDown: Box大于父控件，则采用与contain一致的缩放模式，否则采用none缩放模式

// 图片即使设置了fit: BoxFit.cover不满屏的坑
// 在轮播图的时候由于要加一个立即体验的按钮，所以使用了Stack下面包含Container和Align
// 发现即使Image.asset中设置了fit: BoxFit.cover，一直不满屏，
// 最后在倒腾了好久后发现还需要在Image.asset增加
// width: double.infinity,
// height: double.infinity
// 这两个属性才可以满屏显示。


// color & colorBlendMode  Blend:混合
// color和colorBlendMode一般配合使用，BlendMode, 为混合模式的意思，包含如下诸多模式。类似于Android原生的PorterDuffXferMode
//
// clear: 清除所有内容
// src：只显示源图像
// dst：只显示目标图像
// srcOver：默认值。将src与dst进行组合，如果src和dst有重叠的地方，则以src内容覆盖与dst重叠的地方。
// dstOver：与srcOver相反
// srcIn：只显示src和dst重合部分，且dst的重合部分只有不透明度有用。
// dstIn：只显示src和dst重合部分，且src的重合部分只有不透明度有用。
// srcOut：显示src图像，但只显示src和dst的不重合部分，且重合部分只有dst是不透明的才算重合
// dstOut：显示dst图像，但只显示src和dst的不重合部分，且重合部分只有src是不透明的才算重合
// srcATop：将src与dst进行组合，但只组合src和dst重合部分，不重合部分显示dst
// dstATop：将src与dst进行组合，但只组合src和dst重合部分，不重合部分显示src
// xor：显示src和dst不重合部分，重合部分不显示
// plus：混合src和dst，其中src的颜色透明度降低
// modulate： 将src和dst重叠部分混合，使混合部分颜色相乘，这只能导致相同或更深的颜色(乘以白色，1.0，结果没有变化;乘以黑色，得到黑色)。
// screen： 将src图像和dst图像的分量的倒数相乘，并将结果的倒数相乘。
// overlay：将src图像和dst图像的组件相乘，然后调整它们以适应dst。
// darken：通过从每个颜色通道中选择最小值来组合源图像和目标图像。
// lighten： 通过从每个颜色通道中选择最大值来组合源图像和目标图像。输出图像的不透明度计算方法与[srcOver]相同。
// colorDodge：用src的倒数除以dst。反转组件意味着将完全饱和通道(不透明的白色)视为值0.0，而通常将值0.0(黑色、透明)视为值1.0。
// colorBurn：用dst函数的倒数除以src函数的倒数，然后求结果的倒数。反转组件意味着将完全饱和通道(不透明的白色)视为值0.0，而通常将值0.0(黑色、透明)视为值1.0。
// hardLight：将src图像和dst图像的组件相乘，然后对它们进行调整，使之有利于src。
// softLight: 对于小于0.5的src值使用[colorDodge]，对于大于0.5的src值使用[colorBurn]。
// difference: 从每个通道的大值中减去小值。合成黑色没有效果;合成白色使另一幅图像的颜色相反。输出图像的不透明度计算方法与[srcOver]相同。
// exclusion:从两个图像的和中减去两个图像的乘积的两倍。
// multiply:将src图像和dst图像的组件相乘，包括alpha通道。
// hue:取src图像的色调，以及dst图像的饱和度和亮度。
// saturation:取src图像的饱和度，以及dst图像的色调和亮度。
// color:取src图像的色调和饱和度，以及dst图像的亮度。
// luminosity:取src图像的亮度，以及dst图像的色调和饱和度。
//

// centerSlice
// 当图片需要被拉伸显示的时候，centerSlice定义的矩形区域会被拉伸，可以理解成我们在图片内部定义来一个点9文件用作拉伸。
// assert(sourceSize == inputSize, 'centerSlice was used with a BoxFit that does not guarantee that the image is fully visible.');
// 也就是说只有在显示大小大于原图大小的情况下，才允许使用这个属性，否则会报错。
//






















