import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_survey_app_mobile/config/localization/string_constants.dart';
import 'package:flutter_survey_app_mobile/core/error/exception.dart';
import 'package:flutter_survey_app_mobile/core/error/failure.dart';

@immutable
final class FailureHandler {
  const FailureHandler._();

  static T handleFold<T>({
    required Either<Failure, T> response,
  }) {
    return response.fold(
      (fail) => throw _handleFailureThrowException(fail),
      (success) {
        if (success is bool) {
          if (success == false) {
            throw _handleFailureThrowException(
              ServerFailure(errorMessage: 'server-error'),
            );
          }
        }
        return success;
      },
    );
  }

  static Failure handleFailure({required Object e}) {
    if (e is FirebaseException) {
      return ServerFailure(
        errorMessage: 'Firebase hata: ${e.code} - ${e.message}',
      );
    } else if (e.toString().contains('SocketException')) {
      return ConnectionFailure(
        errorMessage: StringConstants.error_connection_msg,
      );
    } else {
      return UnKnownFaliure(
        errorMessage: '${StringConstants.error_connection_msg} $e',
      );
    }
  }

  static Exception _handleFailureThrowException(Failure failure) {
    if (failure is ConnectionFailure) {
      return ConnectionException('no-internet');
    } else if (failure is ServerFailure) {
      return ServerException('server-error');
    }
    return UnKnownException('unknown-error');
  }

  static Future<Either<Failure, T>> foldAndReturnEitherResult<T>(
    Future<Either<Failure, T>> apiCall,
  ) async {
    final response = await apiCall;
    return response.fold(
      (fail) => Left(fail),
      (success) => Right(success),
    );
  }
}
