import 'package:flutter_survey_app_mobile/feature/create_survey/domain/repository/create_survey_repository.dart';

class CacheDatasNoInternetUseCase {
  final CreateSurveyRepository repository;
  CacheDatasNoInternetUseCase({required this.repository});
  Future<void> call({
    required String path,
    required String surveyId,
  }) async {
    await repository.cacheDatasNoInternet(path: path, surveyId: surveyId);
  }
}
