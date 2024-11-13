import 'package:flutter/material.dart';
import 'package:flutter_survey_app_mobile/feature/shared_layers/domain/entity/question_entity.dart';
import 'package:flutter_survey_app_mobile/product/widgets/custom_text_widgets.dart';

class AddedQuestionTitle extends StatelessWidget {
  const AddedQuestionTitle({
    required this.questionEntity,
    super.key,
  });

  final QuestionEntity questionEntity;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const CustomTextSubTitleWidget(
          subTitle: 'Question Title',
        ),
        CustomTextGreySubTitleWidget(
          subTitle: questionEntity.title ?? '',
          maxLine: 2,
        ),
      ],
    );
  }
}
