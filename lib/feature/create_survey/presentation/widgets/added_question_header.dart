import 'package:flutter/material.dart';
import 'package:flutter_survey_app_mobile/core/base/base_stateless.dart';
import 'package:flutter_survey_app_mobile/feature/create_survey/presentation/viewmodel/create_survey_view_model.dart';
import 'package:flutter_survey_app_mobile/feature/shared_layers/domain/entity/question_entity.dart';

class AddedQuestionHeader extends BaseStateless<CreateSurveyViewModel> {
  const AddedQuestionHeader({
    required this.questionEntity,
    super.key,
  });

  final QuestionEntity questionEntity;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          questionEntity.type?.qType ?? '',
          style: textTheme(context).bodyMedium?.copyWith(
                color: colorScheme(context).tertiaryFixed,
                fontWeight: FontWeight.bold,
              ),
        ),
        GestureDetector(
          onTap: () {
            readViewModel(context).deleteQuestionEntity(questionEntity);
          },
          child: const Icon(Icons.remove_circle_outline),
        ),
      ],
    );
  }
}
