import 'package:flutter/material.dart';
import 'package:flutter_survey_app_mobile/core/base/base_stateless.dart';
import 'package:flutter_survey_app_mobile/core/size/app_size/dynamic_size.dart';
import 'package:flutter_survey_app_mobile/core/size/padding/dynamic_padding.dart';
import 'package:flutter_survey_app_mobile/product/decorations/input_decorations/custom_input_decoration.dart';
import 'package:flutter_survey_app_mobile/product/widgets/custom_text_widgets.dart';

class AddOption extends BaseStateless<void> {
  const AddOption({
    required this.inputOptions,
    required this.addNewOption,
    required this.deleteOption,
    super.key,
  });
  final List<TextEditingController> inputOptions;
  final VoidCallback addNewOption;
  final void Function(int index) deleteOption;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const CustomTextSubTitleWidget(subTitle: 'Seçenekler'),
        SizedBox(height: context.dynamicHeight(0.01)),
        Column(
          children: inputOptions
              .map(
                (controller) => Padding(
                  padding: context.paddingVertAllLow,
                  child: Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: controller,
                          onTap: addNewOption,
                          textInputAction: TextInputAction.next,
                          style: textTheme(context).bodyLarge?.copyWith(
                                color: colorScheme(context).onSurface,
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
                        onTap: () =>
                            deleteOption(inputOptions.indexOf(controller)),
                        child: const Icon(Icons.remove_circle_outline),
                      ),
                    ],
                  ),
                ),
              )
              .toList(),
        ),
      ],
    );
  }
}
