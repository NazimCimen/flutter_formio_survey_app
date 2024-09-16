// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'survey_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SurveyModel _$SurveyModelFromJson(Map<String, dynamic> json) => SurveyModel(
      surveyId: json['surveyId'] as String?,
      userId: json['userId'] as String?,
      surveyTitle: json['surveyTitle'] as String?,
      surveyDescription: json['surveyDescription'] as String?,
      surveyImageUrl: json['surveyImageUrl'] as String?,
      answeringCount: (json['answeringCount'] as num?)?.toInt(),
      endDate: json['endDate'] == null
          ? null
          : DateTime.parse(json['endDate'] as String),
      startDate: json['startDate'] == null
          ? null
          : DateTime.parse(json['startDate'] as String),
      publicationDate: json['publicationDate'] == null
          ? null
          : DateTime.parse(json['publicationDate'] as String),
      surveyTimeInMinute: (json['surveyTimeInMinute'] as num?)?.toInt(),
      questionCount: (json['questionCount'] as num?)?.toInt(),
    );

Map<String, dynamic> _$SurveyModelToJson(SurveyModel instance) =>
    <String, dynamic>{
      'surveyId': instance.surveyId,
      'userId': instance.userId,
      'surveyTitle': instance.surveyTitle,
      'surveyDescription': instance.surveyDescription,
      'surveyImageUrl': instance.surveyImageUrl,
      'startDate': instance.startDate?.toIso8601String(),
      'endDate': instance.endDate?.toIso8601String(),
      'publicationDate': instance.publicationDate?.toIso8601String(),
      'surveyTimeInMinute': instance.surveyTimeInMinute,
      'answeringCount': instance.answeringCount,
      'questionCount': instance.questionCount,
    };
