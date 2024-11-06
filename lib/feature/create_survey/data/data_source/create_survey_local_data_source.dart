import 'package:flutter_survey_app_mobile/core/cache/cache_enum.dart';
import 'package:flutter_survey_app_mobile/core/cache/cache_manager/standart_cache_manager.dart';

abstract class CreateSurveyLocalDataSource {
  Future<void> cacheDatasNoInternet({
    required String path,
    required String surveyId,
  });
}

class CreateSurveyLocalDataSourceImpl extends CreateSurveyLocalDataSource {
  final StandartCacheManager<String> cacheManager;

  CreateSurveyLocalDataSourceImpl({required this.cacheManager});

  ///CACHE DATAS IF NO INTERNET
  @override
  Future<void> cacheDatasNoInternet({
    required String path,
    required String surveyId,
  }) async {
    await cacheManager.saveData(
      data: path,
      keyName: CacheKeyEnum.removeSurveyImages.name,
    );
    await cacheManager.saveData(
      data: surveyId,
      keyName: CacheKeyEnum.removeSurvey.name,
    );
  }
}
