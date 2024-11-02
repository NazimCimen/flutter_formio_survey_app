part of '../view/create_questions_view.dart';

class _CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final VoidCallback shareSurvey;
  const _CustomAppBar({required this.shareSurvey});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      forceMaterialTransparency: true,
      elevation: 0,
      leading: GestureDetector(
        onTap: () {
          NavigatorService.goBack();
        },
        child: const Icon(Icons.arrow_back_ios_new_outlined),
      ),
      backgroundColor: Colors.transparent,
      title: Text(
        'Create Your Questions',
        style: Theme.of(context).textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.primary,
            ),
      ),
      actions: [
        Padding(
          padding: context.paddingHorizRightLow,
          child: InkWell(
            onTap: shareSurvey,
            child: Text(
              'SHARE',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: Theme.of(context).colorScheme.onSecondary,
                  ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _CustomFloatingActionButton extends StatelessWidget {
  final ValueNotifier<bool> isDialOpen;

  const _CustomFloatingActionButton({
    required this.isDialOpen,
  });

  @override
  Widget build(BuildContext context) {
    return SpeedDial(
      icon: Icons.add,
      openCloseDial: isDialOpen,
      activeIcon: Icons.close,
      iconTheme: IconThemeData(
        color: Theme.of(context).colorScheme.onTertiary,
      ),
      shape: ContinuousRectangleBorder(
        borderRadius: context.borderRadiusAllMedium,
      ),
      activeBackgroundColor: Theme.of(context).colorScheme.secondaryContainer,
      backgroundColor: Theme.of(context).colorScheme.primary,
      overlayColor: Theme.of(context).colorScheme.surface,
      overlayOpacity: 0.5,
      spacing: 10,
      spaceBetweenChildren: 10,
      children: [
        _buildSpeedDialChild(
          icon: Icons.list_outlined,
          label: 'Çoktan Seçmeli',
          type: QuestionType.multipleChoice,
          context: context,
        ),
        _buildSpeedDialChild(
          icon: Icons.expand_more,
          label: 'Aşağı Açılır Menu',
          type: QuestionType.dropdown,
          context: context,
        ),
        _buildSpeedDialChild(
          icon: Icons.short_text_outlined,
          label: 'Açık Uçlu',
          type: QuestionType.openEnded,
          context: context,
        ),
      ],
    );
  }

  SpeedDialChild _buildSpeedDialChild({
    required IconData icon,
    required String label,
    required QuestionType type,
    required BuildContext context,
  }) {
    return SpeedDialChild(
      child: Icon(icon, color: Theme.of(context).colorScheme.primary),
      label: label,
      labelStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: Theme.of(context).colorScheme.primary,
            fontWeight: FontWeight.bold,
          ),
      onTap: () {
        isDialOpen.value = false;
        NavigatorService.pushNamed(
          AppRoutes.addQuestionView,
          arguments: QuestionEntity(
            questionId: const Uuid().v1(),
            type: type,
            surveyId:
                context.read<CreateSurveyViewModel>().surveyEntity.surveyId,
          ),
        );
      },
    );
  }
}

class _Header extends StatelessWidget {
  const _Header({
    required this.questionEntity,
  });

  final QuestionEntity questionEntity;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          questionEntity.type?.qType ?? '',
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Colors
                    .orange, //Theme.of(context).colorScheme.tertiaryContainer,
                fontWeight: FontWeight.bold,
              ),
        ),
        GestureDetector(
          onTap: () {
            context
                .read<CreateSurveyViewModel>()
                .deleteQuestionEntity(questionEntity);
          },
          child: const Icon(Icons.remove_circle_outline),
        ),
      ],
    );
  }
}

class _QuestionImage extends StatelessWidget {
  const _QuestionImage({
    required this.image,
  });

  final Uint8List? image;

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: image != null,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const CustomTextSubTitleWidget(
            subTitle: 'Question Image',
          ),
          SizedBox(height: context.dynamicHeight(0.005)),
          AspectRatio(
            aspectRatio: ImageAspectRatioEnum.questionImage.ratioCrop.ratioX /
                ImageAspectRatioEnum.questionImage.ratioCrop.ratioY,
            child: Container(
              decoration: CustomBoxDecoration.customBoxDecorationForImage(
                context,
              ),
              child: image != null
                  ? Image.memory(
                      image!,
                    )
                  : const SizedBox.shrink(),
            ),
          ),
        ],
      ),
    );
  }
}

class _QuestionTitle extends StatelessWidget {
  const _QuestionTitle({
    required this.questionEntity,
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

class _QuestionOptions extends StatelessWidget {
  const _QuestionOptions({
    required this.questionEntity,
  });

  final QuestionEntity questionEntity;

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: questionEntity.type != QuestionType.openEnded,
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        const CustomTextSubTitleWidget(
          subTitle: 'Question Options',
        ),
        ...List.generate(
          questionEntity.options != null ? questionEntity.options!.length : 0,
          (index) => Row(
            children: [
              CircleAvatar(
                radius: 6,
                backgroundColor: Theme.of(context).colorScheme.tertiary,
              ),
              CustomTextGreySubTitleWidget(
                subTitle: '  ${questionEntity.options?[index] ?? ''}',
              ),
            ],
          ),
        )
      ]),
    );
  }
}

class _QuestionRules extends StatelessWidget {
  const _QuestionRules({
    required this.questionEntity,
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
