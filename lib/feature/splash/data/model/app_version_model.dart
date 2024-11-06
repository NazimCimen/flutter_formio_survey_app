import 'package:flutter_survey_app_mobile/feature/splash/domain/entity/app_version_entity.dart';
import 'package:flutter_survey_app_mobile/product/firebase/model/base_firebase_model.dart';
import 'package:json_annotation/json_annotation.dart';
part 'app_version_model.g.dart';

@JsonSerializable()
class AppVersionModel extends AppVersionEntity
    implements BaseFirebaseModel<AppVersionModel> {
  const AppVersionModel(super.versionNumber);

  @override
  Map<String, dynamic> toJson() => _$AppVersionModelToJson(this);

  @override
  AppVersionModel fromJson(Map<String, dynamic> json) =>
      _$AppVersionModelFromJson(json);

  @override
  String? get id => null;
  AppVersionModel toEntity() {
    return AppVersionModel(versionNumber);
  }
}
