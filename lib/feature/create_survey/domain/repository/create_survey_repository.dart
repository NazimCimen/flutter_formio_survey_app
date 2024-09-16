import 'dart:typed_data';

import 'package:dartz/dartz.dart';
import 'package:flutter_survey_app/core/error/failure.dart';
import 'package:flutter_survey_app/feature/shared_layers/domain/entity/question_entity.dart';
import 'package:flutter_survey_app/feature/shared_layers/domain/entity/survey_entity.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

abstract class CreateSurveyRepository {
  Future<Either<Failure, XFile?>> getImage({required ImageSource source});
  Future<Either<Failure, XFile?>> cropImage({
    required XFile imageFile,
    required CropAspectRatio cropRatio,
  });
  Future<Either<Failure, String>> getImageUrl(
      {required Uint8List imageBytes, required String path});
  Future<Either<Failure, bool>> shareSurveyInfo({required SurveyEntity entity});
  Future<Either<Failure, bool>> shareQuestions({
    required List<QuestionEntity> questionEntityList,
  });
  Future<Either<Failure, bool>> removeSurvey({
    required String surveyId,
  });
  Future<void> cacheDatasNoInternet({
    required String path,
    required String surveyId,
  });
}
