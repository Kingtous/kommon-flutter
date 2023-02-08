import 'package:animations/animations.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';

import 'photo_galley_screen.dart';

/// Author: Kingtous
/// Date: 2021/8/4
/// Mail: me@kingtous.cn

class ImgView extends StatelessWidget {
  final String url;
  final BoxFit fit;
  final double? width;
  final double? height;
  final bool clickToView;

  const ImgView(
      {Key? key,
      required this.url,
      this.fit = BoxFit.contain,
      this.width,
      this.height,
      this.clickToView = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final img = CachedNetworkImage(
      width: width,
      height: height,
      imageUrl: url,
      fit: fit,
      maxWidthDiskCache: 720,
      maxHeightDiskCache: 560,
      errorWidget: (___, _, __) {
        return const GFShimmer(
            child: Align(
          alignment: Alignment.center,
          child: Text('加载失败'),
        ));
      },
      progressIndicatorBuilder: (context, url, progress) {
        return progress.progress == null
            ? const Offstage()
            : SizedBox(
                height: 50,
                width: 50,
                child: GFProgressBar(
                    percentage: progress.progress!,
                    radius: 50,
                    animation: true,
                    progressBarColor: Colors.lightBlue,
                    type: GFProgressType.circular),
              );
      },
    );
    if (clickToView) {
      return OpenContainer(closedBuilder: (context, act) {
        return GestureDetector(
          onTap: () {
            act.call();
          },
          child: img,
        );
      }, openBuilder: (context, act) {
        return PhotoGalleyScreen(
          photos: [
            NetworkImage(url),
          ],
          closeFunc: act,
        );
      });
    }
    return img;
  }
}
