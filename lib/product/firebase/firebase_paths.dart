import 'package:flutter_survey_app_mobile/feature/shared_layers/domain/entity/survey_entity.dart';

enum FirebasePaths {
  userSurvey,
  surveyPath,
  surveys;

  String getPath({String? userId, String? surveyId}) {
    switch (this) {
      case FirebasePaths.userSurvey:
        return 'user/$userId/survey/$surveyId/';
      case FirebasePaths.surveyPath:
        return 'user/$userId/survey/$surveyId/';
      case FirebasePaths.surveys:
        return '$name/$surveyId/${FirebaseCollectionEnum.questions.name}';
    }
  }
}

extension SurveyPathExtension on SurveyEntity {
  String get surveyPath {
    return 'user/$userId/survey/$surveyId/';
  }
}

enum FirebaseCollectionEnum {
  version,
  surveys,
  questions,
  user;

  String getQuestions({required String surveyId}) {
    if (this == FirebaseCollectionEnum.surveys) {
      return '$name/$surveyId/${FirebaseCollectionEnum.questions.name}';
    }
    throw Exception(
      'Questions path can only be accessed from the surveys collection.',
    );
  }
}
