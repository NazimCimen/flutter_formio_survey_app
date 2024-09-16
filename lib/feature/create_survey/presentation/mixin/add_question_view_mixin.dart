import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_survey_app/config/routes/navigator_service.dart';
import 'package:flutter_survey_app/feature/shared_layers/domain/entity/question_entity.dart';
import 'package:flutter_survey_app/feature/create_survey/presentation/view/add_question_view.dart';
import 'package:flutter_survey_app/feature/create_survey/presentation/viewmodel/create_survey_view_model.dart';
import 'package:provider/provider.dart';

mixin AddQuestionViewMixin on State<AddQuestionView> {
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
    selectedImageBytes =
        context.watch<CreateSurveyViewModel>().selectedQuestionFileBytes;
    super.didChangeDependencies();
  }

  /// this method overrided in view
  void showSnackBar({required String errorMsg});

  void deleteImage() {
    context.read<CreateSurveyViewModel>().resetQuestionImage();
  }

  void saveQuestion() {
    final options = <String>[];
    for (final option in inputOptions) {
      if (option.text.isNotEmpty) {
        options.add(option.text.trim());
      }
    }
    if (titleController.text.trim().isEmpty) {
      showSnackBar(errorMsg: 'Soru Metnini girmeden ilerleyemezsiniz');
    } else if (widget.entity.type != QuestionType.openEnded &&
        options.isEmpty) {
      showSnackBar(errorMsg: 'Please fill in the option fields.');
    } else {
      final entity = widget.entity.copyWith(
        title: titleController.text.trim(),
        addOptionOther: isOtherCheckBoxValue,
        isRequired: isRequiredCheckBoxValue,
        multipleChoices: isMultipleChoiceCheckBoxValue,
        options: options,
      );
      context.read<CreateSurveyViewModel>().addNewQuestion(
            entity: entity,
            selectedQuestionFileBytes:
                context.read<CreateSurveyViewModel>().selectedQuestionFileBytes,
          );
      context.read<CreateSurveyViewModel>().resetQuestionImage();
      NavigatorService.goBack();
    }
  }

  void getDefaultValues() {
    selectedImageBytes =
        context.read<CreateSurveyViewModel>().selectedQuestionFileBytes;
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

  void addNewOption() {
    final isValidate = validateOptionFields();
    if (isValidate) {
      inputOptions.add(TextEditingController());
    }
  }

  void deleteOption(int index) {
    if (inputOptions.length != 1) {
      setState(() {
        inputOptions.removeAt(index);
      });
    }
  }

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
    if (isEmpty) {
      return false;
    } else {
      return true;
    }
  }

  void isRequiredCheckBoxPressed({bool? value}) {
    if (value != null) {
      setState(() {
        isRequiredCheckBoxValue = value;
      });
    }
  }

  void isMultipleChoiceCheckBoxPressed({bool? value}) {
    if (value != null) {
      setState(() {
        isMultipleChoiceCheckBoxValue = value;
      });
    }
  }

  void isOtherCheckBoxPressed({bool? value}) {
    if (value != null) {
      setState(() {
        isOtherCheckBoxValue = value;
      });
    }
  }
}
