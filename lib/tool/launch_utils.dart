import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

class LaunchUtils {
  static Future<bool> openUrl(String item) {
    return launchUrlString(item);
  }

  static Future<bool> openUri(Uri uri) {
    return launchUrl(uri);
  }
}
