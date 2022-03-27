import 'dart:collection';
import 'dart:convert';
import 'dart:io';

import 'package:flustars/flustars.dart';
import 'package:get/get.dart';

abstract class ConfigService extends GetxService {
  late String configPath;
  late Map<String, dynamic> settings;

  Future<ConfigService> init(
      {String key = "config",
      String file = "config",
      String suffix = "json"}) async {
    await DirectoryUtil.initAppSupportDir();
    configPath = DirectoryUtil.getAppSupportPath(
        category: key, fileName: file, format: suffix)!;
    final f = File(configPath);
    if (!f.existsSync()) {
      f.createSync(recursive: true);
      settings = HashMap();
    } else {
      final string = f.readAsStringSync();
      settings =
          string.isNotEmpty ? json.decode(string) ?? HashMap() : HashMap();
    }
    return this;
  }

  Future<void> store() async {
    final f = File(configPath);
    if (await f.exists()) {
      await f.delete();
    }
    await f.create(recursive: true);
    await f.writeAsString(json.encode(settings));
  }

  dynamic get<T>(String key, {T? defaultValue}) {
    return settings[key] ?? defaultValue;
  }

  void set(String key, dynamic value) {
    settings[key] = value;
    store();
  }
}
