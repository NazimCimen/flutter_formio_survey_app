import 'package:flutter/material.dart';
import 'package:flutter_survey_app_mobile/config/localization/string_constants.dart';
import 'package:flutter_survey_app_mobile/config/routes/app_routes.dart';
import 'package:flutter_survey_app_mobile/config/routes/navigator_service.dart';
import 'package:flutter_survey_app_mobile/core/base/base_stateful.dart';
import 'package:flutter_survey_app_mobile/core/base/state.dart';
import 'package:flutter_survey_app_mobile/feature/create_survey/presentation/view/create_questions_view.dart';
import 'package:flutter_survey_app_mobile/feature/create_survey/presentation/viewmodel/create_survey_view_model.dart';
import 'package:flutter_survey_app_mobile/product/componets/custom_snack_bars.dart';

mixin CreateQuestionsViewMixin
    on BaseStateful<CreateQuestionsView, CreateSurveyViewModel> {
  Future<void> shareSurvey() async {
    await readViewModel.shareSurvey();
    WidgetsBinding.instance.addPostFrameCallback(
      (_) {
        if (readViewModel.state == ViewState.noAddedQuestion) {
          CustomSnackBars.showCustomScaffoldSnackBar(
            context: context,
            text: StringConstants.add_question_to_survey,
          );
        } else if (readViewModel.state == ViewState.success) {
          NavigatorService.pushNamedAndRemoveUntil(
            AppRoutes.surveySharedSuccessView,
            arguments: readViewModel.getSurveyLink(),
          );
        }
      },
    );
  }
}
