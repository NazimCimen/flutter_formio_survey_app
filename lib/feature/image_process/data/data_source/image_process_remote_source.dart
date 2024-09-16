import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_survey_app/core/connection/network_info.dart';
import 'package:flutter_survey_app/core/error/failure.dart';
import 'package:flutter_survey_app/core/error/failure_handler.dart';
import 'package:flutter_survey_app/feature/shared_layers/data/model/question_model.dart';
import 'package:flutter_survey_app/feature/shared_layers/data/model/survey_model.dart';
import 'package:flutter_survey_app/product/firebase/firebase_collection_enum.dart';
import 'package:flutter_survey_app/product/firebase/firebase_converter.dart';

abstract class ImageProcessRemoteSource {
  Future<Either<Failure, String>> getImageUrl({
    required Uint8List imageBytes,
    required String path,
  });

  Future<Either<Failure, bool>> removeSurveyImages({
    required String path,
  });
}

class ImageProcessRemoteSourceImpl extends ImageProcessRemoteSource {
  final FirebaseStorage storage;
  final INetworkInfo connectivity;

  ImageProcessRemoteSourceImpl({
    required this.storage,
    required this.connectivity,
  });
  @override

  /// nulll check
  Future<Either<Failure, String>> getImageUrl({
    required Uint8List imageBytes,
    required String path,
  }) async {
    try {
      final isConnected = await connectivity.currentConnectivityResult;
      if (!isConnected) {
        return Left(ConnectionFailure(errorMessage: 'No internet connection'));
      }
      final storageRef = storage.ref();
      final uniqueFileName =
          '$path${DateTime.now().millisecondsSinceEpoch}.png';
      final imageRef = storageRef.child(uniqueFileName);
      await imageRef.putData(imageBytes);
      final urlPath = await imageRef.getDownloadURL();
      return Right(urlPath);
    } catch (e) {
      return Left(FailureHandler.handleFailure(e: e));
    }
  }

  @override
  Future<Either<Failure, bool>> removeSurveyImages({
    required String path,
  }) async {
    try {
//internet check
      final isConnected = await connectivity.currentConnectivityResult;
      if (!isConnected) {
        return Left(ConnectionFailure(errorMessage: 'No internet connection'));
      }
      // Belirtilen klasördeki tüm dosyaları listele
      final listResult = await storage.ref(path).listAll();

      // Listeyi gez ve her dosyayı sil
      for (final ref in listResult.items) {
        await ref.delete();
      }
      return const Right(true);
    } catch (e) {
      return Left(FailureHandler.handleFailure(e: e));
    }
  }
}
