abstract class BaseFirebaseModel<T> {
  String? get id;
  T fromJson(Map<String, dynamic> json);
  Map<String, dynamic> toJson();
}
