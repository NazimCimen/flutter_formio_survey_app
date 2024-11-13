import 'package:dartz/dartz.dart';
import 'package:flutter_survey_app_mobile/core/error/exception.dart';
import 'package:flutter_survey_app_mobile/core/error/failure.dart';
import 'package:flutter_survey_app_mobile/feature/splash/data/data_source/splash_local_data_source.dart';
import 'package:flutter_survey_app_mobile/feature/splash/data/data_source/splash_remote_data_source.dart';
import 'package:flutter_survey_app_mobile/feature/splash/data/model/app_version_model.dart';
import 'package:flutter_survey_app_mobile/feature/splash/domain/repository/splash_repository.dart';

class SplashRepositoryImpl implements SplashRepository {
  final SplashLocalDataSource splashLocalDataSource;
  final SplashRemoteDataSource splashRemoteDataSource;

  SplashRepositoryImpl(this.splashLocalDataSource, this.splashRemoteDataSource);

  /// CHECKING CACHE FOR ONBOARD SCREEN VISIBILITY FLAG
  @override
  Future<Either<Failure, bool?>> checkCacheOnboardShown() async {
    try {
      final result = await splashLocalDataSource.checkCacheOnboardShown();
      return Right(result);
    } on CacheException {
      return Left(CacheFailure(errorMessage: 'cache error'));
    }
  }

  /// FETCH APP VERSION NUMBER FROM DATABASE
  @override
  Future<Either<Failure, AppVersionModel>> getAppVersionNumberFromDatabase({
    required String platform,
  }) async {
    final response = await splashRemoteDataSource.getAppDatabaseVersionNumber(
      platform: platform,
    );
    return response.fold(
      (failure) => Left(failure),
      (versionModel) => Right(versionModel),
    );
  }
}
