import 'dart:typed_data';
import 'package:dartz/dartz.dart';
import 'package:flutter_survey_app_mobile/core/error/failure.dart';
import 'package:flutter_survey_app_mobile/core/error/failure_handler.dart';
import 'package:flutter_survey_app_mobile/feature/image_process/domain/usecase/crop_image_use_case.dart';
import 'package:flutter_survey_app_mobile/feature/image_process/domain/usecase/get_image_file_use_case.dart';
import 'package:flutter_survey_app_mobile/feature/image_process/domain/usecase/get_image_url_use_case.dart';
import 'package:flutter_survey_app_mobile/feature/image_process/domain/usecase/remove_survey_images_use_case.dart';
import 'package:flutter_survey_app_mobile/product/constants/image_aspect_ratio.dart';
import 'package:flutter_survey_app_mobile/product/firebase/firebase_paths.dart';
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

  /// Selects an image from the chosen source and crops it according to the specified aspect ratio.
  Future<XFile?> getImage({
    required ImageSource selectedSource,
    required CropAspectRatio cropRatio,
  }) async {
    // Check if the image is for a survey; if so, apply the survey-specific crop aspect ratio
    if (cropRatio == ImageAspectRatioEnum.surveyImage.ratioCrop) {
      return _selectAndCropSurveyImage(
        cropRatio: cropRatio,
        selectedSource: selectedSource,
      );
    } else {
      // Otherwise, crop as a question image with its respective ratio
      return _selectAndCropQuestionImage(
        selectedSource: selectedSource,
        cropRatio: cropRatio,
      );
    }
  }

  /// Handles selecting and cropping an image specifically for survey images.
  Future<XFile?> _selectAndCropSurveyImage({
    required ImageSource selectedSource,
    required CropAspectRatio cropRatio,
  }) async {
    // Get image from the chosen source
    final result = await getImageUseCase.call(source: selectedSource);
    return result.fold(
      (fail) => null,
      (image) async {
        if (image != null) {
          // Crop the image to the specified survey aspect ratio
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

  /// Handles selecting and cropping an image specifically for question images.
  Future<XFile?> _selectAndCropQuestionImage({
    required ImageSource selectedSource,
    required CropAspectRatio cropRatio,
  }) async {
    // Get image from the chosen source
    final result = await getImageUseCase.call(source: selectedSource);
    return result.fold(
      (fail) => null,
      (image) async {
        if (image != null) {
          // Crop the image to the specified question aspect ratio
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

  /// Retrieves the URL for the image based on the provided byte data and path.
  Future<Either<Failure, String>> getImageUrl({
    required Uint8List imageByte,
    required String path,
  }) async {
    // Calls the use case to get the image URL and handles potential failures
    return FailureHandler.foldAndReturnEitherResult(
      getImageUrlUseCase.call(
        imageBytes: imageByte,
        path: path,
      ),
    );
  }

  /// Removes survey images from the storage path if survey and user IDs are provided.
  Future<void> removeSurveyImages({
    required String? surveyId,
    required String? userId,
  }) async {
    if (surveyId != null && userId != null) {
      final response = await removeSurveyImagesUseCase.call(
        path: FirebasePaths.userSurvey
            .getPath(userId: userId, surveyId: surveyId),
      );
      response.fold(
        (fail) {
          if (fail is! ConnectionFailure) {}
        },
        (success) {
          if (!success) {}
        },
      );
    }
  }
}
