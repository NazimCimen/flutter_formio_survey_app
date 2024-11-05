// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserModel _$UserModelFromJson(Map<String, dynamic> json) => UserModel(
      userId: json['userId'] as String?,
      userName: json['userName'] as String?,
      mail: json['mail'] as String?,
      password: json['password'] as String?,
      userDescription: json['userDescription'] as String?,
      publishedSurveyIds: (json['publishedSurveyIds'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$UserModelToJson(UserModel instance) => <String, dynamic>{
      'userId': instance.userId,
      'userName': instance.userName,
      'mail': instance.mail,
      'password': instance.password,
      'userDescription': instance.userDescription,
      'publishedSurveyIds': instance.publishedSurveyIds,
    };
