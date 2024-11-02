import 'package:flutter/material.dart';
import 'package:flutter_survey_app_mobile/config/routes/app_routes.dart';
import 'package:flutter_survey_app_mobile/config/routes/navigator_service.dart';
import 'package:flutter_survey_app_mobile/feature/create_survey/presentation/view/create_questions_view.dart';
import 'package:flutter_survey_app_mobile/feature/create_survey/presentation/viewmodel/create_survey_view_model.dart';
import 'package:flutter_survey_app_mobile/product/componets/custom_snack_bars.dart';
import 'package:provider/provider.dart';

mixin CreateQuestionsViewMixin on State<CreateQuestionsView> {
  Future<void> shareSurvey() async {
    await context.read<CreateSurveyViewModel>().shareSurvey();
    WidgetsBinding.instance.addPostFrameCallback(
      (_) {
        if (context.read<CreateSurveyViewModel>().state ==
            ViewState.noAddedQuestion) {
          CustomSnackBars.showCustomScaffoldSnackBar(
            context: context,
            text: 'Lütfen Anketinize soru ekleyin',
          );
        } else if (context.read<CreateSurveyViewModel>().state ==
            ViewState.success) {
          NavigatorService.pushNamedAndRemoveUntil(
              AppRoutes.surveySharedSuccessView,
              arguments: context.read<CreateSurveyViewModel>().getSurveyLink());
        }
      },
    );
  }
}
