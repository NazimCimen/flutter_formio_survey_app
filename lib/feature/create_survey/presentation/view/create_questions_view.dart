import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:flutter_survey_app/config/routes/app_routes.dart';
import 'package:flutter_survey_app/config/routes/navigator_service.dart';
import 'package:flutter_survey_app/core/utils/app_border_radius_extensions.dart';
import 'package:flutter_survey_app/core/utils/app_size_extensions.dart';
import 'package:flutter_survey_app/feature/shared_layers/domain/entity/question_entity.dart';
import 'package:flutter_survey_app/feature/create_survey/presentation/viewmodel/create_survey_view_model.dart';
import 'package:flutter_survey_app/product/constants/image_aspect_ratio.dart';
import 'package:flutter_survey_app/product/decorations/box_decorations/custom_box_decoration.dart';
import 'package:flutter_survey_app/product/widgets/custom_error_widget.dart';
import 'package:flutter_survey_app/product/widgets/custom_progress_indicator.dart';
import 'package:flutter_survey_app/product/widgets/custom_text_widgets.dart';
import 'package:flutter_survey_app/product/widgets/emphty_list_widget.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

part '../sub_view/create_questions_sub_view.dart';

class CreateQuestionsView extends StatefulWidget {
  const CreateQuestionsView({super.key});

  @override
  CreateQuestionsViewState createState() => CreateQuestionsViewState();
}

class CreateQuestionsViewState extends State<CreateQuestionsView> {
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
        appBar: const _CustomAppBar(),
        body: SafeArea(
          child: Padding(
            padding: context.paddingAllLow,
            child: Consumer<CreateSurveyViewModel>(
              builder: (context, viewModel, child) {
                if (viewModel.state == ViewState.error) {
                  return const CustomErrorWidget(
                    title: 'Bir Sorun Oluştu Daha Sonra Tekrar Deneyin..',
                  );
                } else if (viewModel.state == ViewState.loading) {
                  return const CustomProgressIndicator();
                } else if (viewModel.state == ViewState.noInternet) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const CustomErrorWidget(
                        title:
                            'İnternet Bağlantısı Yok.Bağlantından emin olduktan sonra yeniden anketini yayınlayabilirsin',
                      ),
                      TextButton(
                          onPressed: () async {
                            await viewModel.checkConnectivity();
                          },
                          child: Text('Yeniden Dene'))
                    ],
                  );
                } else if (viewModel.questionEntityMap.isNotEmpty) {
                  return _ShowAddedQuestions(
                    viewModel: viewModel,
                  );
                } else {
                  return const EmphtyList(
                    title:
                        'Henüz soru oluşturmadınız! Soru eklemek için aşağıdaki butona tıklayın.',
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
  }
}
