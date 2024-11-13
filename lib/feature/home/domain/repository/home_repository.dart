import 'package:dartz/dartz.dart';
import 'package:flutter_survey_app_mobile/core/error/failure.dart';
import 'package:flutter_survey_app_mobile/feature/shared_layers/domain/entity/survey_entity.dart';

abstract class HomeRepository {
  Future<Either<Failure, List<String>?>> getPublishedSurveyIds({
    required String userId,
  });
  Future<Either<Failure, List<SurveyEntity>>> getPublishedSurveys({
    required List<String>? surveyIds,
  });
}
