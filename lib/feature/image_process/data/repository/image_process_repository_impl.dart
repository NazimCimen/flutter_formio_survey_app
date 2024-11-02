import 'dart:typed_data';
import 'package:dartz/dartz.dart';
import 'package:flutter_survey_app_mobile/core/error/failure.dart';
import 'package:flutter_survey_app_mobile/feature/image_process/data/data_source/image_process_local_source.dart';
import 'package:flutter_survey_app_mobile/feature/image_process/data/data_source/image_process_remote_source.dart';
import 'package:flutter_survey_app_mobile/feature/image_process/domain/repository/image_process_repository.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class ImageProcessRepositoryImpl implements ImageProcessRepository {
  final ImageProcessLocalSource localDataSource;
  final ImageProcessRemoteSource remoteDataSource;
  ImageProcessRepositoryImpl({
    required this.localDataSource,
    required this.remoteDataSource,
  });
  @override
  Future<Either<Failure, XFile?>> cropImage({
    required XFile imageFile,
    required CropAspectRatio cropRatio,
  }) async {
    final result = await localDataSource.cropImage(
      imageFile: imageFile,
      cropRatio: cropRatio,
    );
    return result;
  }

  @override
  Future<Either<Failure, XFile?>> getImage(
      {required ImageSource source}) async {
    final result = await localDataSource.getImage(source);
    return result;
  }

  @override
  Future<Either<Failure, String>> getImageUrl({
    required Uint8List imageBytes,
    required String path,
  }) async {
    final result = await remoteDataSource.getImageUrl(
      imageBytes: imageBytes,
      path: path,
    );
    return result;
  }

  @override
  Future<Either<Failure, bool>> removeSurveyImages({
    required String path,
  }) async {
    final result = await remoteDataSource.removeSurveyImages(path: path);
    return result;
  }
}
