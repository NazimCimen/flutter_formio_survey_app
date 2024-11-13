// ignore_for_file: inference_failure_on_instance_creation

import 'package:flutter_survey_app_mobile/feature/create_survey/domain/repository/create_survey_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_survey_app_mobile/core/error/failure.dart';
import 'package:flutter_survey_app_mobile/feature/shared_layers/domain/entity/question_entity.dart';
import 'package:flutter_survey_app_mobile/feature/shared_layers/domain/entity/survey_entity.dart';

import 'create_survey_repository_test.mocks.dart';

@GenerateMocks([
  CreateSurveyRepository,
])
void main() {
  late MockCreateSurveyRepository mockRepository;
  setUp(() {
    mockRepository = MockCreateSurveyRepository();
  });

  group('CreateSurveyRepository Tests', () {
    // shareSurveyInfo tests
    test('should return true on successful shareSurveyInfo', () async {
      // Arrange
      const mockSurvey = SurveyEntity(
        surveyId: '123',
      );
      when(mockRepository.shareSurveyInfo(entity: mockSurvey))
          .thenAnswer((_) async => const Right(true));

      // Act
      final result = await mockRepository.shareSurveyInfo(entity: mockSurvey);

      // Assert
      expect(result, const Right(true));
    });

    test('should return Failure on unsuccessful shareSurveyInfo', () async {
      // Arrange
      const mockSurvey = SurveyEntity(
        surveyId: '123',
      );
      when(mockRepository.shareSurveyInfo(entity: mockSurvey))
          .thenAnswer((_) async => Left(ServerFailure(errorMessage: 'error')));

      // Act
      final result = await mockRepository.shareSurveyInfo(entity: mockSurvey);

      // Assert
      expect(result.isLeft(), true);
    });

    // shareQuestions tests
    test('should return true on successful shareQuestions', () async {
      // Arrange
      final mockQuestions = [
        const QuestionEntity(questionId: '1', title: 'Test Survey'),
      ];
      when(mockRepository.shareQuestions(questionEntityList: mockQuestions))
          .thenAnswer((_) async => const Right(true));

      // Act
      final result = await mockRepository.shareQuestions(
        questionEntityList: mockQuestions,
      );

      // Assert
      expect(result, const Right(true));
    });

    test('should return Failure on unsuccessful shareQuestions', () async {
      // Arrange
      final mockQuestions = [
        const QuestionEntity(questionId: '1', title: 'Test Survey'),
      ];
      when(mockRepository.shareQuestions(questionEntityList: mockQuestions))
          .thenAnswer((_) async => Left(ServerFailure(errorMessage: 'error')));

      // Act
      final result = await mockRepository.shareQuestions(
        questionEntityList: mockQuestions,
      );

      // Assert
      expect(result.isLeft(), true);
    });

    // removeSurvey tests
    test('should return true on successful removeSurvey', () async {
      // Arrange
      when(mockRepository.removeSurvey(surveyId: '123'))
          .thenAnswer((_) async => const Right(true));

      // Act
      final result = await mockRepository.removeSurvey(surveyId: '123');

      // Assert
      expect(result, const Right(true));
    });

    test('should return Failure on unsuccessful removeSurvey', () async {
      // Arrange
      when(mockRepository.removeSurvey(surveyId: '123'))
          .thenAnswer((_) async => Left(ServerFailure(errorMessage: 'error')));

      // Act
      final result = await mockRepository.removeSurvey(surveyId: '123');

      // Assert
      expect(result.isLeft(), true);
    });

    // cacheDatasNoInternet tests
    test('should call cacheDatasNoInternet with correct parameters', () async {
      // Arrange
      when(
        mockRepository.cacheDatasNoInternet(
          path: 'path/to/cache',
          surveyId: '123',
        ),
      ).thenAnswer((_) async {});

      // Act
      await mockRepository.cacheDatasNoInternet(
        path: 'path/to/cache',
        surveyId: '123',
      );

      // Assert
      verify(
        mockRepository.cacheDatasNoInternet(
          path: 'path/to/cache',
          surveyId: '123',
        ),
      );
    });
  });
}
