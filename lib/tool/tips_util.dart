import 'dart:io';

import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:kommon/kommon.dart';
import 'package:oktoast/oktoast.dart';

class Tips {
  /// tosat常规提示
  static Future<bool?> info(String text,
      {ToastGravity gravity = ToastGravity.BOTTOM,
      BuildContext? context}) async {
    if (Platform.isAndroid || Platform.isIOS) {
      return Fluttertoast.showToast(
        msg: text,
        toastLength: Toast.LENGTH_SHORT,
        gravity: gravity, // 提示位置
        fontSize: 18, // 提示文字大小
      );
    } else {
      // fallback
      BrnToast.show(text, context ?? Get.context!);
      return true;
    }
  }

  static Future<bool?> infoWidget(Widget widget,
      {BuildContext? context}) async {
    showToastWidget(widget, context: context);
    return true;
  }
}
