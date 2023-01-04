import 'dart:io';
import 'dart:typed_data';

import 'package:crop_your_image/crop_your_image.dart';
import 'package:flutter/material.dart';
import 'package:kommon/kommon.dart';

/// Author: Kingtous
/// Date: 2021/8/26
/// Mail: me@kingtous.cn

/// 图像裁剪
class ImageCropScreen extends StatelessWidget {
  final String path;
  final String titleText;
  final String cropText;
  final Function(Uint8List)? onCropped;

  const ImageCropScreen(
      {Key? key,
      required this.path,
      this.onCropped,
      this.titleText = "裁剪图像",
      this.cropText = "裁剪"})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final f = File(path);
    final controller = CropController();
    return Scaffold(
        appBar: BrnAppBar(title: titleText),
        body: Column(
          children: [
            Expanded(
              child: FutureBuilder(
                  key: const ValueKey(0),
                  future: f.readAsBytes(),
                  builder: (BuildContext c, AsyncSnapshot<Uint8List> d) {
                    if (d.hasData) {
                      return Crop(
                          controller: controller,
                          image: d.data!,
                          initialSize: 0.5,
                          onCropped: (img) {
                            _handleImageCrop(img);
                          });
                    } else {
                      return const CircularProgressIndicator();
                    }
                  }),
            ),
            _buildOperBar(context, controller)
          ],
        ));
  }

  void _handleImageCrop(Uint8List img) {
    onCropped?.call(img);
    Get.back(result: img);
  }

  _buildOperBar(BuildContext context, CropController controller) {
    final cropStatus = false.obs;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          children: [
            Expanded(
                child: Obx(
              () => Padding(
                padding: const EdgeInsets.all(8.0),
                child: GFButton(
                  onPressed: cropStatus.value
                      ? null
                      : () {
                          controller.crop();
                          Future.delayed(const Duration(seconds: 3), () {
                            cropStatus.value = true;
                          });
                        },
                  text: cropText,
                  shape: GFButtonShape.pills,
                ),
              ),
            ))
          ],
        ),
      ],
    );
  }
}
