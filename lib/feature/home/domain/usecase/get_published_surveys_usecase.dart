import 'package:dartz/dartz.dart';
import 'package:flutter_survey_app_mobile/core/error/failure.dart';
import 'package:flutter_survey_app_mobile/feature/home/domain/repository/home_repository.dart';
import 'package:flutter_survey_app_mobile/feature/shared_layers/domain/entity/survey_entity.dart';

class GetPublishedSurveysUsecase {
  final HomeRepository repository;
  GetPublishedSurveysUsecase({required this.repository});
  Future<Either<Failure, List<SurveyEntity>>> call({
    required List<String>? surveyIds,
  }) async {
    return repository.getPublishedSurveys(surveyIds: surveyIds);
  }
}
