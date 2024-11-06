import 'package:flutter/material.dart';
import 'package:flutter_survey_app_mobile/core/base/base_stateful.dart';
import 'package:flutter_survey_app_mobile/core/base/state.dart';
import 'package:flutter_survey_app_mobile/feature/home/presentation/view/home_view.dart';
import 'package:flutter_survey_app_mobile/feature/home/presentation/viewmodel/home_view_model.dart';
import 'package:provider/provider.dart';

mixin HomeViewMixin on BaseStateful<HomeView, HomeViewModel> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback(
      (_) async {
        await context.read<HomeViewModel>().getSurveyIds(userId: '123456');
      },
    );
    super.initState();
  }

  bool isVisibleFloatActionButton() {
    return watchViewModel.state != ViewState.loading &&
        watchViewModel.publishedSurveys.isNotEmpty;
  }
}
