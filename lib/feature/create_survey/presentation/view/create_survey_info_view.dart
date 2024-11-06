import 'package:flutter/material.dart';
import 'package:flutter_survey_app_mobile/core/base/state.dart';
import 'package:flutter_survey_app_mobile/core/size/app_size/dynamic_size.dart';
import 'package:flutter_survey_app_mobile/core/size/padding/dynamic_padding.dart';
import 'package:flutter_survey_app_mobile/core/utils/app_validators.dart';
import 'package:flutter_survey_app_mobile/feature/create_survey/presentation/mixin/create_survey_info_view_mixin.dart';
import 'package:flutter_survey_app_mobile/feature/create_survey/presentation/viewmodel/create_survey_view_model.dart';
import 'package:flutter_survey_app_mobile/feature/create_survey/presentation/widgets/custom_input_text_field.dart';
import 'package:flutter_survey_app_mobile/feature/create_survey/presentation/widgets/image_input_widgets.dart';
import 'package:flutter_survey_app_mobile/product/constants/image_aspect_ratio.dart';
import 'package:provider/provider.dart';

class CreateSurveyInfoView extends StatefulWidget {
  const CreateSurveyInfoView({super.key});

  @override
  CreateSurveyInfoViewState createState() => CreateSurveyInfoViewState();
}

class CreateSurveyInfoViewState extends State<CreateSurveyInfoView>
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
          appBar: _buildAppBar(context),
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
                        title: 'Survey Image',
                        cropAspectRatio:
                            ImageAspectRatioEnum.surveyImage.ratioCrop,
                        selectedFileBytes: context
                            .watch<CreateSurveyViewModel>()
                            .selectedSurveyImageBytes,
                      ),
                      SizedBox(height: context.dynamicHeight(0.035)),
                      CustomInputField(
                        title: 'Survey Title',
                        hintText: 'Survey Title',
                        maxLines: 1,
                        controller: surveyTitleController,
                        validator: (value) =>
                            AppValidators().surveyTitleValidator(value),
                        keyboardType: TextInputType.text,
                      ),
                      SizedBox(height: context.dynamicHeight(0.035)),
                      CustomInputField(
                        title: 'Survey Description',
                        hintText: 'Survey Description',
                        maxLines: 4,
                        controller: surveyDescriptionController,
                        validator: (value) =>
                            AppValidators().surveyDescriptionValidator(value),
                        keyboardType: TextInputType.text,
                      ),
                      SizedBox(height: context.dynamicHeight(0.035)),
                      GestureDetector(
                        onTap: () => selectStartDate(context),
                        child: AbsorbPointer(
                          child: CustomInputField(
                            title: 'Start Date',
                            hintText: 'Select Start Date',
                            controller: startDateController,
                            validator: (value) =>
                                AppValidators().startDateValidator(value),
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
                            title: 'End Date',
                            hintText: 'Select End Date',
                            controller: endDateController,
                            validator: (value) =>
                                AppValidators().endDateValidator(value),
                            maxLines: 1,
                            keyboardType: TextInputType.none,
                          ),
                        ),
                      ),
                      SizedBox(height: context.dynamicHeight(0.035)),
                      CustomInputField(
                        title: 'Duration (in minutes)',
                        hintText: 'Duration (in minutes)',
                        maxLines: 1,
                        controller: surveyTimeInMinute,
                        validator: (value) =>
                            AppValidators().durationInMinuteValidator(value),
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

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      forceMaterialTransparency: true,
      leading: GestureDetector(
        onTap: closePage,
        child: const Icon(Icons.close_outlined),
      ),
      backgroundColor: Colors.transparent,
      elevation: 0,
      title: Text(
        'Create Your Survey',
        style: Theme.of(context).textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.primary,
            ),
      ),
      actions: [
        Padding(
          padding: context.paddingHorizRightLow,
          child: InkWell(
            onTap: () {
              navigateAndSetSurveyInfoValues();
            },
            child: Text(
              'NEXT',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: Theme.of(context).colorScheme.onSecondary,
                  ),
            ),
          ),
        ),
      ],
    );
  }
}
