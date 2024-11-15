part of '../view/add_question_view.dart';

class _AppBar extends BaseStateless<void> implements PreferredSizeWidget {
  const _AppBar({
    required this.questionTypeTitle,
  });
  final String questionTypeTitle;
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      automaticallyImplyLeading: false,
      title: Text(
        questionTypeTitle,
        style: textTheme(context).titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
              color: colorScheme(context).primary,
            ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _BottomActionButtons extends BaseStateless<void> {
  final VoidCallback onPressedCancel;
  final VoidCallback onPressedSave;

  const _BottomActionButtons({
    required this.onPressedCancel,
    required this.onPressedSave,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        TextButton(
          onPressed: onPressedCancel,
          child: Text(
            StringConstants.cancel,
            style: textTheme(context).bodyLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: colorScheme(context).tertiaryFixed,
                ),
          ),
        ),
        TextButton(
          onPressed: onPressedSave,
          child: Text(
            StringConstants.save,
            style: textTheme(context).bodyLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: colorScheme(context).tertiaryFixed,
                ),
          ),
        ),
      ],
    );
  }
}
