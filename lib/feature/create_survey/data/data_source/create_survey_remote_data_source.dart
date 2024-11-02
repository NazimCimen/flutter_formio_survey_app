import 'package:dartz/dartz.dart';
import 'package:flutter_survey_app_mobile/core/connection/network_info.dart';
import 'package:flutter_survey_app_mobile/core/error/failure.dart';
import 'package:flutter_survey_app_mobile/core/error/failure_handler.dart';
import 'package:flutter_survey_app_mobile/feature/shared_layers/data/model/question_model.dart';
import 'package:flutter_survey_app_mobile/feature/shared_layers/data/model/survey_model.dart';
import 'package:flutter_survey_app_mobile/product/firebase/firebase_collection_enum.dart';
import 'package:flutter_survey_app_mobile/product/firebase/service/base_firebase_service.dart';

abstract class CreateSurveyRemoteDataSource {
  Future<Either<Failure, bool>> shareSurveyInfo({
    required SurveyModel model,
  });
  Future<Either<Failure, bool>> shareQuestions({
    required List<QuestionModel> questionModelList,
  });

  Future<Either<Failure, bool>> removeSurvey({
    required String surveyId,
  });
}

class CreateSurveyRemoteDataSourceImpl extends CreateSurveyRemoteDataSource {
  final INetworkInfo connectivity;
  final BaseFirebaseService<SurveyModel> surveyFirebaseService;
  final BaseFirebaseService<QuestionModel> questionFirebaseService;
  CreateSurveyRemoteDataSourceImpl({
    required this.connectivity,
    required this.surveyFirebaseService,
    required this.questionFirebaseService,
  });
  @override

  /// IT IS USED TO SAVE SURVEY INFO DATAS IN FIRESTORE
  @override
  Future<Either<Failure, bool>> shareSurveyInfo({
    required SurveyModel model,
  }) async {
    try {
      final isConnected = await connectivity.currentConnectivityResult;
      if (!isConnected) {
        return Left(ConnectionFailure(errorMessage: 'No internet connection'));
      }
      await surveyFirebaseService.setItem(
        FirebaseCollectionEnum.surveys.name,
        model,
      );
      return const Right(true);
    } catch (e) {
      return Left(FailureHandler.handleFailure(e: e));
    }
  }

  /// IT IS USED TO SAVE QUESTIONS IN FIRESTORE
  @override
  Future<Either<Failure, bool>> shareQuestions({
    required List<QuestionModel> questionModelList,
  }) async {
    try {
      final isConnected = await connectivity.currentConnectivityResult;
      if (!isConnected) {
        return Left(ConnectionFailure(errorMessage: 'No internet connection'));
      }
      final surveyId = questionModelList[0].surveyId;
      if (surveyId == null) {
        return Left(
          ServerFailure(errorMessage: 'Survey Id is null'),
        );
      }
      for (final model in questionModelList) {
        await questionFirebaseService.setItem(
          FirebaseCollectionEnum.surveys.getQuestionsPath(
            surveyId: surveyId,
          ),
          model,
        );
      }
      return const Right(true);
    } catch (e) {
      return Left(FailureHandler.handleFailure(e: e));
    }
  }

  /// IT IS USED TO REMOVE SURVEY DATAS FROM STORAGE AND FIRESTORE
  @override
  Future<Either<Failure, bool>> removeSurvey({required String surveyId}) async {
    try {
      await surveyFirebaseService.deleteSubCollections([
        FirebaseCollectionEnum.surveys.getQuestionsPath(surveyId: surveyId),
      ]);

      await surveyFirebaseService.deleteItem(
        FirebaseCollectionEnum.surveys.name,
        surveyId,
      );

      return const Right(true);
    } catch (e) {
      return Left(ServerFailure(errorMessage: e.toString()));
    }
  }
}
