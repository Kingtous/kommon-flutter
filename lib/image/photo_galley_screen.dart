import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:photo_view/photo_view_gallery.dart';

/// Author: Kingtous
/// Date: 2021/7/3
/// Mail: me@kingtous.cn

class PhotoGalleyScreen extends StatelessWidget {
  final List<ImageProvider> photos;
  final int initialIndex = 0;
  late final PageController _pageController;
  final page = 0.obs;

  // 配合OpenContainer使用实现联动点击关闭效果
  final Function()? closeFunc;

  PhotoGalleyScreen(
      {Key? key, required this.photos, int initialIndex = 0, this.closeFunc})
      : super(key: key) {
    _pageController = PageController(initialPage: initialIndex);
    page.value = initialIndex;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Stack(
          children: [
            PhotoViewGallery.builder(
              pageController: _pageController,
              itemCount: photos.length,
              onPageChanged: (page) {
                this.page.value = page;
              },
              builder: (BuildContext context, int index) {
                return PhotoViewGalleryPageOptions(
                    onTapUp: (_, __, ___) {
                      closeFunc?.call();
                    },
                    imageProvider: photos[index]);
              },
            ),
            Align(
              alignment: Alignment.topLeft,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                      onTap: () {
                        Get.back();
                      },
                      child: Container(
                        decoration: BoxDecoration(color: Colors.black12),
                        padding: const EdgeInsets.all(4.0),
                        child: Icon(
                          Icons.chevron_left,
                          color: Colors.white,
                          size: 40,
                        ),
                      )),
                  Container(
                    decoration: BoxDecoration(color: Colors.black12),
                    padding: const EdgeInsets.all(8.0),
                    child: Obx(
                      () => Text(
                        "${page.value + 1}/${photos.length}",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
