import 'package:file_picker/file_picker.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kommon/cache/service/cache_service.dart';
import 'package:kommon/dialog/service/dialog_service.dart';
import 'package:kommon/image/service/image_crop_service.dart';
import 'package:path/path.dart' as p;

/// Author: Kingtous
/// Date: 2021/6/28
/// Mail: me@kingtous.cn

enum PickSource { camera, gallery, plainText }

class PickerService extends GetxService {
  late ImagePicker imagePicker;

  PickerService() {
    imagePicker = ImagePicker();
  }

  /// 选择一个图片、或者纯文本
  Future<String?> pickImage(PickSource pickSource,
      {double? maxWidth,
      double? maxHeight,
      int? imageQuality,
      bool needCrop = true}) async {
    XFile? f;
    switch (pickSource) {
      case PickSource.camera:
        f = await imagePicker.pickImage(
            source: ImageSource.camera,
            maxWidth: maxWidth,
            maxHeight: maxHeight,
            imageQuality: imageQuality);
        break;
      case PickSource.gallery:
        f = await imagePicker.pickImage(
            source: ImageSource.gallery,
            maxWidth: maxWidth,
            maxHeight: maxHeight,
            imageQuality: imageQuality);
        break;
      case PickSource.plainText:
        final text =
            await Get.find<DialogService>().inputDialog(title: "输入选项文本");
        if (text.isEmpty) {
          return null;
        }
        return "text://$text";
      default:
        break;
    }
    if (f != null) {
      if (needCrop) {
        final data =
            await Get.find<ImageCropService>().cropImageWithPath(f.path);
        if (data == null) {
          // 可能是裁剪不了，返回原值
          return f.path;
        } else {
          // 先保存起来
          var tempFile = await Get.find<CacheService>()
              .getTempFile(p.basename(f.path), CacheFileType.pic);
          tempFile = await tempFile?.writeAsBytes(data);
          return tempFile?.path;
        }
      } else {
        return f.path;
      }
    }
    return null;
  }

  /// 选择视频
  Future<String?> pickVideo(PickSource pickSource) async {
    XFile? f;
    switch (pickSource) {
      case PickSource.camera:
        f = await imagePicker.pickVideo(source: ImageSource.camera);
        break;
      case PickSource.gallery:
        f = await imagePicker.pickVideo(source: ImageSource.gallery);
        break;
      default:
        break;
    }
    if (f != null) {
      return f.path;
    } else {
      return null;
    }
  }

  /// 目前仅支持mp3试试
  Future<String?> pickAudio({List<String>? exts}) async {
    final result = await FilePicker.platform.pickFiles(
        type: exts == null ? FileType.audio : FileType.custom,
        allowCompression: true,
        allowedExtensions: exts);
    if (result == null) {
      return null;
    }
    final f = result.files.first;
    return f.path;
  }

  Future<PickerService> init() async {
    return this;
  }
}
