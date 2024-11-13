import 'package:flutter_survey_app_mobile/core/error/failure.dart';
import 'package:flutter_survey_app_mobile/feature/create_survey/domain/repository/create_survey_repository.dart';
import 'package:flutter_survey_app_mobile/feature/create_survey/domain/usecase/cache_datas_no_internet_use_case.dart';
import 'package:flutter_survey_app_mobile/feature/create_survey/domain/usecase/remove_survey_use_case.dart';
import 'package:flutter_survey_app_mobile/feature/create_survey/domain/usecase/share_questions_use_case.dart';
import 'package:flutter_survey_app_mobile/feature/create_survey/domain/usecase/share_survey_info_use_case.dart';
import 'package:flutter_survey_app_mobile/feature/shared_layers/domain/entity/question_entity.dart';
import 'package:flutter_survey_app_mobile/feature/shared_layers/domain/entity/survey_entity.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:dartz/dartz.dart';
import 'create_survey_repository_test.mocks.dart';

// Mock oluşturulacak sınıfların listesi
@GenerateMocks([CreateSurveyRepository])
void main() {
  late MockCreateSurveyRepository mockRepository;
  late CacheDatasNoInternetUseCase cacheDatasNoInternetUseCase;
  late RemoveSurveyUseCase removeSurveyUseCase;
  late ShareQuestionsUseCase shareQuestionsUseCase;
  late ShareSurveyInfoUseCase shareSurveyInfoUseCase;

  setUp(() {
    mockRepository = MockCreateSurveyRepository();
    cacheDatasNoInternetUseCase =
        CacheDatasNoInternetUseCase(repository: mockRepository);
    removeSurveyUseCase = RemoveSurveyUseCase(repository: mockRepository);
    shareQuestionsUseCase = ShareQuestionsUseCase(repository: mockRepository);
    shareSurveyInfoUseCase = ShareSurveyInfoUseCase(repository: mockRepository);
  });
  // CacheDatasNoInternetUseCase Tests
  group('CacheDatasNoInternetUseCase tests', () {
    test('success test', () async {
      // Arrange
      when(
        mockRepository.cacheDatasNoInternet(
          path: anyNamed('path'),
          surveyId: anyNamed('surveyId'),
        ),
      ).thenAnswer((_) async {});

      // Act
      await cacheDatasNoInternetUseCase.call(
        path: 'test/path',
        surveyId: '123',
      );

      // Assert
      verify(
        mockRepository.cacheDatasNoInternet(
          path: 'test/path',
          surveyId: '123',
        ),
      ).called(1);
    });

    test('fail test', () async {
      // Arrange
      when(
        mockRepository.cacheDatasNoInternet(
          path: anyNamed('path'),
          surveyId: anyNamed('surveyId'),
        ),
      ).thenThrow(Exception('Cache failed'));

      // Act & Assert
      expect(
        () => cacheDatasNoInternetUseCase.call(
          path: 'test/path',
          surveyId: '123',
        ),
        throwsA(isA<Exception>()),
      );
    });
  });
  // RemoveSurveyUseCase Tests
  group('RemoveSurveyUseCase tests', () {
    test('success test', () async {
      // Arrange
      when(mockRepository.removeSurvey(surveyId: anyNamed('surveyId')))
          .thenAnswer((_) async => const Right(true));

      // Act
      final result = await removeSurveyUseCase.call(surveyId: '123');

      // Assert
      // ignore: inference_failure_on_instance_creation
      expect(result, const Right(true));
      verify(mockRepository.removeSurvey(surveyId: '123')).called(1);
    });

    test('fail test', () async {
      // Arrange
      when(mockRepository.removeSurvey(surveyId: anyNamed('surveyId')))
          .thenAnswer((_) async => Left(ServerFailure(errorMessage: 'error')));

      // Act
      final result = await removeSurveyUseCase.call(surveyId: '123');

      // Assert
      expect(result.isLeft(), true);
    });
  });

  // ShareQuestionsUseCase Tests
  group('ShareQuestionsUseCase tests', () {
    final questionList = [
      const QuestionEntity(questionId: '1'),
      const QuestionEntity(questionId: '2'),
    ];

    test('success test', () async {
      // Arrange
      when(
        mockRepository.shareQuestions(
          questionEntityList: anyNamed('questionEntityList'),
        ),
      ).thenAnswer((_) async => const Right(true));

      // Act
      final result =
          await shareQuestionsUseCase.call(questionEntityList: questionList);

      // Assert
      // ignore: inference_failure_on_instance_creation
      expect(result, const Right(true));
      verify(mockRepository.shareQuestions(questionEntityList: questionList))
          .called(1);
    });

    test('fail test', () async {
      // Arrange
      when(
        mockRepository.shareQuestions(
          questionEntityList: anyNamed('questionEntityList'),
        ),
      ).thenAnswer((_) async => Left(ServerFailure(errorMessage: 'error')));

      // Act
      final result =
          await shareQuestionsUseCase.call(questionEntityList: questionList);

      // Assert
      expect(result.isLeft(), true);
    });
  });

  // ShareSurveyInfoUseCase Tests
  group('ShareSurveyInfoUseCase tests', () {
    const surveyEntity = SurveyEntity(surveyId: '123');

    test('success test', () async {
      // Arrange
      when(mockRepository.shareSurveyInfo(entity: anyNamed('entity')))
          .thenAnswer((_) async => const Right(true));

      // Act
      final result = await shareSurveyInfoUseCase.call(entity: surveyEntity);

      // Assert
      // ignore: inference_failure_on_instance_creation
      expect(result, const Right(true));
      verify(mockRepository.shareSurveyInfo(entity: surveyEntity)).called(1);
    });

    test('fail test', () async {
      // Arrange
      when(mockRepository.shareSurveyInfo(entity: anyNamed('entity')))
          .thenAnswer((_) async => Left(ServerFailure(errorMessage: 'error')));

      // Act
      final result = await shareSurveyInfoUseCase.call(entity: surveyEntity);

      // Assert
      expect(result.isLeft(), true);
    });
  });
}
