import 'package:flutter_survey_app_mobile/config/localization/string_constants.dart';

enum QuestionType {
  multipleChoice,
  openEnded,
  dropdown,
}

extension QuestionTypeExtension on QuestionType {
  String get qType {
    switch (this) {
      case QuestionType.multipleChoice:
        return StringConstants.question_type_multiple;
      case QuestionType.openEnded:
        return StringConstants.question_type_open_ended;
      case QuestionType.dropdown:
        return StringConstants.question_type_dropdown;
    }
  }
}
