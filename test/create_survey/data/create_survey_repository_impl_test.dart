// ignore_for_file: inference_failure_on_instance_creation

import 'package:dartz/dartz.dart';
import 'package:flutter_survey_app_mobile/core/connection/network_info.dart';
import 'package:flutter_survey_app_mobile/core/error/failure.dart';
import 'package:flutter_survey_app_mobile/feature/shared_layers/data/model/question_model.dart';
import 'package:flutter_survey_app_mobile/feature/shared_layers/data/model/survey_model.dart';
import 'package:flutter_survey_app_mobile/feature/shared_layers/domain/entity/question_entity.dart';
import 'package:flutter_survey_app_mobile/feature/shared_layers/domain/entity/survey_entity.dart';
import 'package:flutter_survey_app_mobile/feature/create_survey/data/data_source/create_survey_local_data_source.dart';
import 'package:flutter_survey_app_mobile/feature/create_survey/data/data_source/create_survey_remote_data_source.dart';
import 'package:flutter_survey_app_mobile/feature/create_survey/data/repository/create_survey_repository_impl.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'create_survey_repository_impl_test.mocks.dart';

@GenerateMocks([
  CreateSurveyLocalDataSource,
  CreateSurveyRemoteDataSource,
  INetworkInfo,
])
void main() {
  late MockCreateSurveyLocalDataSource mockLocalDataSource;
  late MockCreateSurveyRemoteDataSource mockRemoteDataSource;
  late MockINetworkInfo mockNetworkInfo;
  late CreateSurveyRepositoryImpl repository;

  setUp(() {
    mockLocalDataSource = MockCreateSurveyLocalDataSource();
    mockRemoteDataSource = MockCreateSurveyRemoteDataSource();
    mockNetworkInfo = MockINetworkInfo();
    repository = CreateSurveyRepositoryImpl(
      localDataSource: mockLocalDataSource,
      connectivity: mockNetworkInfo,
      remoteDataSource: mockRemoteDataSource,
    );
  });

  group('CreateSurveyRepositoryImpl Tests', () {
    const mockSurveyEntity = SurveyEntity(surveyId: '123');
    final mockSurveyModel = SurveyModel.fromEntity(mockSurveyEntity);

    // shareSurveyInfo
    test('SUCCESS: should return true on successful shareSurveyInfo', () async {
      // Arrange
      when(mockRemoteDataSource.shareSurveyInfo(model: mockSurveyModel))
          .thenAnswer((_) async => const Right(true));

      // Act
      final result = await repository.shareSurveyInfo(entity: mockSurveyEntity);

      // Assert
      expect(result, const Right(true));
    });

    test('FAIL: should return Failure on unsuccessful shareSurveyInfo',
        () async {
      // Arrange
      when(mockRemoteDataSource.shareSurveyInfo(model: mockSurveyModel))
          .thenAnswer((_) async => Left(ServerFailure(errorMessage: 'error')));

      // Act
      final result = await repository.shareSurveyInfo(entity: mockSurveyEntity);

      // Assert
      expect(result.isLeft(), true);
    });

    // shareQuestions
    final mockQuestionEntities = [
      const QuestionEntity(questionId: '1', title: 'Test Question'),
    ];
    final mockQuestionModels =
        mockQuestionEntities.map(QuestionModel.fromEntity).toList();

    test('SUCCESS: should return true on successful shareQuestions', () async {
      // Arrange
      when(
        mockRemoteDataSource.shareQuestions(
          questionModelList: mockQuestionModels,
        ),
      ).thenAnswer((_) async => const Right(true));

      // Act
      final result = await repository.shareQuestions(
        questionEntityList: mockQuestionEntities,
      );

      // Assert
      expect(result, const Right(true));
    });

    test('FAIL: should return Failure on unsuccessful shareQuestions',
        () async {
      // Arrange
      when(
        mockRemoteDataSource.shareQuestions(
          questionModelList: mockQuestionModels,
        ),
      ).thenAnswer((_) async => Left(ServerFailure(errorMessage: 'error')));

      // Act
      final result = await repository.shareQuestions(
        questionEntityList: mockQuestionEntities,
      );

      // Assert
      expect(result.isLeft(), true);
    });

    // removeSurvey
    const surveyId = '123';

    test('SUCCESS: should return true on successful removeSurvey', () async {
      // Arrange
      when(mockRemoteDataSource.removeSurvey(surveyId: surveyId))
          .thenAnswer((_) async => const Right(true));

      // Act
      final result = await repository.removeSurvey(surveyId: surveyId);

      // Assert
      expect(result, const Right(true));
    });

    test('FAIL: should return Failure on unsuccessful removeSurvey', () async {
      // Arrange
      when(mockRemoteDataSource.removeSurvey(surveyId: surveyId))
          .thenAnswer((_) async => Left(ServerFailure(errorMessage: 'error')));

      // Act
      final result = await repository.removeSurvey(surveyId: surveyId);

      // Assert
      expect(result.isLeft(), true);
    });

    // cacheDatasNoInternet
    test('should call cacheDatasNoInternet with correct parameters', () async {
      // Arrange
      const path = 'path/to/cache';
      const surveyId = '123';

      // Act
      await repository.cacheDatasNoInternet(path: path, surveyId: surveyId);

      // Assert
      verify(
        mockLocalDataSource.cacheDatasNoInternet(
          path: path,
          surveyId: surveyId,
        ),
      );
    });
  });
}
