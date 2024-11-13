import 'package:flutter/material.dart';
import 'package:flutter_survey_app_mobile/core/base/base_stateless.dart';
import 'package:flutter_survey_app_mobile/feature/shared_layers/domain/entity/question_entity.dart';
import 'package:flutter_survey_app_mobile/product/widgets/custom_text_widgets.dart';

class AddedQuestionOptions extends BaseStateless<void> {
  const AddedQuestionOptions({
    required this.questionEntity,
    super.key,
  });

  final QuestionEntity questionEntity;

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: questionEntity.type != QuestionType.openEnded,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const CustomTextSubTitleWidget(
            subTitle: 'Question Options',
          ),
          ...List.generate(
            questionEntity.options != null ? questionEntity.options!.length : 0,
            (index) => Row(
              children: [
                CircleAvatar(
                  radius: 6,
                  backgroundColor: colorScheme(context).tertiary,
                ),
                CustomTextGreySubTitleWidget(
                  subTitle: '  ${questionEntity.options?[index] ?? ''}',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
