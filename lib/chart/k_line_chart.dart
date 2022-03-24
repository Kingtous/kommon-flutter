// import 'dart:collection';
//
// import 'package:bruno/bruno.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
//
// class KLineChart extends StatelessWidget {
//
//   final double? width;
//   final double? height;
//   final List<double> x;
//   final List<double> y;
//   final dynamic Function(int x,int y)? onTouchData;
//
//
//   const KLineChart({Key? key, this.width, this.height,
//     required this.x, required this.y,
//     this.onTouchData}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return BrnBrokenLine(
//         size: Size(width ?? Get.width,height ?? 300),
//         isShowYDialText: true,
//         isShowXDialText: true,
//         showPointDashLine: true,
//         isHintLineSolid: false,
//         xDialValues: [
//           BrnDialItem(value: 1.5,dialText: "test",
//               dialTextStyle: const TextStyle(
//                 // fontSize: 30.sp,
//                   color: Colors.black
//               )
//           )
//         ],
//         yDialValues: [
//           BrnDialItem(value: cnt / 2 ,dialText: "${(cnt /2).toInt() }",
//               dialTextStyle: const TextStyle(
//                   color: Colors.black
//               ))
//         ],
//         lines: [
//           BrnPointsLine(
//               isShowXDial: true,
//               // isShowPointText: true,
//               isCurve: true,
//               lineWidth: 3,
//               pointRadius: 4,
//               lineColor: Colors.orangeAccent,
//               shaderColors: [Colors.orangeAccent.withOpacity(0.5),Colors.orangeAccent.withOpacity(0.2),
//                 Colors.orangeAccent.withOpacity(0.1)],
//               points: data.map((e) {
//                 index++;
//                 return BrnPointData(
//                   lineTouchData:
//                   BrnLineTouchData(tipWindowSize: const Size(100, 50),onTouch: (){
//                     return '$e';
//                   }),
//                   x: (index).toDouble(),
//                   y: data[index].toDouble(),
//                 );
//               }).toList(growable: false))
//         ],
//         xDialMin: 1,
//         xDialMax: days,
//         yDialMin: 0,
//         yDialMax: cnt);
//   }
// }
