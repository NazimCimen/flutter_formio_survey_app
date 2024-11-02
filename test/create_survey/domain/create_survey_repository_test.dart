// ignore_for_file: inference_failure_on_instance_creation

import 'package:flutter_survey_app_mobile/feature/create_survey/domain/repository/create_survey_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_survey_app_mobile/core/error/failure.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:flutter_survey_app_mobile/feature/shared_layers/domain/entity/question_entity.dart';
import 'package:flutter_survey_app_mobile/feature/shared_layers/domain/entity/survey_entity.dart';
import 'dart:typed_data';

import 'create_survey_repository_test.mocks.dart';

@GenerateMocks([CreateSurveyRepository])
void main() {
  late MockCreateSurveyRepository mockRepository;
  setUp(() {
    mockRepository = MockCreateSurveyRepository();
  });

  group('CreateSurveyRepository Tests', () {
    // getImage tests
    test('should return XFile on successful getImage', () async {
      // Arrange
      final mockFile = XFile('path/to/image');
      when(mockRepository.getImage(source: ImageSource.gallery))
          .thenAnswer((_) async => Right(mockFile));

      // Act
      final result = await mockRepository.getImage(source: ImageSource.gallery);

      // Assert
      expect(result, Right(mockFile));
      verify(mockRepository.getImage(source: ImageSource.gallery));
    });

    test('should return Failure on unsuccessful getImage', () async {
      // Arrange
      when(mockRepository.getImage(source: ImageSource.gallery))
          .thenAnswer((_) async => Left(ServerFailure(errorMessage: 'error')));

      // Act
      final result = await mockRepository.getImage(source: ImageSource.gallery);

      // Assert
      expect(result.isLeft(), true);
    });

    // cropImage tests
    test('should return XFile on successful cropImage', () async {
      // Arrange
      final mockFile = XFile('path/to/image');
      when(
        mockRepository.cropImage(
          imageFile: mockFile,
          cropRatio: const CropAspectRatio(ratioX: 1, ratioY: 1),
        ),
      ).thenAnswer((_) async => Right(mockFile));

      // Act
      final result = await mockRepository.cropImage(
        imageFile: mockFile,
        cropRatio: const CropAspectRatio(ratioX: 1, ratioY: 1),
      );

      // Assert
      expect(result, Right(mockFile));
    });

    test('should return Failure on unsuccessful cropImage', () async {
      // Arrange
      final mockFile = XFile('path/to/image');
      when(
        mockRepository.cropImage(
          imageFile: mockFile,
          cropRatio: const CropAspectRatio(ratioX: 1, ratioY: 1),
        ),
      ).thenAnswer((_) async => Left(ServerFailure(errorMessage: 'error')));

      // Act
      final result = await mockRepository.cropImage(
        imageFile: mockFile,
        cropRatio: const CropAspectRatio(ratioX: 1, ratioY: 1),
      );

      // Assert
      expect(result.isLeft(), true);
    });

    // getImageUrl tests
    test('should return image url on successful getImageUrl', () async {
      // Arrange
      final mockBytes = Uint8List(10);
      const mockUrl = 'http://example.com/image';
      when(
        mockRepository.getImageUrl(
          imageBytes: mockBytes,
          path: 'path/to/save',
        ),
      ).thenAnswer((_) async => const Right(mockUrl));

      // Act
      final result = await mockRepository.getImageUrl(
        imageBytes: mockBytes,
        path: 'path/to/save',
      );

      // Assert
      expect(result, const Right(mockUrl));
    });

    test('should return Failure on unsuccessful getImageUrl', () async {
      // Arrange
      final mockBytes = Uint8List(10);
      when(
        mockRepository.getImageUrl(
          imageBytes: mockBytes,
          path: 'path/to/save',
        ),
      ).thenAnswer((_) async => Left(ServerFailure(errorMessage: 'error')));

      // Act
      final result = await mockRepository.getImageUrl(
        imageBytes: mockBytes,
        path: 'path/to/save',
      );

      // Assert
      expect(result.isLeft(), true);
    });

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
