import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:flutter_survey_app_mobile/config/localization/string_constants.dart';
import 'package:flutter_survey_app_mobile/config/routes/app_routes.dart';
import 'package:flutter_survey_app_mobile/config/routes/navigator_service.dart';
import 'package:flutter_survey_app_mobile/core/base/base_stateful.dart';
import 'package:flutter_survey_app_mobile/core/base/base_stateless.dart';
import 'package:flutter_survey_app_mobile/core/base/state.dart';
import 'package:flutter_survey_app_mobile/core/utils/size/app_size/dynamic_size.dart';
import 'package:flutter_survey_app_mobile/core/utils/size/border_radius/dynamic_border_radius.dart';
import 'package:flutter_survey_app_mobile/core/utils/size/padding/dynamic_padding.dart';
import 'package:flutter_survey_app_mobile/feature/create_survey/presentation/mixin/create_questions_view_mixin.dart';
import 'package:flutter_survey_app_mobile/feature/create_survey/presentation/view/survey_shared_success_view.dart';
import 'package:flutter_survey_app_mobile/feature/create_survey/presentation/widgets/added_question_header.dart';
import 'package:flutter_survey_app_mobile/feature/create_survey/presentation/widgets/added_question_image.dart';
import 'package:flutter_survey_app_mobile/feature/create_survey/presentation/widgets/added_question_options.dart';
import 'package:flutter_survey_app_mobile/feature/create_survey/presentation/widgets/added_question_rules.dart';
import 'package:flutter_survey_app_mobile/feature/create_survey/presentation/widgets/added_question_title.dart';
import 'package:flutter_survey_app_mobile/feature/shared_layers/domain/entity/question_entity.dart';
import 'package:flutter_survey_app_mobile/feature/create_survey/presentation/viewmodel/create_survey_view_model.dart';
import 'package:flutter_survey_app_mobile/product/decorations/box_decorations/custom_box_decoration.dart';
import 'package:flutter_survey_app_mobile/product/widgets/custom_error_widget.dart';
import 'package:flutter_survey_app_mobile/product/widgets/custom_progress_indicator.dart';
import 'package:flutter_survey_app_mobile/product/widgets/no_internet_widget.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

part '../sub_view/create_questions_sub_view.dart';

class CreateQuestionsView extends StatefulWidget {
  const CreateQuestionsView({super.key});

  @override
  CreateQuestionsViewState createState() => CreateQuestionsViewState();
}

class CreateQuestionsViewState
    extends BaseStateful<CreateQuestionsView, CreateSurveyViewModel>
    with CreateQuestionsViewMixin {
  ValueNotifier<bool> isDialOpen = ValueNotifier(false);

  @override
  Widget build(BuildContext context) {
    return AbsorbPointer(
      absorbing: watchViewModel.state == ViewState.loading,
      child: Scaffold(
        floatingActionButton: _CustomFloatingActionButton(
          isDialOpen: isDialOpen,
        ),
        appBar: _AppBar(
          shareSurvey: shareSurvey,
        ),
        body: SafeArea(
          child: Padding(
            padding: context.paddingAllLow,
            child: Consumer<CreateSurveyViewModel>(
              builder: (context, viewModel, child) {
                if (viewModel.state == ViewState.error) {
                  return CustomErrorWidget(
                    title: StringConstants.error_unknown_msg_try,
                    iconData: Icons.error_outline,
                  );
                } else if (viewModel.state == ViewState.loading) {
                  return const CustomProgressIndicator();
                } else if (viewModel.state == ViewState.noInternet) {
                  return NoInternetWidget(
                    refresh: () async {
                      await viewModel.checkConnectivity();
                    },
                  );
                } else if (viewModel.state == ViewState.success) {
                  return SurveySharedSuccessView(
                    surveyLink: viewModel.getSurveyLink(),
                  );
                } else if (viewModel.questionEntityMap.isNotEmpty) {
                  return const _ShowAddedQuestions();
                } else {
                  return CustomErrorWidget(
                    title: StringConstants.error_no_added_question,
                    iconData: Icons.insert_chart_outlined,
                  );
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}

class _ShowAddedQuestions extends BaseStateless<CreateSurveyViewModel> {
  const _ShowAddedQuestions();

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: context.paddingVertBottomXXlarge,
      itemCount: readViewModel(context).questionEntityMap.length,
      itemBuilder: (context, index) {
        final questionEntity =
            readViewModel(context).questionEntityMap.keys.elementAt(index);
        final image = readViewModel(context).questionEntityMap[questionEntity];
        return Padding(
          padding: context.paddingVertAllLow,
          child: Container(
            padding: context.paddingAllMedium,
            decoration: CustomBoxDecoration.customBoxDecoration(context),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AddedQuestionHeader(questionEntity: questionEntity),
                SizedBox(height: context.dynamicHeight(0.01)),
                AddedQuestionImage(image: image),
                SizedBox(height: context.dynamicHeight(0.02)),
                AddedQuestionTitle(questionEntity: questionEntity),
                SizedBox(height: context.dynamicHeight(0.02)),
                AddedQuestionOptions(questionEntity: questionEntity),
                SizedBox(height: context.dynamicHeight(0.02)),
                AddedQuestionRules(questionEntity: questionEntity),
              ],
            ),
          ),
        );
      },
    );
  }
}
