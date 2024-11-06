import 'package:flutter/material.dart';
import 'package:flutter_survey_app_mobile/feature/shared_layers/domain/entity/question_entity.dart';
import 'package:flutter_survey_app_mobile/product/widgets/custom_text_widgets.dart';

class AddedQuestionRules extends StatelessWidget {
  const AddedQuestionRules({
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
          subTitle: 'Rules',
        ),
        _QuestionRuleDetail(
          title: 'Cevaplaması zorunlu soru',
          condition: questionEntity.isRequired,
        ),
        Visibility(
          visible: questionEntity.type == QuestionType.multipleChoice,
          child: _QuestionRuleDetail(
            title: 'Çoklu Seçim Özelliği',
            condition: questionEntity.multipleChoices,
          ),
        ),
        Visibility(
          visible: questionEntity.type != QuestionType.openEnded,
          child: _QuestionRuleDetail(
            title: 'Seçeneklere Diğer ekle',
            condition: questionEntity.addOptionOther,
          ),
        ),
      ],
    );
  }
}

class _QuestionRuleDetail extends StatelessWidget {
  final String title;
  final bool? condition;
  const _QuestionRuleDetail({
    required this.title,
    required this.condition,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CustomTextGreySubTitleWidget(
          subTitle: title,
        ),
        if (condition != true)
          Icon(
            Icons.close,
            color: Theme.of(context).colorScheme.secondaryContainer,
          )
        else
          Icon(
            Icons.check,
            color: Theme.of(context).colorScheme.tertiaryContainer,
          ),
      ],
    );
  }
}
