import 'package:flutter_survey_app_mobile/core/error/exception.dart';
import 'package:flutter_survey_app_mobile/core/utils/enum/device_platform_enum.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'dart:io' show Platform;

abstract class AppVersionManager {
  bool checkVersions({
    required String deviceAppVersionNumber,
    required String databaseAppVersionNumber,
  });
  Future<String> getAppDeviceVersionInfo();
  String getDevicePlatform();
}

class AppVersionManagerImpl implements AppVersionManager {
  /// This method returns application version number in device.
  @override
  Future<String> getAppDeviceVersionInfo() async {
    final packageInfo = await PackageInfo.fromPlatform();
    return packageInfo.version;
  }

  /// This method compares application version in firebase and device version.
  /// if return true it means there is force update
  @override
  bool checkVersions({
    required String deviceAppVersionNumber,
    required String databaseAppVersionNumber,
  }) {
    final deviceAppVersionSplited =
        int.tryParse(deviceAppVersionNumber.split('.').join());
    final databaseAppVersionSplited =
        int.tryParse(databaseAppVersionNumber.split('.').join());

    if (deviceAppVersionSplited != null && databaseAppVersionSplited != null) {
      return deviceAppVersionSplited < databaseAppVersionSplited;
    } else {
      throw AppVersionException('app version or db version is parsed null');
    }
  }

  @override
  String getDevicePlatform() {
    if (Platform.isAndroid) {
      return DevicePlatformEnum.android.name;
    } else if (Platform.isIOS) {
      return DevicePlatformEnum.ios.name;
    } else {
      throw AppVersionException('app version or db version is parsed null');
    }
  }
}
