import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_survey_app/product/firebase/base_firebase_model.dart';
import 'package:flutter_survey_app/product/firebase/firebase_collection_enum.dart';

class FirebaseConverter<T extends BaseFirebaseModel<T>> {
  final T model;
  final FirebaseFirestore firestore;

  FirebaseConverter({
    required this.model,
    required this.firestore,
  });

  CollectionReference<T> collectionRef(FirebaseCollectionEnum collectionEnum) {
    return collectionEnum.getReference(firestore).withConverter<T>(
          fromFirestore: (snapshot, _) {
            final data = snapshot.data();
            if (data != null) {
              return model.fromJson(data);
            } else {
              throw Exception('Cannot deserialize Firestore data');
            }
          },
          toFirestore: (model, _) => model.toJson(),
        );
  }
}
