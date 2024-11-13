import 'package:dartz/dartz.dart';
import 'package:flutter_survey_app_mobile/core/error/failure.dart';
import 'package:flutter_survey_app_mobile/feature/splash/domain/entity/app_version_entity.dart';
import 'package:flutter_survey_app_mobile/feature/splash/domain/repository/splash_repository.dart';

class GetAppDatabaseVersionNumberUseCase {
  final SplashRepository repository;
  GetAppDatabaseVersionNumberUseCase(this.repository);
  Future<Either<Failure, AppVersionEntity>> call({
    required String platform,
  }) async {
    return repository.getAppVersionNumberFromDatabase(platform: platform);
  }
}
