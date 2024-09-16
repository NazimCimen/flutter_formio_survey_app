import 'package:dartz/dartz.dart';
import 'package:flutter_survey_app/core/cache/cache_enum.dart';
import 'package:flutter_survey_app/core/cache/cache_manager/standart_cache_manager.dart';
import 'package:flutter_survey_app/core/error/failure.dart';
import 'package:flutter_survey_app/core/utils/crop_ui_settings.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

abstract class CreateSurveyLocalDataSource {
  Future<Either<Failure, XFile?>> getImage(ImageSource source);
  Future<Either<Failure, XFile?>> cropImage({
    required XFile imageFile,
    required CropAspectRatio cropRatio,
  });
  Future<void> cacheDatasNoInternet({
    required String path,
    required String surveyId,
  });
}

class CreateSurveyLocalDataSourceImpl extends CreateSurveyLocalDataSource {
  final StandartCacheManager<String> cacheManager;

  CreateSurveyLocalDataSourceImpl({required this.cacheManager});
  @override
  Future<Either<Failure, XFile?>> getImage(ImageSource source) async {
    final picker = ImagePicker();
    try {
      final pickedFile = await picker.pickImage(source: source);
      if (pickedFile != null) {
        return Right(XFile(pickedFile.path));
      } else {
        return Left(ServerFailure(errorMessage: 'no image selected'));
      }
    } catch (e) {
      return Left(ServerFailure(errorMessage: 'no image selected'));
    }
  }

  @override
  Future<Either<Failure, XFile?>> cropImage({
    required XFile imageFile,
    required CropAspectRatio cropRatio,
  }) async {
    try {
      final croppedFile = await ImageCropper().cropImage(
        sourcePath: imageFile.path,
        aspectRatio: cropRatio,
        uiSettings: [
          CropperUiSettings.getAndroidUiSettings(),
          CropperUiSettings.getIosUiSettings(),
        ],
      );

      if (croppedFile != null) {
        return Right(XFile(croppedFile.path));
      } else {
        return Left(ServerFailure(errorMessage: 'Kırpma işlemi iptal edildi'));
      }
    } catch (e) {
      return Left(ServerFailure(errorMessage: 'Hata: ${e.toString()}'));
    }
  }

  @override
  Future<void> cacheDatasNoInternet(
      {required String path, required String surveyId}) async {
    await cacheManager.saveData(
        data: path, keyName: CacheKeyEnum.removeSurveyImages.name);
    await cacheManager.saveData(
        data: surveyId, keyName: CacheKeyEnum.removeSurvey.name);
  }
}
