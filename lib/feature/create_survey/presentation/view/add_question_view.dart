import 'package:flutter/material.dart';
import 'package:flutter_survey_app/config/routes/navigator_service.dart';
import 'package:flutter_survey_app/core/utils/app_size_extensions.dart';
import 'package:flutter_survey_app/feature/shared_layers/domain/entity/question_entity.dart';
import 'package:flutter_survey_app/feature/create_survey/presentation/mixin/add_question_view_mixin.dart';
import 'package:flutter_survey_app/feature/create_survey/presentation/viewmodel/create_survey_view_model.dart';
import 'package:flutter_survey_app/feature/create_survey/presentation/widgets/custom_input_text_field.dart';
import 'package:flutter_survey_app/feature/create_survey/presentation/widgets/image_input_widgets.dart';
import 'package:flutter_survey_app/product/componets/custom_snack_bars.dart';
import 'package:flutter_survey_app/product/constants/image_aspect_ratio.dart';
import 'package:flutter_survey_app/product/decorations/input_decorations/custom_input_decoration.dart';
import 'package:flutter_survey_app/product/widgets/custom_text_widgets.dart';
import 'package:provider/provider.dart';
part '../sub_view/add_question_sub_view.dart';

class AddQuestionView extends StatefulWidget {
  final QuestionEntity entity;
  const AddQuestionView({required this.entity, super.key});

  @override
  State<AddQuestionView> createState() => _AddQuestionViewState();
}

class _AddQuestionViewState extends State<AddQuestionView>
    with AddQuestionViewMixin {
  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<CreateSurveyViewModel>();

    return AbsorbPointer(
      absorbing: viewModel.state == ViewState.loading,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: _buildAppBar(context),
        body: SafeArea(
          child: Padding(
            padding: context.paddingAllMedium,
            child: SingleChildScrollView(
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom),
              reverse: true,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ImageInputWidget(
                    title: 'Question Image',
                    cropAspectRatio:
                        ImageAspectRatioEnum.questionImage.ratioCrop,
                    selectedFileBytes: selectedImageBytes,
                  ),
                  SizedBox(height: context.dynamicHeight(0.02)),
                  CustomInputField(
                    maxLines: 2,
                    hintText: 'Metninizi girin',
                    title: 'Soru Metni',
                    controller: titleController,
                    validator: null,
                    keyboardType: TextInputType.text,
                  ),
                  if (widget.entity.type != QuestionType.openEnded)
                    _buildOptionsSection(context),
                  SizedBox(height: context.dynamicHeight(0.02)),
                  _buildCheckBoxSection(),
                  SizedBox(height: context.dynamicHeight(0.02)),
                  _BottomActionButtons(
                    onPressedCancel: NavigatorService.goBack,
                    onPressedSave: saveQuestion,
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      automaticallyImplyLeading: false,
      title: Text(
        'Çoktan Seçmeli',
        style: Theme.of(context).textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.primary,
            ),
      ),
    );
  }

  Widget _buildOptionsSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const CustomTextSubTitleWidget(subTitle: 'Seçenekler'),
        SizedBox(height: context.dynamicHeight(0.01)),
        Column(
          children: inputOptions
              .map((controller) => _buildOptionField(context, controller))
              .toList(),
        ),
      ],
    );
  }

  Widget _buildOptionField(
      BuildContext context, TextEditingController controller) {
    return Padding(
      padding: context.paddingVertAllLow,
      child: Row(
        children: [
          Expanded(
            child: TextFormField(
              controller: controller,
              onTap: addNewOption,
              textInputAction: TextInputAction.next,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: Theme.of(context).colorScheme.onSurface,
                    fontWeight: FontWeight.bold,
                  ),
              decoration: CustomInputDecoration.inputDecoration(
                context: context,
                hintText: 'Seçenek girin',
              ),
            ),
          ),
          SizedBox(width: context.dynamicWidht(0.07)),
          GestureDetector(
            onTap: () => deleteOption(inputOptions.indexOf(controller)),
            child: const Icon(Icons.remove_circle_outline),
          ),
        ],
      ),
    );
  }

  Widget _buildCheckBoxSection() {
    return Column(
      children: [
        _buildCheckBoxRow(
          title: 'Cevaplaması zorunlu soru',
          value: isRequiredCheckBoxValue,
          onChanged: (value) => isRequiredCheckBoxPressed(value: value),
        ),
        if (widget.entity.type == QuestionType.multipleChoice)
          _buildCheckBoxRow(
            title: 'Çoklu seçim özelliği',
            value: isMultipleChoiceCheckBoxValue,
            onChanged: (value) => isMultipleChoiceCheckBoxPressed(value: value),
          ),
        if (widget.entity.type != QuestionType.openEnded)
          _buildCheckBoxRow(
            title: 'Seçeneklere diğer ekle',
            value: isOtherCheckBoxValue,
            onChanged: (value) => isOtherCheckBoxPressed(value: value),
          ),
      ],
    );
  }

  Widget _buildCheckBoxRow({
    required String title,
    required bool value,
    required void Function(bool?)? onChanged,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, style: Theme.of(context).textTheme.bodyLarge),
        Checkbox(value: value, onChanged: onChanged),
      ],
    );
  }

  @override
  void showSnackBar({required String errorMsg}) {
    FocusScope.of(context).unfocus();
    CustomSnackBars.showRecipeScaffoldSnackBar(
      context: context,
      text: errorMsg,
    );
  }
}
