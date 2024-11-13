import 'package:flutter/material.dart';
import 'package:flutter_survey_app_mobile/config/routes/app_routes.dart';
import 'package:flutter_survey_app_mobile/config/routes/navigator_service.dart';
import 'package:flutter_survey_app_mobile/core/base/base_stateful.dart';
import 'package:flutter_survey_app_mobile/core/utils/type_parser.dart';
import 'package:flutter_survey_app_mobile/feature/create_survey/presentation/view/create_survey_info_view.dart';
import 'package:flutter_survey_app_mobile/feature/create_survey/presentation/viewmodel/create_survey_view_model.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

mixin CreateSurveyInfoViewMixin
    on BaseStateful<CreateSurveyInfoView, CreateSurveyViewModel> {
  late TextEditingController surveyTitleController;
  late TextEditingController surveyDescriptionController;
  late TextEditingController startDateController;
  late TextEditingController endDateController;
  late TextEditingController surveyTimeInMinute;
  late GlobalKey<FormState> formKey;
  late AutovalidateMode validateMode;

  @override
  void initState() {
    formKey = GlobalKey<FormState>();
    validateMode = AutovalidateMode.disabled;
    getSurveyInfoDefaultValues(); // Initializes default values for survey fields
    super.initState();
  }

  @override
  void dispose() {
    surveyTitleController.dispose();
    surveyDescriptionController.dispose();
    startDateController.dispose();
    endDateController.dispose();
    surveyTimeInMinute.dispose();
    super.dispose();
  }

  /// Sets validation mode for the form fields
  void setValidateMode(AutovalidateMode mode) {
    setState(() {
      validateMode = mode;
    });
  }

  /// Validates form fields and adjusts validation mode accordingly
  bool validateFields() {
    if (formKey.currentState!.validate()) {
      setValidateMode(AutovalidateMode.always);
      return true;
    } else {
      setValidateMode(AutovalidateMode.disabled);
      return false;
    }
  }

  /// Validates and sets survey info values, then navigates to the question creation view
  void navigateAndSetSurveyInfoValues() {
    final isValidate = validateFields();
    if (isValidate) {
      readViewModel.setSurveyInfos(
        surveyTitle: surveyTitleController.text.trim(),
        surveyDescription: surveyDescriptionController.text.trim(),
        startDate: TypeParser.parseDateTime(startDateController.text.trim()),
        endDate: TypeParser.parseDateTime(
          endDateController.text.trim(),
        ),
        surveyTimeInMinute: TypeParser.parseInt(surveyTimeInMinute.text.trim()),
      );
      NavigatorService.pushNamed(
        AppRoutes.createQuestionsView,
        withAnimation: true,
      );
    }
  }

  /// Fetches and sets default values for the survey info fields
  void getSurveyInfoDefaultValues() {
    final survey = context.read<CreateSurveyViewModel>().surveyEntity;
    surveyTitleController = TextEditingController(text: survey.surveyTitle);
    surveyDescriptionController =
        TextEditingController(text: survey.surveyDescription);
    startDateController = TextEditingController(
      text: survey.startDate != null ? survey.startDate.toString() : '',
    );
    endDateController = TextEditingController(
      text: survey.endDate != null ? survey.endDate.toString() : '',
    );
    surveyTimeInMinute = TextEditingController(
      text: survey.surveyTimeInMinute != null
          ? survey.surveyTimeInMinute.toString()
          : '',
    );
  }

  /// Resets the ViewModel state when navigating back
  void onPopInvoked() {
    readViewModel.resetViewModel();
  }

  /// Closes the page and resets ViewModel state
  void closePage() {
    readViewModel.resetViewModel();
    NavigatorService.goBack();
  }

  /// Opens date picker for selecting start date and updates controller with selected date
  Future<void> selectStartDate(BuildContext context) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: endDateController.text.isNotEmpty
          ? DateFormat('yyyy-MM-dd').parse(endDateController.text)
          : DateTime(2101),
    );
    if (picked != null) {
      setState(() {
        startDateController.text = DateFormat('yyyy-MM-dd').format(picked);
      });
    }
  }

  /// Opens date picker for selecting end date and updates controller with selected date
  Future<void> selectEndDate(BuildContext context) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: startDateController.text.isNotEmpty
          ? DateFormat('yyyy-MM-dd').parse(startDateController.text)
          : DateTime.now(),
      firstDate: startDateController.text.isNotEmpty
          ? DateFormat('yyyy-MM-dd').parse(startDateController.text)
          : DateTime.now(),
      lastDate: DateTime(2101),
    );
    if (picked != null) {
      setState(() {
        endDateController.text = DateFormat('yyyy-MM-dd').format(picked);
      });
    }
  }
}
