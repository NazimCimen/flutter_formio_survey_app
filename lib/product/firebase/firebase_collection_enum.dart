import 'package:cloud_firestore/cloud_firestore.dart';

enum FirebaseCollectionEnum {
  version('version'),
  surveys('surveys'),
  questions('questions'),
  user('user');

  final String collectionName;

  const FirebaseCollectionEnum(this.collectionName);

  CollectionReference getReference(FirebaseFirestore firestore) =>
      firestore.collection(collectionName);
}
