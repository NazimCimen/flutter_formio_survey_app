part of 'home_view.dart';

class _AppBar extends StatelessWidget implements PreferredSizeWidget {
  const _AppBar();

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      centerTitle: true,
      title: CustomTextHeadlineTitleWidget(title: StringConstants.appName),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _DrawerWidget extends StatelessWidget {
  const _DrawerWidget();

  @override
  Widget build(BuildContext context) {
    return Drawer(
      elevation: 0,
      shape: ContinuousRectangleBorder(
        borderRadius: context.borderRadiusTopMedium,
      ),
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.onPrimaryContainer,
        ),
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: Row(
                children: [
                  Padding(
                    padding: context.paddingAllLow,
                    child: Image.asset(
                      ImageEnums.appLogo.toPathPng,
                      fit: BoxFit.cover,
                      height: context.dynamicHeight(0.1),
                    ),
                  ),
                  const CustomTextHeadlineTitleWidget(title: 'Formio'),
                ],
              ),
            ),
            _DrawerListTile(
              iconData: Icons.settings_outlined,
              text: StringConstants.settings,
            ),
            _DrawerListTile(
              iconData: Icons.help_outline,
              text: StringConstants.help_center,
            ),
            _DrawerListTile(
              iconData: Icons.chat_bubble_outline,
              text: StringConstants.give_feedback,
            ),
            _DrawerListTile(
              iconData: Icons.app_shortcut_outlined,
              text: StringConstants.about_app,
            ),
            _DrawerListTile(
              iconData: Icons.privacy_tip_outlined,
              text: StringConstants.policy_privacy,
            ),
          ],
        ),
      ),
    );
  }
}

class _FloatActionButton extends StatelessWidget {
  const _FloatActionButton();

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        NavigatorService.pushNamed(AppRoutes.createSurveyInfoView);
      },
      child: Icon(
        Icons.add_outlined,
        color: Theme.of(context).colorScheme.onSurface,
        size: context.dynamicHeight(0.03),
      ),
    );
  }
}

class _DrawerListTile extends StatelessWidget {
  final IconData iconData;
  final String text;

  const _DrawerListTile({required this.iconData, required this.text});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(iconData, color: Theme.of(context).colorScheme.onSurface),
      title: Text(
        text,
        style: Theme.of(context)
            .textTheme
            .bodyLarge
            ?.copyWith(color: Theme.of(context).colorScheme.onSurface),
      ),
      onTap: () {
        NavigatorService.pushNamed(AppRoutes.settingsView);
      },
    );
  }
}
