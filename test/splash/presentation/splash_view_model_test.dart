import 'package:dartz/dartz.dart';
import 'package:flutter_survey_app_mobile/core/app/app_version_manager.dart';
import 'package:flutter_survey_app_mobile/core/error/exception.dart';
import 'package:flutter_survey_app_mobile/core/error/failure.dart';
import 'package:flutter_survey_app_mobile/feature/splash/domain/entity/app_version_entity.dart';
import 'package:flutter_survey_app_mobile/feature/splash/domain/usecase/check_cache_onboard_shown_use_case.dart';
import 'package:flutter_survey_app_mobile/feature/splash/domain/usecase/get_app_database_version_number_use_case.dart';
import 'package:flutter_survey_app_mobile/feature/splash/presentation/viewmodel/splash_view_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'splash_view_model_test.mocks.dart';

@GenerateMocks([
  CheckCacheOnboardShownUseCase,
  GetAppDatabaseVersionNumberUseCase,
  AppVersionManager,
])
void main() {
  late SplashViewModel viewModel;
  late MockCheckCacheOnboardShownUseCase mockCheckCacheOnboardShownUseCase;
  late MockGetAppDatabaseVersionNumberUseCase
      mockGetAppDatabaseVersionNumberUseCase;
  late MockAppVersionManager mockAppVersionManager;
  setUp(
    () {
      mockGetAppDatabaseVersionNumberUseCase =
          MockGetAppDatabaseVersionNumberUseCase();
      mockCheckCacheOnboardShownUseCase = MockCheckCacheOnboardShownUseCase();
      mockAppVersionManager = MockAppVersionManager();
      viewModel = SplashViewModel(
        mockCheckCacheOnboardShownUseCase,
        mockGetAppDatabaseVersionNumberUseCase,
        mockAppVersionManager,
      );
    },
  );

  group(
    'success/fail test splash view model checkOnboardShown',
    () {
      const testResult = true;
      final testFail = CacheFailure(errorMessage: '');
      test(
        'success test splash view model',
        () async {
          // arrange
          when(mockCheckCacheOnboardShownUseCase.call()).thenAnswer(
            (_) async => const Right(testResult),
          );
          // act
          final result = await viewModel.checkOnboardShown();

          // assert
          expect(result, testResult);
          verify(mockCheckCacheOnboardShownUseCase.call());
          verifyNoMoreInteractions(mockCheckCacheOnboardShownUseCase);
        },
      );

      test(
        'fail test splash view model',
        () async {
          // arrange
          when(mockCheckCacheOnboardShownUseCase.call()).thenAnswer(
            (_) async => Left(testFail),
          );
          // act
          final result = await viewModel.checkOnboardShown();

          // assert
          expect(result, false);
          verify(mockCheckCacheOnboardShownUseCase.call());
          verifyNoMoreInteractions(mockCheckCacheOnboardShownUseCase);
        },
      );
    },
  );

  group(
    'success/fail test splash view model check Force Update',
    () {
      const appVersionTest = '1.0.0';
      const isForceUpdateTest = false;
      final appVersionExceptionTest =
          AppVersionException('Failed to fetch app version');
      test(
        'success test',
        () async {
          // arrange
          when(
            mockAppVersionManager.checkVersions(
              deviceAppVersionNumber: appVersionTest,
              databaseAppVersionNumber: appVersionTest,
            ),
          ).thenAnswer(
            (_) => isForceUpdateTest,
          );

          // act
          final result =
              await viewModel.checkForceUpdate(appVersionTest, appVersionTest);

          // assert
          expect(result, isForceUpdateTest);
          verify(
            mockAppVersionManager.checkVersions(
              deviceAppVersionNumber: appVersionTest,
              databaseAppVersionNumber: appVersionTest,
            ),
          );
          verifyNoMoreInteractions(mockAppVersionManager);
        },
      );

      test(
        'fail test',
        () async {
          // arrange
          when(
            mockAppVersionManager.checkVersions(
              databaseAppVersionNumber: appVersionTest,
              deviceAppVersionNumber: appVersionTest,
            ),
          ).thenThrow(
            appVersionExceptionTest,
          );
          when(mockAppVersionManager.getAppDeviceVersionInfo()).thenAnswer(
            (_) async => appVersionTest,
          );
          // act & assert
          expect(
            () async => viewModel.checkForceUpdate(
              appVersionTest,
              appVersionTest,
            ),
            throwsA(isA<AppVersionException>()),
          );

          // Doğru metotların çağrıldığını kontrol ediyoruz
          verify(
            mockAppVersionManager.checkVersions(
              deviceAppVersionNumber: appVersionTest,
              databaseAppVersionNumber: appVersionTest,
            ),
          );
          verifyNoMoreInteractions(mockAppVersionManager);
        },
      );
    },
  );

  group(
    'success/fail test splash view model get Device App Version Number',
    () {
      const appVersionTest = '1.0.0';
      final appVersionExceptionTest =
          AppVersionException('Failed to fetch app version');
      test(
        'succes test',
        () async {
          // arrange
          when(mockAppVersionManager.getAppDeviceVersionInfo()).thenAnswer(
            (_) async => appVersionTest,
          );
          // act
          final result = await viewModel.getDeviceAppVersionNumber();
          // assert
          expect(result, appVersionTest);
          verify(mockAppVersionManager.getAppDeviceVersionInfo());
          verifyNoMoreInteractions(mockAppVersionManager);
        },
      );
      test(
        'fail test',
        () async {
          // arrange
          when(mockAppVersionManager.getAppDeviceVersionInfo()).thenThrow(
            appVersionExceptionTest,
          );
          // act & assert
          expect(
            () async => viewModel.getDeviceAppVersionNumber(),
            throwsA(isA<AppVersionException>()),
          );
          verify(mockAppVersionManager.getAppDeviceVersionInfo());
          verifyNoMoreInteractions(mockAppVersionManager);
        },
      );
    },
  );

  group(
    'success/fail test splash view model get App Database Version',
    () {
      const testModel = AppVersionEntity('1.0.0');
      final testFail = ServerFailure(errorMessage: '');
      const platform = 'android';
      const appVersionTest = '1.0.0';
      test(
        'succes test',
        () async {
          // arrange
          when(mockGetAppDatabaseVersionNumberUseCase.call(platform: platform))
              .thenAnswer(
            (_) async => const Right(testModel),
          );
          // act
          final result =
              await viewModel.getAppDatabaseVersion(devicePlatform: platform);

          // assert
          expect(result, appVersionTest);
          verify(
            mockGetAppDatabaseVersionNumberUseCase.call(platform: platform),
          );
          verifyNoMoreInteractions(mockGetAppDatabaseVersionNumberUseCase);
        },
      );
      test(
        'fail test',
        () async {
          // arrange
          when(mockGetAppDatabaseVersionNumberUseCase.call(platform: platform))
              .thenAnswer(
            (_) async => Left(testFail),
          );

          // act
          final result =
              await viewModel.getAppDatabaseVersion(devicePlatform: platform);

          // assert
          expect(result, isNull);
          verify(
            mockGetAppDatabaseVersionNumberUseCase.call(platform: platform),
          );
          verifyNoMoreInteractions(mockGetAppDatabaseVersionNumberUseCase);
        },
      );
    },
  );
}
