import 'package:equatable/equatable.dart';

class SurveyEntity extends Equatable {
  final String? surveyId;
  final String? userId;
  final String? surveyTitle;
  final String? surveyDescription;
  final String? surveyImageUrl;
  final DateTime? startDate;
  final DateTime? endDate;
  final DateTime? publicationDate;
  final int? surveyTimeInMinute;
  final int? answeringCount;
  final int? questionCount;

  const SurveyEntity({
    this.surveyDescription,
    this.surveyImageUrl,
    this.startDate,
    this.endDate,
    this.publicationDate,
    this.surveyTimeInMinute,
    this.answeringCount,
    this.surveyId,
    this.userId,
    this.surveyTitle,
    this.questionCount,
  });
  @override
  List<Object?> get props => [
        surveyDescription,
        surveyImageUrl,
        startDate,
        endDate,
        publicationDate,
        surveyTimeInMinute,
        answeringCount,
        surveyId,
        userId,
        surveyTitle,
        questionCount
      ];
  SurveyEntity copyWith({
    String? surveyId,
    String? userId,
    String? surveyTitle,
    String? surveyDescription,
    String? surveyImageUrl,
    DateTime? startDate,
    DateTime? endDate,
    DateTime? publicationDate,
    int? surveyTimeInMinute,
    int? answeringCount,
    int? questionCount,
  }) {
    return SurveyEntity(
      surveyId: surveyId ?? this.surveyId,
      userId: userId ?? this.userId,
      surveyTitle: surveyTitle ?? this.surveyTitle,
      surveyDescription: surveyDescription ?? this.surveyDescription,
      surveyImageUrl: surveyImageUrl ?? this.surveyImageUrl,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      publicationDate: publicationDate ?? this.publicationDate,
      surveyTimeInMinute: surveyTimeInMinute ?? this.surveyTimeInMinute,
      answeringCount: answeringCount ?? this.answeringCount,
      questionCount: questionCount ?? this.questionCount,
    );
  }
}
