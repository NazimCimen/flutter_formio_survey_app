import 'package:flutter/material.dart';
import 'package:flutter_survey_app_mobile/feature/home/presentation/view/mobile/home_view.dart';
import 'package:flutter_survey_app_mobile/feature/nav_bar/view/nav_bar_view.dart';
import 'package:flutter_survey_app_mobile/feature/profile/presentation/view/profile_view.dart';

mixin NavBarViewMixin on State<NavBarView> {
  int currentIndex = 0;

  final List<Widget> pages = [
    const HomeView(),
    const ProfileView(),
  ];
  void onPageChanged(int index) {
    setState(
      () {
        currentIndex = index;
      },
    );
  }
}
