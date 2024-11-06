import 'package:dartz/dartz.dart';
import 'package:flutter_survey_app_mobile/core/error/failure.dart';
import 'package:flutter_survey_app_mobile/feature/splash/domain/entity/app_version_entity.dart';

abstract class SplashRepository {
  Future<Either<Failure, bool?>> checkCacheOnboardShown();
  Future<Either<Failure, AppVersionEntity>> getAppVersionNumberFromDatabase({
    required String platform,
  });
}
