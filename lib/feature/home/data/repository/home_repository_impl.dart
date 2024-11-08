import 'package:dartz/dartz.dart';
import 'package:flutter_survey_app_mobile/core/error/failure.dart';
import 'package:flutter_survey_app_mobile/feature/home/data/data_source/home_remote_data_source.dart';
import 'package:flutter_survey_app_mobile/feature/home/domain/repository/home_repository.dart';
import 'package:flutter_survey_app_mobile/feature/shared_layers/domain/entity/survey_entity.dart';

class HomeRepositoryImpl extends HomeRepository {
  final HomeRemoteDataSource remoteDataSource;
  HomeRepositoryImpl({required this.remoteDataSource});

  /// IT USED TO GET PUBLISHED SURVEY IDS FROM FIRESTORE
  @override
  Future<Either<Failure, List<String>?>> getPublishedSurveyIds({
    required String userId,
  }) async {
    return remoteDataSource.getPublishedSurveyIds(userId: userId);
  }

  /// IT USED TO GET PUBLISHED SURVEYS
  @override
  Future<Either<Failure, List<SurveyEntity>>> getPublishedSurveys({
    required List<String>? surveyIds,
  }) async {
    final result =
        await remoteDataSource.getPublishedSurveys(surveyIds: surveyIds);
    final entityList = <SurveyEntity>[];
    return result.fold(
      (failure) {
        return Left(failure);
      },
      (modelList) {
        modelList.map(
          (model) {
            entityList.add(model.toEntity());
          },
        ).toList();
        return Right(entityList);
      },
    );
  }
}
