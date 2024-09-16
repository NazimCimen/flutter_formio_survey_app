import 'dart:typed_data';
import 'package:dartz/dartz.dart';
import 'package:flutter_survey_app/core/error/failure.dart';
import 'package:flutter_survey_app/feature/image_process/domain/repository/image_process_repository.dart';

class GetImageUrlUseCase {
  final ImageProcessRepository repository;
  GetImageUrlUseCase({required this.repository});
  Future<Either<Failure, String>> call(
      {required Uint8List imageBytes, required String path}) async {
    return repository.getImageUrl(imageBytes: imageBytes, path: path);
  }
}
