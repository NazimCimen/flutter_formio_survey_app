part of '../view/create_survey_info_view.dart';

class _AppBar extends BaseStateless<void> implements PreferredSizeWidget {
  final VoidCallback closePage;
  final VoidCallback navigateAndSetSurveyInfoValues;

  const _AppBar({
    required this.closePage,
    required this.navigateAndSetSurveyInfoValues,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      forceMaterialTransparency: true,
      leading: GestureDetector(
        onTap: closePage,
        child: const Icon(Icons.close_outlined),
      ),
      backgroundColor: Colors.transparent,
      elevation: 0,
      title: Text(
        'Create Your Survey',
        style: textTheme(context).titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
              color: colorScheme(context).primary,
            ),
      ),
      actions: [
        Padding(
          padding: context.paddingHorizRightLow,
          child: InkWell(
            onTap: navigateAndSetSurveyInfoValues,
            child: Text(
              'NEXT',
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
