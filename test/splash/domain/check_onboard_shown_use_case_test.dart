import 'package:dartz/dartz.dart';
import 'package:flutter_survey_app_mobile/core/error/failure.dart';
import 'package:flutter_survey_app_mobile/feature/splash/domain/repository/splash_repository.dart';
import 'package:flutter_survey_app_mobile/feature/splash/domain/usecase/check_cache_onboard_shown_use_case.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'get_app_database_version_number_use_case_test.mocks.dart';

@GenerateMocks([SplashRepository])
void main() {
  late CheckCacheOnboardShownUseCase usecase;
  late MockSplashRepository mockSplashRepository;
  setUp(
    () {
      mockSplashRepository = MockSplashRepository();
      usecase = CheckCacheOnboardShownUseCase(mockSplashRepository);
    },
  );
  tearDown(
    () {},
  );
  group(
    'succes/fail test check on board shown use case ',
    () {
      const testResult = false;
      final testFail = CacheFailure(errorMessage: '');
      test(
        'succes test',
        () async {
          //arrange.
          when(mockSplashRepository.checkCacheOnboardShown()).thenAnswer(
            (_) async => const Right(testResult),
          );
          //act
          final result = await usecase.call();
          //asserts
          // ignore: inference_failure_on_instance_creation
          expect(result, const Right(testResult));
          verify(mockSplashRepository.checkCacheOnboardShown());
          verifyNoMoreInteractions(mockSplashRepository);
        },
      );
      test(
        'fail test',
        () async {
          //arrange.
          when(mockSplashRepository.checkCacheOnboardShown()).thenAnswer(
            (_) async => Left(testFail),
          );
          //act
          final result = await usecase.call();
          //asserts
          // ignore: inference_failure_on_instance_creation
          expect(result, Left(testFail));
          verify(mockSplashRepository.checkCacheOnboardShown());
          verifyNoMoreInteractions(mockSplashRepository);
        },
      );
    },
  );
}
