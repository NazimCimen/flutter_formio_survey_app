import 'package:dartz/dartz.dart';
import 'package:flutter_survey_app_mobile/core/connection/network_info.dart';
import 'package:flutter_survey_app_mobile/core/error/failure.dart';
import 'package:flutter_survey_app_mobile/feature/shared_layers/data/model/question_model.dart';
import 'package:flutter_survey_app_mobile/feature/shared_layers/data/model/survey_model.dart';
import 'package:flutter_survey_app_mobile/feature/shared_layers/domain/entity/question_entity.dart';
import 'package:flutter_survey_app_mobile/feature/shared_layers/domain/entity/survey_entity.dart';
import 'package:flutter_survey_app_mobile/feature/create_survey/data/data_source/create_survey_local_data_source.dart';
import 'package:flutter_survey_app_mobile/feature/create_survey/data/data_source/create_survey_remote_data_source.dart';
import 'package:flutter_survey_app_mobile/feature/create_survey/domain/repository/create_survey_repository.dart';

class CreateSurveyRepositoryImpl implements CreateSurveyRepository {
  final CreateSurveyLocalDataSource localDataSource;
  final CreateSurveyRemoteDataSource remoteDataSource;
  final INetworkInfo connectivity;
  CreateSurveyRepositoryImpl({
    required this.localDataSource,
    required this.connectivity,
    required this.remoteDataSource,
  });

  /// IT IS USED TO SAVE SURVEY INFO DATAS IN FIRESTORE
  @override
  Future<Either<Failure, bool>> shareSurveyInfo({
    required SurveyEntity entity,
  }) async {
    final model = SurveyModel.fromEntity(entity);
    final result = await remoteDataSource.shareSurveyInfo(model: model);
    return result;
  }

  /// IT IS USED TO SAVE QUESTIONS IN FIRESTORE
  @override
  Future<Either<Failure, bool>> shareQuestions({
    required List<QuestionEntity> questionEntityList,
  }) async {
    final questionModelList = <QuestionModel>[];
    for (final model in questionEntityList) {
      final questionModel = QuestionModel.fromEntity(model);
      questionModelList.add(questionModel);
    }
    final result = await remoteDataSource.shareQuestions(
      questionModelList: questionModelList,
    );
    return result;
  }

  /// IT IS USED TO REMOVE SURVEY DATAS FROM STORAGE AND FIRESTORE
  @override
  Future<Either<Failure, bool>> removeSurvey({required String surveyId}) async {
    final result = await remoteDataSource.removeSurvey(surveyId: surveyId);
    return result;
  }

  @override
  Future<void> cacheDatasNoInternet({
    required String path,
    required String surveyId,
  }) async {
    await localDataSource.cacheDatasNoInternet(path: path, surveyId: surveyId);
  }
}
