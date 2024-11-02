part of 'home_view.dart';

class _AppBar extends StatelessWidget implements PreferredSizeWidget {
  const _AppBar();

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      leading: Builder(
        builder: (BuildContext context) {
          return GestureDetector(
            onTap: () {
              Scaffold.of(context).openDrawer();
            },
            child: Padding(
              padding: context.paddingAllLow,
              child: Image.asset(
                ImageEnums.formioo2.toPathPng,
                fit: BoxFit.contain,
              ),
            ),
          );
        },
      ),
      centerTitle: true,
      title: const CustomTextHeadlineTitleWidget(title: 'Formio'),
      actions: [
        Padding(
          padding: context.paddingAllLow,
          child: GestureDetector(
            child: SizedBox(
              height: context.dynamicHeight(0.04),
              child: Image.asset(
                ImageEnums.notificationIcon.toPathPng,
                color: Theme.of(context).colorScheme.onSurface,
                fit: BoxFit.cover,
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
                      ImageEnums.formioo2.toPathPng,
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

class _TabBarSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Column(
        children: [
          TabBar(
            dividerColor: Colors.transparent,
            indicatorColor: Theme.of(context).colorScheme.onSurface,
            labelColor: Theme.of(context).colorScheme.onSurface,
            unselectedLabelColor: Theme.of(context).colorScheme.tertiary,
            tabs: const [
              Tab(text: 'My Surveys'),
              Tab(text: 'Shared with Me'),
            ],
          ),
        ],
      ),
    );
  }
}

class _SurveyCard extends StatelessWidget {
  const _SurveyCard({
    required this.title,
    required this.subtitle,
    required this.imageUrl,
  });
  final String title;
  final String subtitle;
  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Theme.of(context).colorScheme.onPrimaryContainer,
      shape:
          RoundedRectangleBorder(borderRadius: context.borderRadiusAllMedium),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius: context.borderRadiusTopMedium,
              child: Image.network(
                imageUrl,
                fit: BoxFit.cover,
                width: double.infinity,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) {
                    return child;
                  }
                  return Center(
                    child: CircularProgressIndicator(
                      value: loadingProgress.expectedTotalBytes != null
                          ? loadingProgress.cumulativeBytesLoaded /
                              loadingProgress.expectedTotalBytes!
                          : null,
                    ),
                  );
                },
                errorBuilder: (context, error, stackTrace) {
                  return const Center(
                    child: Icon(
                      Icons.error,
                      color: Colors.red,
                    ),
                  );
                },
              ),
            ),
          ),
          Padding(
            padding: context.paddingAllLow,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomTextSubTitleWidget(subTitle: title),
                CustomTextGreySubTitleWidget(
                  subTitle: subtitle,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _SurveyList extends StatelessWidget {
  const _SurveyList();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: context.paddingHorizAllMedium,
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          childAspectRatio: 1.2,
        ),
        itemCount: 6,
        itemBuilder: (context, index) {
          return _SurveyCard(
            title: 'Virtual sky',
            subtitle: '${index + 1} answered',
            imageUrl: 'https://a.d-cd.net/J3aZtvdAfEzaArEuyR0d17Z_o1s-1920.jpg',
          );
        },
      ),
    );
  }
}
