import 'package:flutter/material.dart';
import 'package:flutter_survey_app_mobile/feature/create_survey/presentation/viewmodel/create_survey_view_model.dart';
import 'package:flutter_survey_app_mobile/feature/home/presentation/view/home_view.dart';
import 'package:flutter_survey_app_mobile/feature/home/presentation/viewmodel/home_view_model.dart';
import 'package:provider/provider.dart';

mixin HomeViewMixin on State<HomeView> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback(
      (_) async {
        context.read<HomeViewModel>().setState(ViewState.loading);
        await context.read<HomeViewModel>().getSurveyIds(userId: '12345');
      },
    );
    super.initState();
  }
}
