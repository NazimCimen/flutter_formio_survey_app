import 'package:dartz/dartz.dart';
import 'package:flutter_survey_app_mobile/core/error/failure.dart';
import 'package:flutter_survey_app_mobile/feature/create_survey/domain/repository/create_survey_repository.dart';

class RemoveSurveyUseCase {
  final CreateSurveyRepository repository;
  RemoveSurveyUseCase({required this.repository});
  Future<Either<Failure, bool>> call({required String surveyId}) async {
    return repository.removeSurvey(surveyId: surveyId);
  }
}
