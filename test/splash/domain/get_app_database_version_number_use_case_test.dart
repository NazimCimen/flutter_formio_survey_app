import 'package:dartz/dartz.dart';
import 'package:flutter_survey_app_mobile/core/error/failure.dart';
import 'package:flutter_survey_app_mobile/feature/splash/domain/entity/app_version_entity.dart';
import 'package:flutter_survey_app_mobile/feature/splash/domain/repository/splash_repository.dart';
import 'package:flutter_survey_app_mobile/feature/splash/domain/usecase/get_app_database_version_number_use_case.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'get_app_database_version_number_use_case_test.mocks.dart';

@GenerateMocks([SplashRepository])
void main() {
  late MockSplashRepository mockSplashRepository;
  late GetAppDatabaseVersionNumberUseCase usercase;

  setUp(
    () {
      mockSplashRepository = MockSplashRepository();
      usercase = GetAppDatabaseVersionNumberUseCase(mockSplashRepository);
    },
  );
  group(
    'succes/fail test Get App Database Version Number Use Case',
    () {
      const testModel = AppVersionEntity('1.0.0');
      final testFail = ServerFailure(errorMessage: '');
      const platform = 'android';
      test(
        'succes test',
        () async {
          // arrange
          when(
            mockSplashRepository.getAppVersionNumberFromDatabase(
              platform: platform,
            ),
          ).thenAnswer(
            (_) async => const Right(testModel),
          );
          // act
          final result = await usercase.call(platform: platform);
          // assert
          // ignore: inference_failure_on_instance_creation
          expect(result, const Right(testModel));
          verify(
            mockSplashRepository.getAppVersionNumberFromDatabase(
              platform: platform,
            ),
          );
          verifyNoMoreInteractions(mockSplashRepository);
        },
      );
      test(
        'fail test',
        () async {
          // arrange
          when(
            mockSplashRepository.getAppVersionNumberFromDatabase(
              platform: platform,
            ),
          ).thenAnswer(
            (_) async => Left(testFail),
          );
          // act
          final result = await usercase.call(platform: platform);
          // assert
          // ignore: inference_failure_on_instance_creation
          expect(result, Left(testFail));
          verify(
            mockSplashRepository.getAppVersionNumberFromDatabase(
              platform: platform,
            ),
          );
          verifyNoMoreInteractions(mockSplashRepository);
        },
      );
    },
  );
}
