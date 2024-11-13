import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  final String? userId;
  final String? userName;
  final String? mail;
  final String? password;
  final String? userDescription;
  final List<String>? publishedSurveyIds;
  const UserEntity({
    this.userId,
    this.userName,
    this.mail,
    this.password,
    this.userDescription,
    this.publishedSurveyIds,
  });
  @override
  List<Object?> get props => [
        userId,
        userName,
        mail,
        password,
        userDescription,
        publishedSurveyIds,
      ];
  UserEntity copyWith({
    String? userId,
    String? userName,
    String? mail,
    String? password,
    String? userDescription,
    List<String>? publishedSurveyIds,
  }) {
    return UserEntity(
      userId: userId ?? this.userId,
      userName: userName ?? this.userName,
      mail: mail ?? this.mail,
      password: password ?? this.password,
      userDescription: userDescription ?? this.userDescription,
      publishedSurveyIds: publishedSurveyIds ?? this.publishedSurveyIds,
    );
  }
}
