import 'package:flutter/material.dart';
import 'package:flutter_survey_app_mobile/config/routes/app_routes.dart';
import 'package:flutter_survey_app_mobile/config/routes/navigator_service.dart';
import 'package:flutter_survey_app_mobile/core/utils/app_size_extensions.dart';
import 'package:flutter_survey_app_mobile/core/utils/image_enum.dart';
import 'package:flutter_survey_app_mobile/feature/home/presentation/view/mobile/home_view.dart';
import 'package:flutter_survey_app_mobile/feature/nav_bar/mixin/nav_bar_view_mixin.dart';
import 'package:flutter_survey_app_mobile/feature/profile/presentation/view/profile_view.dart';

class NavBarView extends StatefulWidget {
  const NavBarView({super.key});
  @override
  NavBarViewState createState() => NavBarViewState();
}

class NavBarViewState extends State<NavBarView> with NavBarViewMixin {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      initialIndex: currentIndex,
      child: const Scaffold(
        body: TabBarView(
          physics: NeverScrollableScrollPhysics(),
          children: [
            HomeView(),
            ProfileView(),
          ],
        ),
        floatingActionButton: _FloatActionButton(),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: _BottomAppBar(),
      ),
    );
  }
}

class _BottomAppBar extends StatelessWidget {
  const _BottomAppBar();

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      notchMargin: 2,
      height: context.dynamicHeight(0.07),
      padding: context.paddingAllMedium,
      color: Theme.of(context).colorScheme.onPrimaryContainer,
      child: TabBar(
        dividerColor: Colors.transparent,
        tabs: [
          Image.asset(
            ImageEnums.homeIcon.toPathPng,
            color: Theme.of(context).colorScheme.onSurface,
            fit: BoxFit.cover,
            height: context.dynamicHeight(0.025),
          ),
          Image.asset(
            ImageEnums.profileIcon.toPathPng,
            color: Theme.of(context).colorScheme.onSurface,
            fit: BoxFit.cover,
            height: context.dynamicHeight(0.025),
          ),
        ],
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
