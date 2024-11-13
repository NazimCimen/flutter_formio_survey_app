import 'dart:async';
import 'package:flutter_survey_app_mobile/core/error/exception.dart';
import 'package:flutter_survey_app_mobile/product/constants/app_durations.dart';
import 'package:flutter_survey_app_mobile/product/firebase/model/base_firebase_model.dart';
import 'package:flutter_survey_app_mobile/product/firebase/service/base_firebase_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseServiceImpl<T extends BaseFirebaseModel<T>>
    implements BaseFirebaseService<T> {
  final FirebaseFirestore firestore;
  FirebaseServiceImpl({
    required this.firestore,
  });

  /// TO SAVE ITEM IN FIRESTORE
  @override
  Future<void> setItem(String collectionPath, T item) async {
    await firestore
        .collection(collectionPath)
        .doc(item.id)
        .set(item.toJson())
        .timeout(
      AppDurations.timeoutDuration,
      onTimeout: () {
        throw TimeoutException('timeout');
      },
    );
  }

  /// TO UPDATE ITEM IN FIRESTORE
  @override
  Future<void> updateItem(String collectionPath, String docId, T item) async {
    await firestore
        .collection(collectionPath)
        .doc(docId)
        .update(item.toJson())
        .timeout(
      AppDurations.timeoutDuration,
      onTimeout: () {
        throw TimeoutException('timeout');
      },
    );
  }

  /// TO DELETE ITEM IN FIRESTORE
  @override
  Future<void> deleteItem(
    String collectionPath,
    String docId,
  ) async {
    await firestore.collection(collectionPath).doc(docId).delete().timeout(
      AppDurations.timeoutDuration,
      onTimeout: () {
        throw TimeoutException('timeout');
      },
    );
  }

  /// TO DELETE ITEM SUB COLLECTIONS IN FIRESTORE
  @override
  Future<void> deleteSubCollections(
    List<String> subCollections,
  ) async {
    for (final subCol in subCollections) {
      final snapshots = await firestore.collection(subCol).get();
      for (final doc in snapshots.docs) {
        await doc.reference.delete().timeout(
          AppDurations.timeoutDuration,
          onTimeout: () {
            throw TimeoutException('timeout');
          },
        );
      }
    }
  }

  /// TO GET ITEM FROM FIRETORE
  @override
  Future<T> getItem({
    required String collectionPath,
    required String docId,
    required T model,
  }) async {
    final snapshot =
        await firestore.collection(collectionPath).doc(docId).get().timeout(
      AppDurations.timeoutDuration,
      onTimeout: () {
        throw TimeoutException('timeout');
      },
    );
    final data = snapshot.data();
    if (data == null) {
      throw ServerException('Data not found');
    }
    final item = model.fromJson(data);
    return item;
  }
}
