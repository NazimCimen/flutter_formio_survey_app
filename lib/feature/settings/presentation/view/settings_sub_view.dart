part of 'settings_view.dart';

class _AppBar extends StatelessWidget implements PreferredSizeWidget {
  const _AppBar();

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Theme.of(context).colorScheme.surface,
      title: CustomTextHeadlineTitleWidget(title: StringConstants.settings),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
