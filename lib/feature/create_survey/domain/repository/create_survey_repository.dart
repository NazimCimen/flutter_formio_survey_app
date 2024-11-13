import 'package:dartz/dartz.dart';
import 'package:flutter_survey_app_mobile/core/error/failure.dart';
import 'package:flutter_survey_app_mobile/feature/shared_layers/domain/entity/question_entity.dart';
import 'package:flutter_survey_app_mobile/feature/shared_layers/domain/entity/survey_entity.dart';

abstract class CreateSurveyRepository {
  Future<Either<Failure, bool>> shareSurveyInfo({required SurveyEntity entity});
  Future<Either<Failure, bool>> shareQuestions({
    required List<QuestionEntity> questionEntityList,
  });
  Future<Either<Failure, bool>> removeSurvey({
    required String surveyId,
  });
  Future<void> cacheDatasNoInternet({
    required String path,
    required String surveyId,
  });
}
