import 'package:dartz/dartz.dart';
import 'package:flutter_survey_app_mobile/core/error/exception.dart';
import 'package:flutter_survey_app_mobile/core/error/failure.dart';
import 'package:flutter_survey_app_mobile/feature/splash/data/data_source/splash_local_data_source.dart';
import 'package:flutter_survey_app_mobile/feature/splash/data/data_source/splash_remote_data_source.dart';
import 'package:flutter_survey_app_mobile/feature/splash/data/model/app_version_model.dart';
import 'package:flutter_survey_app_mobile/feature/splash/data/repository/splash_repository_impl.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'splash_repository_impl_test.mocks.dart';

@GenerateMocks([
  SplashLocalDataSource,
  SplashRemoteDataSource,
])
void main() {
  late SplashRepositoryImpl splashRepositoryImpl;
  late MockSplashLocalDataSource mockSplashLocalDataSource;
  late MockSplashRemoteDataSource mockSplashRemoteDataSource;

  setUp(
    () {
      mockSplashLocalDataSource = MockSplashLocalDataSource();
      mockSplashRemoteDataSource = MockSplashRemoteDataSource();
      splashRepositoryImpl = SplashRepositoryImpl(
        mockSplashLocalDataSource,
        mockSplashRemoteDataSource,
      );
    },
  );
  group(
    'succes/fail test splash repository impl cache for onboard screen visibility flag',
    () {
      const testResult = false;
      test(
        'succes test',
        () async {
          //arrange
          when(mockSplashLocalDataSource.checkCacheOnboardShown()).thenAnswer(
            (_) async => testResult,
          );
          //act
          final result = await splashRepositoryImpl.checkCacheOnboardShown();
          //assert
          // ignore: inference_failure_on_instance_creation
          expect(result, const Right(testResult));
        },
      );
      test(
        'fail test',
        () async {
          //arrange
          when(mockSplashLocalDataSource.checkCacheOnboardShown())
              .thenThrow(CacheException(''));
          //act
          final result = await splashRepositoryImpl.checkCacheOnboardShown();
          //assert
          expect(result.isLeft(), isTrue);
          result.fold(
            (failure) {
              expect(failure, isA<CacheFailure>());
            },
            (_) => fail('Should not reach here'),
          );
          verify(mockSplashLocalDataSource.checkCacheOnboardShown());
          verifyNoMoreInteractions(mockSplashLocalDataSource);
        },
      );
    },
  );

  group(
    'succes/fail test splash repository impl fetch app version number from database',
    () {
      const appVersionModelTest = AppVersionModel('1.0.0');
      const platfrom = 'android';
      test(
        'succes test',
        () async {
          //arrange
          when(
            mockSplashRemoteDataSource.getAppDatabaseVersionNumber(
              platform: platfrom,
            ),
          ).thenAnswer(
            (_) async => const Right(appVersionModelTest),
          );
          //act
          final result =
              await splashRepositoryImpl.getAppVersionNumberFromDatabase(
            platform: platfrom,
          );
          //assert
          // ignore: inference_failure_on_instance_creation
          expect(
            result,
            // ignore: inference_failure_on_instance_creation
            const Right(appVersionModelTest),
          );
          verify(
            mockSplashRemoteDataSource.getAppDatabaseVersionNumber(
              platform: platfrom,
            ),
          );
          verifyNoMoreInteractions(mockSplashRemoteDataSource);
        },
      );
      test(
        'fail test',
        () async {
          //arrange
          when(
            mockSplashRemoteDataSource.getAppDatabaseVersionNumber(
              platform: platfrom,
            ),
          ).thenAnswer(
            (_) async => Left(ServerFailure(errorMessage: 'errorMessage')),
          );
          //act
          final result =
              await splashRepositoryImpl.getAppVersionNumberFromDatabase(
            platform: platfrom,
          );
          //assert
          expect(result.isLeft(), isTrue);
          result.fold(
            (failure) {
              expect(failure, isA<ServerFailure>());
            },
            (_) => fail('Should not reach here'),
          );
          verify(
            mockSplashRemoteDataSource.getAppDatabaseVersionNumber(
              platform: platfrom,
            ),
          );
          verifyNoMoreInteractions(mockSplashRemoteDataSource);
        },
      );
    },
  );
}
