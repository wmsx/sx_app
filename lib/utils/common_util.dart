import 'dart:io';

import 'package:device_info/device_info.dart';
import 'package:sx_app/constants.dart';

class CommonUtil {
  static int getPlatformId() {
    if (Platform.isAndroid) {
      return PLATFORM_ANDROID;
    }
    if (Platform.isIOS) {
      return PLATFORM_IOS;
    }
    return PLATFORM_WEB;
  }

  static Future<String> getDeviceId() async {
    final DeviceInfoPlugin deviceInfoPlugin = new DeviceInfoPlugin();
    if (Platform.isAndroid) {
      AndroidDeviceInfo androidDeviceInfo = await deviceInfoPlugin.androidInfo;
      return androidDeviceInfo.androidId;
    }
    if (Platform.isIOS) {
      IosDeviceInfo iosDeviceInfo = await deviceInfoPlugin.iosInfo;
      return iosDeviceInfo.identifierForVendor;
    }
    return null;
  }
}
