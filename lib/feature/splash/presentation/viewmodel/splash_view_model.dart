import 'package:flutter_survey_app_mobile/core/app/app_version_manager.dart';
import 'package:flutter_survey_app_mobile/feature/splash/domain/usecase/check_cache_onboard_shown_use_case.dart';
import 'package:flutter_survey_app_mobile/feature/splash/domain/usecase/get_app_database_version_number_use_case.dart';

class SplashViewModel {
  final CheckCacheOnboardShownUseCase checkCacheOnboardShownUseCase;
  final GetAppDatabaseVersionNumberUseCase getAppDatabaseVersionNumber;
  final AppVersionManager appVersionManager;
  SplashViewModel(
    this.checkCacheOnboardShownUseCase,
    this.getAppDatabaseVersionNumber,
    this.appVersionManager,
  );

  /// This method checks onboard screen visibility
  Future<bool> checkOnboardShown() async {
    final failureOrResult = await checkCacheOnboardShownUseCase.call();
    var result = false;
    failureOrResult.fold((fail) {
      result = false;
    }, (succes) {
      result = succes ?? false;
    });
    return result;
  }

  /// This method compares application version in firebase and device version.
  /// if return true it means there is force update
  Future<bool> checkForceUpdate(
    String? appDatabaseVersionNumber,
    String deviceAppVersionNumber,
  ) async {
    if (appDatabaseVersionNumber != null) {
      final isForce = appVersionManager.checkVersions(
        deviceAppVersionNumber: deviceAppVersionNumber,
        databaseAppVersionNumber: appDatabaseVersionNumber,
      );
      return isForce;
    } else {
      return false;
    }
  }

  ///This method fetchs the device app version number.
  Future<String> getDeviceAppVersionNumber() async {
    final deviceAppVersionNumber =
        await appVersionManager.getAppDeviceVersionInfo();
    return deviceAppVersionNumber;
  }

  /// This method checks application version number in firestore
  Future<String?> getAppDatabaseVersion({
    required String devicePlatform,
  }) async {
    String? databaseAppVersionNumber;
    final failuereOrVersion = await getAppDatabaseVersionNumber.call(
      platform: devicePlatform,
    );
    failuereOrVersion.fold((fail) {
      databaseAppVersionNumber = null;
    }, (dbAppVersion) {
      databaseAppVersionNumber = dbAppVersion.versionNumber;
    });
    return databaseAppVersionNumber;
  }

  /// This method used to know device platform. android or ios
  String getDevicePlatform() {
    return appVersionManager.getDevicePlatform();
  }
}
