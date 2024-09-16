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

abstract class CreateSurveyRemoteDataSource {
  Future<Either<Failure, String>> getImageUrl({
    required Uint8List imageBytes,
    required String path,
  });
  Future<Either<Failure, bool>> shareSurveyInfo({
    required SurveyModel model,
  });
  Future<Either<Failure, bool>> shareQuestions({
    required List<QuestionModel> questionModelList,
  });

  Future<Either<Failure, bool>> removeSurvey({
    required String surveyId,
  });
}

class CreateSurveyRemoteDataSourceImpl extends CreateSurveyRemoteDataSource {
  final FirebaseStorage storage;
  final FirebaseConverter<SurveyModel> surveyFirebaseConverter;
  final FirebaseConverter<QuestionModel> questionFirebaseConverter;
  final INetworkInfo connectivity;

  CreateSurveyRemoteDataSourceImpl({
    required this.storage,
    required this.surveyFirebaseConverter,
    required this.questionFirebaseConverter,
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
  Future<Either<Failure, bool>> shareSurveyInfo({
    required SurveyModel model,
  }) async {
    try {
      final isConnected = await connectivity.currentConnectivityResult;
      if (!isConnected) {
        return Left(ConnectionFailure(errorMessage: 'No internet connection'));
      }
      await surveyFirebaseConverter
          .collectionRef(FirebaseCollectionEnum.surveys)
          .doc(
            model.surveyId,
          )
          .set(model);
      return const Right(true);
    } catch (e) {
      return Left(FailureHandler.handleFailure(e: e));
    }
  }

  @override
  Future<Either<Failure, bool>> shareQuestions({
    required List<QuestionModel> questionModelList,
  }) async {
    try {
      final isConnected = await connectivity.currentConnectivityResult;
      if (!isConnected) {
        return Left(ConnectionFailure(errorMessage: 'No internet connection'));
      }
      final surveyId = questionModelList[0].surveyId;
      if (surveyId == null) {
        return Left(
          ServerFailure(errorMessage: 'Survey Id is null'),
        );
      }
      final surveyRef = surveyFirebaseConverter
          .collectionRef(FirebaseCollectionEnum.surveys)
          .doc(surveyId);

      final questionsCollectionRef =
          surveyRef.collection(FirebaseCollectionEnum.questions.collectionName);

      // Her bir soruyu questions alt koleksiyonuna ekle
      for (final model in questionModelList) {
        await questionsCollectionRef
            .doc(
              model.questionId,
            )
            .set(model.toJson());
      }

      return const Right(true);
    } catch (e) {
      return Left(FailureHandler.handleFailure(e: e));
    }
  }

  @override
  Future<Either<Failure, bool>> removeSurvey({required String surveyId}) async {
    try {
      final surveyRef = surveyFirebaseConverter
          .collectionRef(FirebaseCollectionEnum.surveys)
          .doc(surveyId);

      final querySnapshot = await surveyRef
          .collection(FirebaseCollectionEnum.questions.collectionName)
          .get();
      for (final doc in querySnapshot.docs) {
        await doc.reference.delete();
      }
      await surveyRef.delete();
      return const Right(true);
    } catch (e) {
      return Left(ServerFailure(errorMessage: e.toString()));
    }
  }
}
