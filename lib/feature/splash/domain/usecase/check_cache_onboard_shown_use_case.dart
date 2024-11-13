import 'package:dartz/dartz.dart';
import 'package:flutter_survey_app_mobile/core/error/failure.dart';
import 'package:flutter_survey_app_mobile/feature/splash/domain/repository/splash_repository.dart';

class CheckCacheOnboardShownUseCase {
  final SplashRepository splashRepository;
  CheckCacheOnboardShownUseCase(this.splashRepository);
  Future<Either<Failure, bool?>> call() async {
    return splashRepository.checkCacheOnboardShown();
  }
}
