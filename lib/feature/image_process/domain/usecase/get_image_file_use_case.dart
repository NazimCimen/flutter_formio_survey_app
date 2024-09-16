import 'package:dartz/dartz.dart';
import 'package:flutter_survey_app/core/error/failure.dart';
import 'package:flutter_survey_app/feature/image_process/domain/repository/image_process_repository.dart';
import 'package:image_picker/image_picker.dart';

class GetImageFileUseCase {
  final ImageProcessRepository repository;
  GetImageFileUseCase({required this.repository});
  Future<Either<Failure, XFile?>> call({required ImageSource source}) async {
    return repository.getImage(source: source);
  }
}
