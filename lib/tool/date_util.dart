import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:get/get.dart';

class KDateUtil {
  KDateUtil._();

  static String formatDate(DateTime? t, {isTime = false}) {
    t = t?.toLocal();
    return t == null
        ? ""
        : "${t.year}年${t.month}月${t.day}日 ${isTime ? "${t.hour.toString().padLeft(2, "0")}:${t.minute.toString().padLeft(2, "0")}:${t.day.toString().padLeft(2, "0")}" : ""}";
  }

  static String formatTime(DateTime? t, {hasSec = false}) {
    return t == null
        ? ""
        : "${t.hour.toString().padLeft(2, "0")}:${t.minute.toString().padLeft(2, "0")}";
  }

  static String formatYearMonth(DateTime? t) {
    t = t?.toLocal();
    return t == null ? "" : "${t.year}年${t.month}月";
  }

  static Future<DateTime?> pickDate() async {
    if (Get.context == null) {
      return null;
    }
    return DatePicker.showDatePicker(Get.context!,
        locale: LocaleType.zh,
        maxTime: DateTime.now(),
        minTime: DateTime(2000));
  }

  static Future<DateTime?> pickTime() async {
    if (Get.context == null) {
      return null;
    }
    return DatePicker.showTimePicker(Get.context!, locale: LocaleType.zh);
  }

  static bool isInNightRange(DateTime time) {
    final local = time.toLocal();
    return local.hour >= 22 || local.hour <= 6;
  }
}
