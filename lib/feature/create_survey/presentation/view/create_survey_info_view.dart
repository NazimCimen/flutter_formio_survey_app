import 'package:flutter/material.dart';
import 'package:flutter_survey_app_mobile/config/localization/string_constants.dart';
import 'package:flutter_survey_app_mobile/core/base/base_stateful.dart';
import 'package:flutter_survey_app_mobile/core/base/base_stateless.dart';
import 'package:flutter_survey_app_mobile/core/base/state.dart';
import 'package:flutter_survey_app_mobile/core/utils/size/app_size/dynamic_size.dart';
import 'package:flutter_survey_app_mobile/core/utils/size/padding/dynamic_padding.dart';
import 'package:flutter_survey_app_mobile/core/utils/app_validators.dart';
import 'package:flutter_survey_app_mobile/feature/create_survey/presentation/mixin/create_survey_info_view_mixin.dart';
import 'package:flutter_survey_app_mobile/feature/create_survey/presentation/viewmodel/create_survey_view_model.dart';
import 'package:flutter_survey_app_mobile/feature/create_survey/presentation/widgets/custom_input_text_field.dart';
import 'package:flutter_survey_app_mobile/feature/create_survey/presentation/widgets/image_input_widgets.dart';
import 'package:flutter_survey_app_mobile/product/constants/image_aspect_ratio.dart';
import 'package:provider/provider.dart';
part '../sub_view/create_survey_info_sub_view.dart';

class CreateSurveyInfoView extends StatefulWidget {
  const CreateSurveyInfoView({super.key});

  @override
  CreateSurveyInfoViewState createState() => CreateSurveyInfoViewState();
}

class CreateSurveyInfoViewState
    extends BaseStateful<CreateSurveyInfoView, CreateSurveyViewModel>
    with CreateSurveyInfoViewMixin {
  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvoked: (didPop) {
        if (didPop) {
          onPopInvoked();
        }
      },
      child: AbsorbPointer(
        absorbing:
            context.watch<CreateSurveyViewModel>().state == ViewState.loading,
        child: Scaffold(
          appBar: _AppBar(
            closePage: closePage,
            navigateAndSetSurveyInfoValues: navigateAndSetSurveyInfoValues,
          ),
          body: SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: context.paddingAllMedium,
                child: Form(
                  autovalidateMode: validateMode,
                  key: formKey,
                  child: Column(
                    children: [
                      ImageInputWidget(
                        title: StringConstants.survey_image,
                        cropAspectRatio:
                            ImageAspectRatioEnum.surveyImage.ratioCrop,
                        selectedFileBytes: context
                            .watch<CreateSurveyViewModel>()
                            .selectedSurveyImageBytes,
                      ),
                      SizedBox(height: context.dynamicHeight(0.035)),
                      CustomInputField(
                        title: StringConstants.survey_title,
                        hintText: StringConstants.survey_title,
                        maxLines: 1,
                        controller: surveyTitleController,
                        validator: (value) =>
                            AppValidators.surveyTitleValidator(value),
                        keyboardType: TextInputType.text,
                      ),
                      SizedBox(height: context.dynamicHeight(0.035)),
                      CustomInputField(
                        title: StringConstants.survey_desc,
                        hintText: StringConstants.survey_desc,
                        maxLines: 4,
                        controller: surveyDescriptionController,
                        validator: (value) =>
                            AppValidators.surveyDescriptionValidator(value),
                        keyboardType: TextInputType.multiline,
                        textInputAction: TextInputAction.none,
                      ),
                      SizedBox(height: context.dynamicHeight(0.035)),
                      GestureDetector(
                        onTap: () => selectStartDate(context),
                        child: AbsorbPointer(
                          child: CustomInputField(
                            title: StringConstants.survey_start_date,
                            hintText: StringConstants.survey_start_date,
                            controller: startDateController,
                            validator: (value) =>
                                AppValidators.startDateValidator(value),
                            keyboardType: TextInputType.none,
                            maxLines: 1,
                          ),
                        ),
                      ),
                      SizedBox(height: context.dynamicHeight(0.035)),
                      GestureDetector(
                        onTap: () => selectEndDate(context),
                        child: AbsorbPointer(
                          child: CustomInputField(
                            title: StringConstants.survey_end_date,
                            hintText: StringConstants.survey_end_date,
                            controller: endDateController,
                            validator: (value) =>
                                AppValidators.endDateValidator(value),
                            maxLines: 1,
                            keyboardType: TextInputType.none,
                          ),
                        ),
                      ),
                      SizedBox(height: context.dynamicHeight(0.035)),
                      CustomInputField(
                        title: StringConstants.survey_minute,
                        hintText: StringConstants.survey_minute,
                        maxLines: 1,
                        controller: surveyTimeInMinute,
                        validator: (value) =>
                            AppValidators.durationInMinuteValidator(value),
                        keyboardType: TextInputType.number,
                      ),
                      SizedBox(height: context.dynamicHeight(0.035)),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
