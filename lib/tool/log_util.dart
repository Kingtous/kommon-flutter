import 'package:flutter/foundation.dart';

class LogUtil {
  static d(Object? data) {
    if (kDebugMode) {
      print(data);
    }
  }
}
