import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_survey_app/core/utils/app_size_extensions.dart';
import 'package:flutter_survey_app/product/decorations/input_decorations/custom_input_decoration.dart';
import 'package:flutter_survey_app/product/widgets/custom_text_widgets.dart';

class CustomInputField extends StatefulWidget {
  const CustomInputField({
    required this.maxLines,
    required this.hintText,
    required this.title,
    required this.controller,
    required this.validator,
    required this.keyboardType,
    super.key,
  });
  final String hintText;
  final int maxLines;
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final String title;
  final TextInputType keyboardType;
  @override
  State<CustomInputField> createState() => _CustomInputFieldState();
}

class _CustomInputFieldState extends State<CustomInputField> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomTextSubTitleWidget(subTitle: widget.title),
        SizedBox(height: context.dynamicHeight(0.01)),
        TextFormField(
          validator: widget.validator,
          controller: widget.controller,
          maxLines: widget.maxLines,
          keyboardType: widget.keyboardType,
          textInputAction: TextInputAction.next,
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: Theme.of(context).colorScheme.onSurface,
                fontWeight: FontWeight.bold,
              ),
          decoration: CustomInputDecoration.inputDecoration(
            context: context,
            hintText: widget.hintText,
          ),
        ),
      ],
    );
  }
}
