import 'package:dartz/dartz.dart';
import 'package:flutter_survey_app_mobile/core/error/failure.dart';
import 'package:flutter_survey_app_mobile/feature/shared_layers/data/model/survey_model.dart';
import 'package:flutter_survey_app_mobile/feature/shared_layers/data/model/user_model.dart';
import 'package:flutter_survey_app_mobile/product/firebase/firebase_collection_enum.dart';
import 'package:flutter_survey_app_mobile/product/firebase/service/base_firebase_service.dart';

abstract class HomeRemoteDataSource {
  Future<Either<Failure, List<String>?>> getPublishedSurveyIds({
    required String userId,
  });
  Future<Either<Failure, List<SurveyModel>>> getPublishedSurveys({
    required List<String>? surveyIds,
  });
}

class HomeRemoteDataSourceImpl extends HomeRemoteDataSource {
  final BaseFirebaseService<UserModel> userService;
  final BaseFirebaseService<SurveyModel> surveyService;

  HomeRemoteDataSourceImpl({
    required this.userService,
    required this.surveyService,
  });
  /// IT USED TO GET PUBLISHED SURVEY IDS FROM FIRESTORE
  @override
  Future<Either<Failure, List<String>?>> getPublishedSurveyIds({
    required String userId,
  }) async {
    try {
      final user = await userService.getItem(
        collectionPath: FirebaseCollectionEnum.user.name,
        docId: userId,
        model: const UserModel(),
      );
      return Right(user.publishedSurveyIds);
    } catch (e) {
      return Left(ConnectionFailure(errorMessage: 'errorMessage'));
    }
  }
  /// IT USED TO GET PUBLISHED SURVEYS
  @override
  Future<Either<Failure, List<SurveyModel>>> getPublishedSurveys({
    required List<String>? surveyIds,
  }) async {
    final surveyList = <SurveyModel>[];
    try {
      if (surveyIds != null) {
        for (final id in surveyIds) {
          final survey = await surveyService.getItem(
            collectionPath: FirebaseCollectionEnum.surveys.name,
            docId: id,
            model: const SurveyModel(),
          );
          surveyList.add(survey);
        }
      }
      return Right(surveyList);
    } catch (e) {
      return Left(ConnectionFailure(errorMessage: 'errorMessage'));
    }
  }
}
