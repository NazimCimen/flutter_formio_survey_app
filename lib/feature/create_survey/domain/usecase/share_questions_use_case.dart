import 'package:dartz/dartz.dart';
import 'package:flutter_survey_app/core/error/failure.dart';
import 'package:flutter_survey_app/feature/shared_layers/domain/entity/question_entity.dart';
import 'package:flutter_survey_app/feature/create_survey/domain/repository/create_survey_repository.dart';

class ShareQuestionsUseCase {
  final CreateSurveyRepository repository;
  ShareQuestionsUseCase({required this.repository});
  Future<Either<Failure, bool>> call({
    required List<QuestionEntity> questionEntityList,
  }) async {
    return repository.shareQuestions(questionEntityList: questionEntityList);
  }
}
