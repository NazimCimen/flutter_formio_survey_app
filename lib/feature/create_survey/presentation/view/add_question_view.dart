import 'package:flutter/material.dart';
import 'package:flutter_survey_app_mobile/config/localization/string_constants.dart';
import 'package:flutter_survey_app_mobile/config/routes/navigator_service.dart';
import 'package:flutter_survey_app_mobile/core/base/base_stateful.dart';
import 'package:flutter_survey_app_mobile/core/base/base_stateless.dart';
import 'package:flutter_survey_app_mobile/core/base/state.dart';
import 'package:flutter_survey_app_mobile/core/utils/size/app_size/dynamic_size.dart';
import 'package:flutter_survey_app_mobile/core/utils/size/padding/dynamic_padding.dart';
import 'package:flutter_survey_app_mobile/feature/create_survey/presentation/widgets/add_option.dart';
import 'package:flutter_survey_app_mobile/feature/shared_layers/domain/entity/question_entity.dart';
import 'package:flutter_survey_app_mobile/feature/create_survey/presentation/mixin/add_question_view_mixin.dart';
import 'package:flutter_survey_app_mobile/feature/create_survey/presentation/viewmodel/create_survey_view_model.dart';
import 'package:flutter_survey_app_mobile/feature/create_survey/presentation/widgets/custom_input_text_field.dart';
import 'package:flutter_survey_app_mobile/feature/create_survey/presentation/widgets/image_input_widgets.dart';
import 'package:flutter_survey_app_mobile/product/componets/custom_snack_bars.dart';
import 'package:flutter_survey_app_mobile/product/constants/image_aspect_ratio.dart';

part '../sub_view/add_question_sub_view.dart';

class AddQuestionView extends StatefulWidget {
  final QuestionEntity entity;
  const AddQuestionView({required this.entity, super.key});

  @override
  State<AddQuestionView> createState() => _AddQuestionViewState();
}

class _AddQuestionViewState
    extends BaseStateful<AddQuestionView, CreateSurveyViewModel>
    with AddQuestionViewMixin {
  @override
  Widget build(BuildContext context) {
    return AbsorbPointer(
      absorbing: watchViewModel.state == ViewState.loading,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: _AppBar(
          questionTypeTitle:
              widget.entity.type != null ? widget.entity.type!.qType : '',
        ),
        body: SafeArea(
          child: Padding(
            padding: context.paddingAllMedium,
            child: SingleChildScrollView(
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom,
              ),
              reverse: true,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ImageInputWidget(
                    title: StringConstants.question_image,
                    cropAspectRatio:
                        ImageAspectRatioEnum.questionImage.ratioCrop,
                    selectedFileBytes: selectedImageBytes,
                  ),
                  SizedBox(height: context.dynamicHeight(0.02)),
                  CustomInputField(
                    maxLines: 2,
                    hintText: StringConstants.question_input_hint,
                    title: StringConstants.question_input_title,
                    controller: titleController,
                    validator: null,
                    keyboardType: TextInputType.text,
                  ),
                  if (widget.entity.type != QuestionType.openEnded)
                    AddOption(
                      inputOptions: inputOptions,
                      addNewOption: addNewOption,
                      deleteOption: deleteOption,
                    ),
                  SizedBox(height: context.dynamicHeight(0.02)),
                  _buildCheckBoxSection(),
                  SizedBox(height: context.dynamicHeight(0.02)),
                  _BottomActionButtons(
                    onPressedCancel: NavigatorService.goBack,
                    onPressedSave: saveQuestion,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCheckBoxSection() {
    return Column(
      children: [
        _buildCheckBoxRow(
          title: StringConstants.question_required_answer,
          value: isRequiredCheckBoxValue,
          onChanged: (value) => isRequiredCheckBoxPressed(value: value),
        ),
        if (widget.entity.type == QuestionType.multipleChoice)
          _buildCheckBoxRow(
            title: StringConstants.question_multiple_choice,
            value: isMultipleChoiceCheckBoxValue,
            onChanged: (value) => isMultipleChoiceCheckBoxPressed(value: value),
          ),
        if (widget.entity.type != QuestionType.openEnded)
          _buildCheckBoxRow(
            title: StringConstants.question_add_other,
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
        Text(title, style: textTheme.bodyLarge),
        Checkbox(value: value, onChanged: onChanged),
      ],
    );
  }

  @override
  void showSnackBar({required String errorMsg}) {
    FocusScope.of(context).unfocus();
    CustomSnackBars.showCustomScaffoldSnackBar(
      context: context,
      text: errorMsg,
    );
  }
}
