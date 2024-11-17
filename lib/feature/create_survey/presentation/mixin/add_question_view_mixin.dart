import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_survey_app_mobile/config/localization/string_constants.dart';
import 'package:flutter_survey_app_mobile/config/routes/navigator_service.dart';
import 'package:flutter_survey_app_mobile/core/base/base_stateful.dart';
import 'package:flutter_survey_app_mobile/feature/create_survey/presentation/view/add_question_view.dart';
import 'package:flutter_survey_app_mobile/feature/create_survey/presentation/viewmodel/create_survey_view_model.dart';
import 'package:flutter_survey_app_mobile/product/constants/question_type_enum.dart';

mixin AddQuestionViewMixin
    on BaseStateful<AddQuestionView, CreateSurveyViewModel> {
  late TextEditingController titleController;
  late List<TextEditingController> inputOptions;
  bool isRequiredCheckBoxValue = false;
  bool isMultipleChoiceCheckBoxValue = false;
  bool isOtherCheckBoxValue = false;
  Uint8List? selectedImageBytes;

  @override
  void initState() {
    getDefaultValues();
    super.initState();
  }

  @override
  void dispose() {
    titleController.dispose();
    for (final option in inputOptions) {
      option.dispose();
    }
    inputOptions.clear();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    selectedImageBytes = watchViewModel.selectedQuestionFileBytes;
    super.didChangeDependencies();
  }

  /// Displays a snackbar with an error message /// This method is overridden in AddQuestionView.dart
  void showSnackBar({required String errorMsg});

  /// Deletes the currently selected image by resetting the question image in the ViewModel.
  void deleteImage() {
    readViewModel.resetQuestionImage();
  }

  /// Saves the question by validating inputs and adding the question entity to the ViewModel.
  void saveQuestion() {
    final options = validateQuestion();
    if (options != null) {
      final entity = widget.entity.copyWith(
        title: titleController.text.trim(),
        addOptionOther: isOtherCheckBoxValue,
        isRequired: isRequiredCheckBoxValue,
        multipleChoices: isMultipleChoiceCheckBoxValue,
        options: options,
      );
      readViewModel
        ..addNewQuestion(
          entity: entity,
          selectedQuestionFileBytes: readViewModel.selectedQuestionFileBytes,
        )
        ..resetQuestionImage();
      NavigatorService.goBack();
    }
  }

  /// Validates the question title and options fields, returning options if valid.
  List<String>? validateQuestion() {
    final trimmedTitle = titleController.text.trim();
    if (trimmedTitle.isEmpty) {
      showSnackBar(errorMsg: StringConstants.valid_question_text);
      return null;
    }
    final options = inputOptions
        .where((option) => option.text.isNotEmpty)
        .map((option) => option.text.trim())
        .toList();
    if (widget.entity.type != QuestionType.openEnded && options.isEmpty) {
      showSnackBar(errorMsg: StringConstants.valid_question_option);
      return null;
    }
    return options;
  }

  /// Initializes default values for question title, options, and selected image.
  void getDefaultValues() {
    selectedImageBytes = readViewModel.selectedQuestionFileBytes;
    titleController = TextEditingController(text: widget.entity.title ?? '');
    inputOptions = [];
    if (widget.entity.options != null) {
      inputOptions = List.generate(
        widget.entity.options!.length,
        (index) => TextEditingController(text: widget.entity.options![index]),
      );
    }
    if (inputOptions.isEmpty) {
      inputOptions.add(TextEditingController());
    }
  }

  /// Adds a new option if the existing fields are validated.
  void addNewOption() {
    final isValidate = validateOptionFields();
    if (isValidate) {
      inputOptions.add(TextEditingController());
    }
  }

  /// Deletes an option at a specific index, if there is more than one option.
  void deleteOption(int index) {
    if (inputOptions.length != 1) {
      setState(() {
        inputOptions.removeAt(index);
      });
    }
  }

  /// Validates that all option fields except the last one are non-empty.
  bool validateOptionFields() {
    var isEmpty = false;
    setState(() {});
    for (var i = 0; i < inputOptions.length; i++) {
      if (i != (inputOptions.length - 1)) {
        if (inputOptions[i].text.isEmpty) {
          isEmpty = true;
        }
      }
    }
    return !isEmpty;
  }

  /// Toggles the "is required" checkbox and updates its state.
  void isRequiredCheckBoxPressed({bool? value}) {
    if (value != null) {
      setState(() {
        isRequiredCheckBoxValue = value;
      });
    }
  }

  /// Toggles the "is multiple choice" checkbox and updates its state.
  void isMultipleChoiceCheckBoxPressed({bool? value}) {
    if (value != null) {
      setState(() {
        isMultipleChoiceCheckBoxValue = value;
      });
    }
  }

  /// Toggles the "add other option" checkbox and updates its state.
  void isOtherCheckBoxPressed({bool? value}) {
    if (value != null) {
      setState(() {
        isOtherCheckBoxValue = value;
      });
    }
  }
}
