import 'dart:io';

import 'package:get/get.dart';
import 'package:path/path.dart';

enum ProxyTypes { http, https, socks }

/// @Deprecated
/// use proxy-manager instead
class ProxyHelper {
  static void setAsSystemProxy(ProxyTypes types, String url, int port) {
    switch (Platform.operatingSystem) {
      case "windows":
        // TODO
        break;
      case "linux":
        setAsSystemProxyLinux(types, url, port);
        break;
      case "macos":
        // TODO
        break;
    }
  }

  static void setAsSystemProxyLinux(ProxyTypes types, String url, int port) {
    final homeDir = Platform.environment['HOME']!;
    final configDir = join(homeDir, ".config");
    final cmdList = List<List<String>>.empty(growable: true);
    final desktop = Platform.environment['XDG_CURRENT_DESKTOP'];
    final isKDE = desktop == "KDE";
    // gsetting
    cmdList
        .add(["gsettings", "set", "org.gnome.system.proxy", "mode", "manual"]);
    cmdList.add([
      "gsettings",
      "set",
      "org.gnome.system.proxy.${types.name}",
      "host",
      url
    ]);
    cmdList.add([
      "gsettings",
      "set",
      "org.gnome.system.proxy.${types.name}",
      "port",
      "$port"
    ]);
    // kde
    if (isKDE) {
      cmdList.add([
        "kwriteconfig5",
        "--file",
        "$configDir/kioslaverc",
        "--group",
        "Proxy Settings",
        "--key",
        "ProxyType",
        "1"
      ]);
      cmdList.add([
        "kwriteconfig5",
        "--file",
        "$configDir/kioslaverc",
        "--group",
        "Proxy Settings",
        "--key",
        "${types.name}Proxy",
        "${types.name}://$url:$port"
      ]);
    }
    for (final cmd in cmdList) {
      final res = Process.runSync(cmd[0], cmd.sublist(1), runInShell: true);
      Get.printInfo(info: 'cmd: $cmd returns ${res.exitCode}');
    }
  }

  static void cleanSystemProxy() {
    switch (Platform.operatingSystem) {
      case "linux":
        cleanSystemProxyLinux();
        break;
    }
  }

  static void cleanSystemProxyLinux() {
    final homeDir = Platform.environment['HOME']!;
    final configDir = join(homeDir, ".config/");
    final cmdList = List<List<String>>.empty(growable: true);
    final desktop = Platform.environment['XDG_CURRENT_DESKTOP'];
    final isKDE = desktop == "KDE";
    // gsetting
    cmdList.add(["gsettings", "set", "org.gnome.system.proxy", "mode", "none"]);
    if (isKDE) {
      cmdList.add([
        "kwriteconfig5",
        "--file",
        "$configDir/kioslaverc",
        "--group",
        "Proxy Settings",
        "--key",
        "ProxyType",
        "0"
      ]);
    }
    for (final cmd in cmdList) {
      final res = Process.runSync(cmd[0], cmd.sublist(1));
      Get.printInfo(info: 'cmd: $cmd returns ${res.exitCode}');
    }
  }
}
