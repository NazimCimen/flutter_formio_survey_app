import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_survey_app_mobile/core/base/state.dart';
import 'package:flutter_survey_app_mobile/core/size/app_size/dynamic_size.dart';
import 'package:flutter_survey_app_mobile/core/utils/image_enum.dart';
import 'package:flutter_survey_app_mobile/feature/create_survey/presentation/viewmodel/create_survey_view_model.dart';
import 'package:flutter_survey_app_mobile/product/componets/custom_sheets.dart';
import 'package:flutter_survey_app_mobile/product/constants/image_aspect_ratio.dart';
import 'package:flutter_survey_app_mobile/product/decorations/box_decorations/custom_box_decoration.dart';
import 'package:flutter_survey_app_mobile/product/widgets/custom_progress_indicator.dart';
import 'package:flutter_survey_app_mobile/product/widgets/custom_text_widgets.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:provider/provider.dart';

class ImageInputWidget extends StatelessWidget {
  final String title;
  final CropAspectRatio cropAspectRatio;
  final Uint8List? selectedFileBytes;
  const ImageInputWidget({
    required this.title,
    required this.cropAspectRatio,
    this.selectedFileBytes,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final viewModel = context.read<CreateSurveyViewModel>();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CustomTextSubTitleWidget(subTitle: title),
            GestureDetector(
              onTap: () {
                if (cropAspectRatio ==
                    ImageAspectRatioEnum.questionImage.ratioCrop) {
                  context.read<CreateSurveyViewModel>().resetQuestionImage();
                } else {
                  context.read<CreateSurveyViewModel>().resetSurveyImage();
                }
              },
              child: const Icon(Icons.remove_circle_outline),
            )
          ],
        ),
        SizedBox(height: context.dynamicHeight(0.01)),
        AspectRatio(
          aspectRatio: cropAspectRatio.ratioX / cropAspectRatio.ratioY,
          child: Container(
            decoration: CustomBoxDecoration.customBoxDecorationForImage(
              context,
            ),
            child: GestureDetector(
              onTap: () async {
                viewModel.setState(ViewState.loading);
                final selectedSource = await CustomSheets.showMenuForImage(
                  context: context,
                );
                if (selectedSource != null) {
                  await viewModel.getImage(
                    selectedSource: selectedSource,
                    cropRatio: cropAspectRatio,
                  );
                }
                viewModel.setState(ViewState.inActive);
              },
              child: Center(
                child: Consumer<CreateSurveyViewModel>(
                  builder: (context, viewModel, child) {
                    if (viewModel.state == ViewState.loading) {
                      return const CustomProgressIndicator();
                    } else if (selectedFileBytes != null) {
                      return Image.memory(
                        selectedFileBytes!,
                        fit: BoxFit.cover,
                      );
                    } else {
                      return Image.asset(
                        ImageEnums.addImage.toPathPng,
                        width: context.dynamicWidht(0.2),
                        color: Theme.of(context).colorScheme.onTertiary,
                      );
                    }
                  },
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
