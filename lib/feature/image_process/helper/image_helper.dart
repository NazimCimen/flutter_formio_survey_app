import 'dart:typed_data';
import 'package:dartz/dartz.dart';
import 'package:flutter_survey_app_mobile/core/error/failure.dart';
import 'package:flutter_survey_app_mobile/core/error/failure_handler.dart';
import 'package:flutter_survey_app_mobile/feature/image_process/domain/usecase/crop_image_use_case.dart';
import 'package:flutter_survey_app_mobile/feature/image_process/domain/usecase/get_image_file_use_case.dart';
import 'package:flutter_survey_app_mobile/feature/image_process/domain/usecase/get_image_url_use_case.dart';
import 'package:flutter_survey_app_mobile/feature/image_process/domain/usecase/remove_survey_images_use_case.dart';
import 'package:flutter_survey_app_mobile/product/constants/image_aspect_ratio.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class ImageHelper {
  final GetImageUrlUseCase getImageUrlUseCase;
  final GetImageFileUseCase getImageUseCase;
  final CropImageUseCase cropImageUseCase;
  final RemoveSurveyImagesUseCase removeSurveyImagesUseCase;
  ImageHelper({
    required this.cropImageUseCase,
    required this.getImageUrlUseCase,
    required this.getImageUseCase,
    required this.removeSurveyImagesUseCase,
  });

  /// Selects and crops the survey image
  Future<XFile?> getImage({
    required ImageSource selectedSource,
    required CropAspectRatio cropRatio,
  }) async {
    if (cropRatio == ImageAspectRatioEnum.surveyImage.ratioCrop) {
      return _selectAndCropSurveyImage(
        cropRatio: cropRatio,
        selectedSource: selectedSource,
      );
    } else {
      return _selectAndCropQuestionImage(
        selectedSource: selectedSource,
        cropRatio: cropRatio,
      );
    }
  }

  Future<XFile?> _selectAndCropSurveyImage({
    required ImageSource selectedSource,
    required CropAspectRatio cropRatio,
  }) async {
    final result = await getImageUseCase.call(source: selectedSource);
    return result.fold(
      (fail) => null,
      (image) async {
        if (image != null) {
          final croppedResult = await cropImageUseCase.call(
            imageFile: image,
            cropRatio: cropRatio,
          );

          return croppedResult.fold(
            (fail) => null,
            (croppedImage) => croppedImage,
          );
        }
        return null;
      },
    );
  }

  Future<XFile?> _selectAndCropQuestionImage({
    required ImageSource selectedSource,
    required CropAspectRatio cropRatio,
  }) async {
    final result = await getImageUseCase.call(source: selectedSource);
    return result.fold(
      (fail) => null,
      (image) async {
        if (image != null) {
          final croppedResult = await cropImageUseCase.call(
            imageFile: image,
            cropRatio: cropRatio,
          );
          return croppedResult.fold(
            (fail) => null,
            (croppedImage) => croppedImage,
          );
        }
        return null;
      },
    );
  }

  Future<Either<Failure, String>> getImageUrl({
    required Uint8List imageByte,
    required String path,
  }) async {
    return FailureHandler.foldAndReturnEitherResult(
      getImageUrlUseCase.call(
        imageBytes: imageByte,
        path: path,
      ),
    );
  }

  Future<void> removeSurveyImages(
      // ignore: require_trailing_commas
      {required String? surveyId,
      required String? userId}) async {
    if (surveyId != null && userId != null) {
      final response = await removeSurveyImagesUseCase.call(
        path: 'user/$userId/survey/$surveyId/',
      );
      response.fold(
        (fail) {
          if (fail is! ConnectionFailure) {
            /// crashlytics+loglama
          }
        },
        (succes) {
          if (!succes) {
            /// crashlytics+loglama
          }
        },
      );
    }
  }
}
