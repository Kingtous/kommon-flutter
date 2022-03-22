import 'dart:io';

import 'package:flustars/flustars.dart';
import 'package:get/get.dart';
import 'package:path/path.dart' as p;

/// Author: Kingtous
/// Date: 2021/7/3
/// Mail: me@kingtous.cn

enum CacheFileType { pic, other, video }

class CacheService extends GetxService {
  Directory? tempPicTempDir;
  Directory? tempVideoTempDir;
  Directory? otherTempFileDir;

  Future<CacheService> init() async {
    tempPicTempDir = await DirectoryUtil.createTempDir(category: 'pic');
    tempVideoTempDir = await DirectoryUtil.createTempDir(category: 'video');
    otherTempFileDir = await DirectoryUtil.createTempDir(category: 'other');
    // 清理缓存
    Future.delayed(
        const Duration(milliseconds: 500), () {
      emptyCache(CacheFileType.pic);
      emptyCache(CacheFileType.video);
      emptyCache(CacheFileType.other);
    });
    return this;
  }

  Future<File?> getTempFile(String fileName, CacheFileType type) async {
    Directory? dir;
    switch (type) {
      case CacheFileType.pic:
        dir = tempPicTempDir;
        break;
      case CacheFileType.other:
        dir = otherTempFileDir;
        break;
      case CacheFileType.video:
        dir = tempVideoTempDir;
        break;
    }
    if (dir == null) {
      return null;
    }
    var fullPath = p.join(dir.path, fileName);
    var f = File(fullPath);
    return f.create(recursive: true);
  }

  emptyCache(CacheFileType type) async {
    Directory? dir;
    switch (type) {
      case CacheFileType.pic:
        dir = tempPicTempDir;
        break;
      case CacheFileType.other:
        dir = otherTempFileDir;
        break;
      case CacheFileType.video:
        dir = tempVideoTempDir;
        break;
      default:
        break;
    }
    if (dir != null) {
      if (dir.existsSync()) {
        await dir.delete(recursive: true);
      }
    }
  }
}
