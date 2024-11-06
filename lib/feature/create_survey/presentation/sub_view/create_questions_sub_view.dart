part of '../view/create_questions_view.dart';

class _AppBar extends BaseStateless<void> implements PreferredSizeWidget {
  final VoidCallback shareSurvey;
  const _AppBar({required this.shareSurvey});

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
        style: textTheme(context).titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
              color: colorScheme(context).primary,
            ),
      ),
      actions: [
        Padding(
          padding: context.paddingHorizRightLow,
          child: InkWell(
            onTap: shareSurvey,
            child: Text(
              'SHARE',
              style: textTheme(context).titleLarge?.copyWith(
                    color: colorScheme(context).onSecondary,
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

class _CustomFloatingActionButton extends BaseStateless<CreateSurveyViewModel> {
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
        color: colorScheme(context).onTertiary,
      ),
      shape: ContinuousRectangleBorder(
        borderRadius: context.borderRadiusAllMedium,
      ),
      activeBackgroundColor: colorScheme(context).secondaryContainer,
      backgroundColor: colorScheme(context).primary,
      overlayColor: colorScheme(context).surface,
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
      child: Icon(icon, color: colorScheme(context).primary),
      label: label,
      labelStyle: textTheme(context).bodyMedium?.copyWith(
            color: colorScheme(context).primary,
            fontWeight: FontWeight.bold,
          ),
      onTap: () {
        isDialOpen.value = false;
        NavigatorService.pushNamed(
          AppRoutes.addQuestionView,
          arguments: QuestionEntity(
            questionId: const Uuid().v1(),
            type: type,
            surveyId: readViewModel(context).surveyEntity.surveyId,
          ),
        );
      },
    );
  }
}
