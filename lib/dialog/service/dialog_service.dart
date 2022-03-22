import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DialogService extends GetxService {
  Future<DialogService> init() async {
    return this;
  }

  Future<String> inputDialog(
      {String title = "请输入文字", Function(String text)? onText}) async {
    var text = "";
    await Get.defaultDialog(
        title: title,
        content: Row(
          children: [
            Expanded(child: TextField(
              onChanged: (s) {
                text = s;
              },
            ))
          ],
        ),
        onCancel: () {
          text = "";
        },
        textConfirm: "确定",
        textCancel: "取消",
        onConfirm: () {
          onText?.call(text);
          Get.back();
        });
    return text;
  }
}
