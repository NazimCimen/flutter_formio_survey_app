import 'package:dartz/dartz.dart';
import 'package:flutter_survey_app_mobile/core/error/failure.dart';
import 'package:flutter_survey_app_mobile/core/utils/crop_ui_settings.dart';
import 'package:flutter_survey_app_mobile/product/constants/failure_constants.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

abstract class ImageProcessLocalSource {
  Future<Either<Failure, XFile?>> getImage(ImageSource source);
  Future<Either<Failure, XFile?>> cropImage({
    required XFile imageFile,
    required CropAspectRatio cropRatio,
  });
}

class ImageProcessLocalSourceImpl extends ImageProcessLocalSource {
  ImageProcessLocalSourceImpl();

  ///IT USED TO GET IMAGE FROM DEVICE-GALLERY/CAMERA
  @override
  Future<Either<Failure, XFile?>> getImage(ImageSource source) async {
    final picker = ImagePicker();
    try {
      final pickedFile = await picker.pickImage(source: source);
      if (pickedFile != null) {
        return Right(XFile(pickedFile.path));
      } else {
        return Left(FailureConstants.noImageSelected);
      }
    } catch (e) {
      return Left(FailureConstants.noImageSelected);
    }
  }

  /// IT USED TO CROP IMAGE AFTER PICKING
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
        return Left(FailureConstants.croppingCanceled);
      }
    } catch (e) {
      return Left(FailureConstants.customError(e.toString()));
    }
  }
}
