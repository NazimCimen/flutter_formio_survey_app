import 'package:flutter_survey_app/feature/shared_layers/domain/entity/survey_entity.dart';

extension SurveyPathExtension on SurveyEntity {
  String get surveyPath {
    return 'user/$userId/survey/$surveyId/';
  }
}
