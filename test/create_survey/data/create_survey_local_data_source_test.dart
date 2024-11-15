import 'package:flutter_survey_app_mobile/core/cache/cache_enum.dart';
import 'package:flutter_survey_app_mobile/core/cache/cache_manager/standart_cache_manager.dart';
import 'package:flutter_survey_app_mobile/feature/create_survey/data/data_source/create_survey_local_data_source.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'create_survey_local_data_source_test.mocks.dart';

@GenerateMocks([StandartCacheManager])
void main() {
  late MockStandartCacheManager<String> mockCacheManager;
  late CreateSurveyLocalDataSourceImpl dataSource;

  setUp(() {
    mockCacheManager = MockStandartCacheManager<String>();
    dataSource =
        CreateSurveyLocalDataSourceImpl(cacheManager: mockCacheManager);
  });

  group('CreateSurveyLocalDataSourceImpl Tests', () {
    const path = 'path/to/survey';
    const surveyId = '123';

    test('SUCCESS: should call saveData twice with correct keys and data',
        () async {
      // Act
      await dataSource.cacheDatasNoInternet(path: path, surveyId: surveyId);

      // Assert
      verify(
        mockCacheManager.saveData(
          data: path,
          keyName: CacheKeyEnum.removeSurveyImages.name,
        ),
      ).called(1);

      verify(
        mockCacheManager.saveData(
          data: surveyId,
          keyName: CacheKeyEnum.removeSurvey.name,
        ),
      ).called(1);
    });

    test('FAIL: should handle exceptions thrown by cacheManager', () async {
      // Arrange
      when(
        mockCacheManager.saveData(
          data: anyNamed('data'),
          keyName: anyNamed('keyName'),
        ),
      ).thenThrow(Exception('Cache error'));

      // Act
      try {
        await dataSource.cacheDatasNoInternet(path: path, surveyId: surveyId);
        fail('Exception was not thrown');
      } catch (e) {
        // Assert
        expect(e, isA<Exception>());
        expect((e as Exception).toString(), contains('Cache error'));
      }
    });
  });
}
