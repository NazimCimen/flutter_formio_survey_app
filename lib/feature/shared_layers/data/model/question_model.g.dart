// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'question_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

QuestionModel _$QuestionModelFromJson(Map<String, dynamic> json) =>
    QuestionModel(
      questionId: json['questionId'] as String?,
      surveyId: json['surveyId'] as String?,
      imageUrl: json['imageUrl'] as String?,
      type: $enumDecodeNullable(_$QuestionTypeEnumMap, json['type']),
      title: json['title'] as String?,
      options:
          (json['options'] as List<dynamic>?)?.map((e) => e as String).toList(),
      addOptionOther: json['addOptionOther'] as bool?,
      isRequired: json['isRequired'] as bool?,
      multipleChoices: json['multipleChoices'] as bool?,
    );

Map<String, dynamic> _$QuestionModelToJson(QuestionModel instance) =>
    <String, dynamic>{
      'questionId': instance.questionId,
      'surveyId': instance.surveyId,
      'type': _$QuestionTypeEnumMap[instance.type],
      'imageUrl': instance.imageUrl,
      'title': instance.title,
      'options': instance.options,
      'multipleChoices': instance.multipleChoices,
      'isRequired': instance.isRequired,
      'addOptionOther': instance.addOptionOther,
    };

const _$QuestionTypeEnumMap = {
  QuestionType.multipleChoice: 'multipleChoice',
  QuestionType.openEnded: 'openEnded',
  QuestionType.dropdown: 'dropdown',
};
