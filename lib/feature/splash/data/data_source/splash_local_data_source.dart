import 'package:flutter_survey_app_mobile/core/cache/cache_enum.dart';
import 'package:flutter_survey_app_mobile/core/error/exception.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class SplashLocalDataSource {
  Future<bool?> checkCacheOnboardShown();
}

class SplashLocalDataSourceImpl implements SplashLocalDataSource {
  final SharedPreferences sharedPreferences;
  SplashLocalDataSourceImpl(this.sharedPreferences);

  /// CHECKING CACHE FOR ONBOARD SCREEN VISIBILITY FLAG
  @override
  Future<bool?> checkCacheOnboardShown() async {
    try {
      final result =
          sharedPreferences.getBool(CacheKeyEnum.onboardVisibility.name);
      return result;
    } catch (e) {
      throw CacheException('cache errror');
    }
  }
}
