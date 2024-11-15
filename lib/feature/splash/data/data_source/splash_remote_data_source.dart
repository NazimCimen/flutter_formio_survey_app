import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_survey_app_mobile/core/connection/network_info.dart';
import 'package:flutter_survey_app_mobile/core/error/failure.dart';
import 'package:flutter_survey_app_mobile/feature/splash/data/model/app_version_model.dart';
import 'package:flutter_survey_app_mobile/product/constants/failure_constants.dart';
import 'package:flutter_survey_app_mobile/product/firebase/firebase_paths.dart';
import 'package:flutter_survey_app_mobile/product/firebase/service/base_firebase_service.dart';

abstract class SplashRemoteDataSource {
  Future<Either<Failure, AppVersionModel>> getAppDatabaseVersionNumber({
    required String platform,
  });
}

class SplashRemoteDataSourceImpl implements SplashRemoteDataSource {
  final FirebaseFirestore firestore;
  final INetworkInfo networkInfo;
  final BaseFirebaseService<AppVersionModel> appVersionFirebaseService;

  SplashRemoteDataSourceImpl(
    this.firestore,
    this.networkInfo,
    this.appVersionFirebaseService,
  );

  /// CHECKING APPLICATION DB NUMBER FOR FORCE UPDATE
  @override
  Future<Either<Failure, AppVersionModel>> getAppDatabaseVersionNumber({
    required String platform,
  }) async {
    final connection = await networkInfo.currentConnectivityResult;
    if (connection == true) {
      try {
        final result = await appVersionFirebaseService.getItem(
          collectionPath: FirebaseCollectionEnum.version.name,
          docId: platform,
          model: const AppVersionModel(''),
        );

        return Right(result);
      } catch (e) {
        return Left(FailureConstants.dataIsNull);
      }
    } else {
      return Left(FailureConstants.noInternet);
    }
  }
}
