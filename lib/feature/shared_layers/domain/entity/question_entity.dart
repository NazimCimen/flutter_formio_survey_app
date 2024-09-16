import 'package:equatable/equatable.dart';

enum QuestionType {
  multipleChoice,
  openEnded,
  dropdown,
}

extension QuestionTypeExtension on QuestionType {
  String get qType {
    switch (this) {
      case QuestionType.multipleChoice:
        return 'Multiple Choice';
      case QuestionType.openEnded:
        return 'Open Ended';
      case QuestionType.dropdown:
        return 'Dropdown';
    }
  }
}

class QuestionEntity extends Equatable {
  final String? questionId;
  final String? surveyId;
  final QuestionType? type;
  final String? imageUrl;
  final String? title;
  final List<String>? options;
  final bool? multipleChoices;
  final bool? isRequired;
  final bool? addOptionOther;
  const QuestionEntity({
    this.questionId,
    this.surveyId,
    this.type,
    this.imageUrl,
    this.title,
    this.options,
    this.multipleChoices,
    this.isRequired,
    this.addOptionOther,
  });

  @override
  List<Object?> get props => [
        questionId,
        surveyId,
        type,
        imageUrl,
        title,
        options,
        multipleChoices,
        isRequired,
        addOptionOther,
      ];
  QuestionEntity copyWith({
    String? questionId,
    String? surveyId,
    QuestionType? type,
    String? imageUrl,
    String? title,
    List<String>? options,
    bool? multipleChoices,
    bool? isRequired,
    bool? addOptionOther,
  }) {
    return QuestionEntity(
      questionId: questionId ?? this.questionId,
      surveyId: surveyId ?? this.surveyId,
      type: type ?? this.type,
      imageUrl: imageUrl ?? this.imageUrl,
      title: title ?? this.title,
      options: options ?? this.options,
      multipleChoices: multipleChoices ?? this.multipleChoices,
      isRequired: isRequired ?? this.isRequired,
      addOptionOther: addOptionOther ?? this.addOptionOther,
    );
  }
}
