import 'package:flutter_survey_app_mobile/feature/shared_layers/domain/entity/question_entity.dart';
import 'package:flutter_survey_app_mobile/product/firebase/model/base_firebase_model.dart';
import 'package:json_annotation/json_annotation.dart';
part 'question_model.g.dart';

@JsonSerializable()
class QuestionModel extends QuestionEntity
    implements BaseFirebaseModel<QuestionModel> {
  const QuestionModel({
    super.questionId,
    super.surveyId,
    super.imageUrl,
    super.type,
    super.title,
    super.options,
    super.addOptionOther,
    super.isRequired,
    super.multipleChoices,
  });
  @override
  String? get id => questionId;
  @override
  QuestionModel fromJson(Map<String, dynamic> json) =>
      _$QuestionModelFromJson(json);
  @override
  Map<String, dynamic> toJson() => _$QuestionModelToJson(this);
  factory QuestionModel.fromEntity(QuestionEntity entity) {
    return QuestionModel(
      questionId: entity.questionId,
      surveyId: entity.surveyId,
      type: entity.type,
      title: entity.title,
      imageUrl: entity.imageUrl,
      options: entity.options,
      isRequired: entity.isRequired,
      addOptionOther: entity.addOptionOther,
      multipleChoices: entity.multipleChoices,
    );
  }

  QuestionEntity toEntity() {
    return QuestionEntity(
      questionId: questionId,
      surveyId: surveyId,
      type: type,
      title: title,
      imageUrl: imageUrl,
      options: options,
      isRequired: isRequired,
      addOptionOther: addOptionOther,
      multipleChoices: multipleChoices,
    );
  }
}
