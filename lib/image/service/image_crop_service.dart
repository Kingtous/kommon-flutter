import 'dart:io';
import 'dart:typed_data';

import 'package:get/get.dart';
import 'package:kommon/image/image_crop_screen.dart';

/// Author: Kingtous
/// Date: 2021/8/26
/// Mail: me@kingtous.cn

class ImageCropService extends GetxService {
  Future<ImageCropService> init() async {
    return this;
  }

  Future<Uint8List?> cropImageWithFile(File file) async {
    if (await file.exists()) {
      return null;
    }
    final path = file.path;
    return cropImageWithPath(path);
  }

  Future<Uint8List?> cropImageWithPath(String path) async {
    return await Get.to(() => ImageCropScreen(path: path));
  }
}
