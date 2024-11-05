import 'package:flutter_survey_app_mobile/feature/shared_layers/domain/entity/user_entity.dart';
import 'package:flutter_survey_app_mobile/product/firebase/model/base_firebase_model.dart';
import 'package:json_annotation/json_annotation.dart';
part 'user_model.g.dart';

@JsonSerializable()
class UserModel extends UserEntity implements BaseFirebaseModel<UserModel> {
  const UserModel({
    super.userId,
    super.userName,
    super.mail,
    super.password,
    super.userDescription,
    super.publishedSurveyIds,
  });
  @override
  UserModel fromJson(Map<String, dynamic> json) => _$UserModelFromJson(json);

  @override
  String? get id => userId;

  @override
  Map<String, dynamic> toJson() => _$UserModelToJson(this);
}
