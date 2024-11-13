import 'package:dartz/dartz.dart';
import 'package:flutter_survey_app_mobile/core/error/failure.dart';
import 'package:flutter_survey_app_mobile/feature/image_process/domain/repository/image_process_repository.dart';

class RemoveSurveyImagesUseCase {
  final ImageProcessRepository repository;
  RemoveSurveyImagesUseCase({required this.repository});
  Future<Either<Failure, bool>> call({required String path}) async {
    return repository.removeSurveyImages(path: path);
  }
}
