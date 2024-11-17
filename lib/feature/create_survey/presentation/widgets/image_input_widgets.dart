import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_survey_app_mobile/core/base/state.dart';
import 'package:flutter_survey_app_mobile/core/utils/enum/image_enum.dart';
import 'package:flutter_survey_app_mobile/core/utils/size/app_size/constant_size.dart';
import 'package:flutter_survey_app_mobile/core/utils/size/app_size/dynamic_size.dart';
import 'package:flutter_survey_app_mobile/feature/create_survey/presentation/viewmodel/create_survey_view_model.dart';
import 'package:flutter_survey_app_mobile/product/constants/image_aspect_ratio.dart';
import 'package:flutter_survey_app_mobile/product/decorations/box_decorations/custom_box_decoration.dart';
import 'package:flutter_survey_app_mobile/product/widgets/custom_progress_indicator.dart';
import 'package:flutter_survey_app_mobile/product/widgets/custom_text_widgets.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
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
            Visibility(
              visible: viewModel.selectedQuestionFileBytes != null,
              child: GestureDetector(
                onTap: () {
                  if (cropAspectRatio ==
                      ImageAspectRatioEnum.questionImage.ratioCrop) {
                    context.read<CreateSurveyViewModel>().resetQuestionImage();
                  } else {
                    context.read<CreateSurveyViewModel>().resetSurveyImage();
                  }
                },
                child: const Icon(Icons.remove_circle_outline),
              ),
            ),
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
                await viewModel.getImage(
                  context: context,
                  selectedSource: ImageSource.gallery,
                  cropRatio: cropAspectRatio,
                );
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
                        width: double.maxFinite,
                      );
                    } else {
                      return Image.asset(
                        ImageEnums.add_image.toPathPng,
                        width: ConstantSizes.xxLarge.value,
                        color: Theme.of(context).colorScheme.tertiary,
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
