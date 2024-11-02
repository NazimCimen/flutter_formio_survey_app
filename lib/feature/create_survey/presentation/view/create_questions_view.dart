import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:flutter_survey_app_mobile/config/routes/app_routes.dart';
import 'package:flutter_survey_app_mobile/config/routes/navigator_service.dart';
import 'package:flutter_survey_app_mobile/core/utils/app_border_radius_extensions.dart';
import 'package:flutter_survey_app_mobile/core/utils/app_size_extensions.dart';
import 'package:flutter_survey_app_mobile/feature/create_survey/presentation/mixin/create_questions_view_mixin.dart';
import 'package:flutter_survey_app_mobile/feature/create_survey/presentation/view/survey_shared_success_view.dart';
import 'package:flutter_survey_app_mobile/feature/shared_layers/domain/entity/question_entity.dart';
import 'package:flutter_survey_app_mobile/feature/create_survey/presentation/viewmodel/create_survey_view_model.dart';
import 'package:flutter_survey_app_mobile/product/constants/image_aspect_ratio.dart';
import 'package:flutter_survey_app_mobile/product/decorations/box_decorations/custom_box_decoration.dart';
import 'package:flutter_survey_app_mobile/product/widgets/custom_error_widget.dart';
import 'package:flutter_survey_app_mobile/product/widgets/custom_progress_indicator.dart';
import 'package:flutter_survey_app_mobile/product/widgets/custom_text_widgets.dart';
import 'package:flutter_survey_app_mobile/product/widgets/no_internet_widget.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

part '../sub_view/create_questions_sub_view.dart';

class CreateQuestionsView extends StatefulWidget {
  const CreateQuestionsView({super.key});

  @override
  CreateQuestionsViewState createState() => CreateQuestionsViewState();
}

class CreateQuestionsViewState extends State<CreateQuestionsView>
    with CreateQuestionsViewMixin {
  ValueNotifier<bool> isDialOpen = ValueNotifier(false);

  @override
  Widget build(BuildContext context) {
    return AbsorbPointer(
      absorbing:
          context.watch<CreateSurveyViewModel>().state == ViewState.loading,
      child: Scaffold(
        floatingActionButton: _CustomFloatingActionButton(
          isDialOpen: isDialOpen,
        ),
        appBar: _CustomAppBar(
          shareSurvey: shareSurvey,
        ),
        body: SafeArea(
          child: Padding(
            padding: context.paddingAllLow,
            child: Consumer<CreateSurveyViewModel>(
              builder: (context, viewModel, child) {
                if (viewModel.state == ViewState.error) {
                  return const CustomErrorWidget(
                    title: 'Bir Sorun Oluştu Daha Sonra Tekrar Deneyin..',
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
                  return _ShowAddedQuestions(
                    viewModel: viewModel,
                  );
                } else {
                  return const CustomErrorWidget(
                    title:
                        'Henüz soru oluşturmadınız! Soru eklemek için aşağıdaki butona tıklayın.',
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

class _ShowAddedQuestions extends StatelessWidget {
  final CreateSurveyViewModel viewModel;
  const _ShowAddedQuestions({
    required this.viewModel,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: context.paddingVertBottomXXlarge,
      itemCount: viewModel.questionEntityMap.length,
      itemBuilder: (context, index) {
        final questionEntity =
            viewModel.questionEntityMap.keys.elementAt(index);
        final image = viewModel.questionEntityMap[questionEntity];
        return Padding(
          padding: context.paddingVertAllLow,
          child: Container(
            padding: context.paddingAllMedium,
            decoration: CustomBoxDecoration.customBoxDecoration(context),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _Header(questionEntity: questionEntity),
                SizedBox(height: context.dynamicHeight(0.01)),
                _QuestionImage(image: image),
                SizedBox(height: context.dynamicHeight(0.02)),
                _QuestionTitle(questionEntity: questionEntity),
                SizedBox(height: context.dynamicHeight(0.02)),
                _QuestionOptions(questionEntity: questionEntity),
                SizedBox(height: context.dynamicHeight(0.02)),
                _QuestionRules(questionEntity: questionEntity),
              ],
            ),
          ),
        );
      },
    );
    /*Wrap(
      spacing: context.dynamicWidht(0.02),
      runSpacing: context.dynamicHeight(
          0.01), // Fazla boşlukları azaltmak için runSpacing'i küçült
      children: List.generate(viewModel.questionEntityMap.length, (index) {
        final questionEntity =
            viewModel.questionEntityMap.keys.elementAt(index);
        final image = viewModel.questionEntityMap[questionEntity];

        return SizedBox(
          width: context.dynamicWidht(0.3), // Yatay genişliği düzenlemek için
          child: Padding(
            padding: context.paddingVertAllLow,
            child: Container(
              padding: context.paddingAllMedium,
              decoration: CustomBoxDecoration.customBoxDecoration(context),
              child: IntrinsicHeight(
                // İçeriğin doğal yüksekliğine göre hizalama
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _Header(questionEntity: questionEntity),
                    SizedBox(height: context.dynamicHeight(0.01)),
                    _QuestionImage(image: image),
                    SizedBox(height: context.dynamicHeight(0.02)),
                    _QuestionTitle(questionEntity: questionEntity),
                    SizedBox(height: context.dynamicHeight(0.02)),
                    _QuestionOptions(questionEntity: questionEntity),
                    SizedBox(height: context.dynamicHeight(0.02)),
                    _QuestionRules(questionEntity: questionEntity),
                  ],
                ),
              ),
            ),
          ),
        );
      }),
    );*/
  }
}
