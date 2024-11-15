// ignore_for_file: inference_failure_on_instance_creation

import 'package:dartz/dartz.dart';
import 'package:flutter_survey_app_mobile/core/connection/network_info.dart';
import 'package:flutter_survey_app_mobile/feature/shared_layers/data/model/question_model.dart';
import 'package:flutter_survey_app_mobile/feature/shared_layers/data/model/survey_model.dart';
import 'package:flutter_survey_app_mobile/product/firebase/service/base_firebase_service.dart';
import 'package:flutter_survey_app_mobile/feature/create_survey/data/data_source/create_survey_remote_data_source.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'create_survey_remote_data_source_test.mocks.dart';

@GenerateMocks([
  INetworkInfo,
  BaseFirebaseService,
])
void main() {
  late MockINetworkInfo mockNetworkInfo;
  late MockBaseFirebaseService<SurveyModel> mockSurveyFirebaseService;
  late MockBaseFirebaseService<QuestionModel> mockQuestionFirebaseService;
  late CreateSurveyRemoteDataSourceImpl remoteDataSource;

  setUp(() {
    mockNetworkInfo = MockINetworkInfo();
    mockSurveyFirebaseService = MockBaseFirebaseService<SurveyModel>();
    mockQuestionFirebaseService = MockBaseFirebaseService<QuestionModel>();
    remoteDataSource = CreateSurveyRemoteDataSourceImpl(
      connectivity: mockNetworkInfo,
      surveyFirebaseService: mockSurveyFirebaseService,
      questionFirebaseService: mockQuestionFirebaseService,
    );
  });

  group('CreateSurveyRemoteDataSourceImpl Tests', () {
    const mockSurveyModel = SurveyModel(surveyId: '123');
    final mockQuestionModels = [
      const QuestionModel(
        questionId: '1',
        surveyId: '123',
        title: 'Test Question',
      ),
    ];

    // shareSurveyInfo
    test('SUCCESS: should return true on successful shareSurveyInfo', () async {
      // Arrange
      when(mockNetworkInfo.currentConnectivityResult)
          .thenAnswer((_) async => true);
      when(
        mockSurveyFirebaseService.setItem(
          any,
          any,
        ),
      ).thenAnswer((_) async => Future.value());

      // Act
      final result =
          await remoteDataSource.shareSurveyInfo(model: mockSurveyModel);

      // Assert
      expect(result, const Right(true));
    });

    test('FAIL: should return Failure on no internet for shareSurveyInfo',
        () async {
      // Arrange
      when(mockNetworkInfo.currentConnectivityResult)
          .thenAnswer((_) async => false);

      // Act
      final result =
          await remoteDataSource.shareSurveyInfo(model: mockSurveyModel);

      // Assert
      expect(result.isLeft(), true);
    });

    // shareQuestions
    test('SUCCESS: should return true on successful shareQuestions', () async {
      // Arrange
      when(mockNetworkInfo.currentConnectivityResult)
          .thenAnswer((_) async => true);
      when(mockQuestionFirebaseService.setItem(any, any))
          .thenAnswer((_) async => Future.value());

      // Act
      final result = await remoteDataSource.shareQuestions(
        questionModelList: mockQuestionModels,
      );

      // Assert
      expect(result, const Right(true));
    });

    test('FAIL: should return Failure on null surveyId for shareQuestions',
        () async {
      // Arrange
      final invalidQuestionModels = [
        const QuestionModel(questionId: '1', title: 'Test Question'),
      ];

      // Act
      final result = await remoteDataSource.shareQuestions(
        questionModelList: invalidQuestionModels,
      );

      // Assert
      expect(result.isLeft(), true);
    });

    test('FAIL: should return Failure on no internet for shareQuestions',
        () async {
      // Arrange
      when(mockNetworkInfo.currentConnectivityResult)
          .thenAnswer((_) async => false);

      // Act
      final result = await remoteDataSource.shareQuestions(
        questionModelList: mockQuestionModels,
      );

      // Assert
      expect(result.isLeft(), true);
    });

    // removeSurvey
    const surveyId = '123';

    test('SUCCESS: should return true on successful removeSurvey', () async {
      // Arrange
      when(mockSurveyFirebaseService.deleteSubCollections(any))
          .thenAnswer((_) async => Future.value());
      when(mockSurveyFirebaseService.deleteItem(any, any))
          .thenAnswer((_) async => Future.value());

      // Act
      final result = await remoteDataSource.removeSurvey(surveyId: surveyId);

      // Assert
      expect(result, const Right(true));
    });

    test('FAIL: should return Failure on exception for removeSurvey', () async {
      // Arrange
      when(mockSurveyFirebaseService.deleteSubCollections(any))
          .thenThrow(Exception('Error'));

      // Act
      final result = await remoteDataSource.removeSurvey(surveyId: surveyId);

      // Assert
      expect(result.isLeft(), true);
    });
  });
}
