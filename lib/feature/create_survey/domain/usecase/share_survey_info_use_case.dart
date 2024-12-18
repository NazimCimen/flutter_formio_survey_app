import 'package:dartz/dartz.dart';
import 'package:flutter_survey_app_mobile/core/error/failure.dart';
import 'package:flutter_survey_app_mobile/feature/shared_layers/domain/entity/survey_entity.dart';
import 'package:flutter_survey_app_mobile/feature/create_survey/domain/repository/create_survey_repository.dart';

class ShareSurveyInfoUseCase {
  final CreateSurveyRepository repository;
  ShareSurveyInfoUseCase({required this.repository});
  Future<Either<Failure, bool>> call({required SurveyEntity entity}) async {
    return repository.shareSurveyInfo(entity: entity);
  }
}
