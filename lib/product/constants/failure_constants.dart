import 'package:flutter/foundation.dart';
import 'package:flutter_survey_app_mobile/config/localization/string_constants.dart';
import 'package:flutter_survey_app_mobile/core/error/failure.dart';

@immutable
final class FailureConstants {
  const FailureConstants._();
  static ConnectionFailure get noInternet => ConnectionFailure(
        errorMessage: StringConstants.error_connection_msg,
      );
  static ServerFailure get idNul =>
      ServerFailure(errorMessage: 'Survey Id is null');
  static ServerFailure get noImageSelected =>
      ServerFailure(errorMessage: 'no image selected');
  static ServerFailure get croppingCanceled =>
      ServerFailure(errorMessage: 'Kırpma işlemi iptal edildi');
  static ServerFailure customError(String e) {
    return ServerFailure(errorMessage: 'Hata: $e');
  }

  static ServerFailure get dataIsNull =>
      ServerFailure(errorMessage: 'data is null');
  static CacheFailure get cacheError =>
      CacheFailure(errorMessage: 'cache error');
}
