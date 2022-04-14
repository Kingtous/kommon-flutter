import 'package:url_launcher/url_launcher.dart';

class LaunchUtils {

  static Future<bool> openUrl(String item) {
    return launch(item);
  }

  static Future<bool> openUri(Uri uri){
    return launch(uri.toString());
  }

}