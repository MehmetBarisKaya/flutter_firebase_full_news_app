import 'dart:io';

enum PlatformEnum {
  adroid,
  ios;

  static String get versionName {
    if (Platform.isIOS) {
      return PlatformEnum.ios.name;
    }
    if (Platform.isAndroid) {
      return PlatformEnum.adroid.name;
    }
    throw Exception('Platform unused, Check!');
  }
}
