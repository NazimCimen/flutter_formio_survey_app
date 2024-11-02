import 'package:flutter_survey_app_mobile/feature/shared_layers/domain/entity/survey_entity.dart';
import 'package:flutter_survey_app_mobile/product/firebase/model/base_firebase_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'survey_model.g.dart';

@JsonSerializable(explicitToJson: true)
class SurveyModel extends SurveyEntity
    implements BaseFirebaseModel<SurveyModel> {
  const SurveyModel({
    super.surveyId,
    super.userId,
    super.surveyTitle,
    super.surveyDescription,
    super.surveyImageUrl,
    super.answeringCount,
    super.endDate,
    super.startDate,
    super.publicationDate,
    super.surveyTimeInMinute,
    super.questionCount,
  });
  @override
  String? get id => surveyId;

  @override
  SurveyModel fromJson(Map<String, dynamic> json) =>
      _$SurveyModelFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$SurveyModelToJson(this);

  factory SurveyModel.fromEntity(SurveyEntity entity) {
    return SurveyModel(
      surveyId: entity.surveyId,
      userId: entity.userId,
      surveyTitle: entity.surveyTitle,
      surveyDescription: entity.surveyDescription,
      surveyImageUrl: entity.surveyImageUrl,
      answeringCount: entity.answeringCount,
      startDate: entity.startDate,
      endDate: entity.endDate,
      publicationDate: entity.publicationDate,
      surveyTimeInMinute: entity.surveyTimeInMinute,
      questionCount: entity.questionCount,
    );
  }

  SurveyEntity toEntity() {
    return SurveyEntity(
      surveyId: surveyId,
      userId: userId,
      surveyTitle: surveyTitle,
      surveyDescription: surveyDescription,
      surveyImageUrl: surveyImageUrl,
      answeringCount: answeringCount,
      startDate: startDate,
      endDate: endDate,
      publicationDate: publicationDate,
      surveyTimeInMinute: surveyTimeInMinute,
      questionCount: questionCount,
    );
  }
}
