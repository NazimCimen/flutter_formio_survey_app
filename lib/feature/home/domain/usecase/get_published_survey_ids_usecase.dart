import 'package:dartz/dartz.dart';
import 'package:flutter_survey_app_mobile/core/error/failure.dart';
import 'package:flutter_survey_app_mobile/feature/home/domain/repository/home_repository.dart';

class GetPublishedSurveyIdsUsecase {
  final HomeRepository repository;
  GetPublishedSurveyIdsUsecase({required this.repository});

  Future<Either<Failure, List<String>?>> call({required String userId}) async {
    return repository.getPublishedSurveyIds(userId: userId);
  }
}
