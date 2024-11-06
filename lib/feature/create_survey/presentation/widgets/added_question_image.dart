import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_survey_app_mobile/core/size/app_size/dynamic_size.dart';
import 'package:flutter_survey_app_mobile/product/constants/image_aspect_ratio.dart';
import 'package:flutter_survey_app_mobile/product/decorations/box_decorations/custom_box_decoration.dart';
import 'package:flutter_survey_app_mobile/product/widgets/custom_text_widgets.dart';

class AddedQuestionImage extends StatelessWidget {
  const AddedQuestionImage({
    required this.image,
    super.key,
  });

  final Uint8List? image;

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: image != null,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const CustomTextSubTitleWidget(
            subTitle: 'Question Image',
          ),
          SizedBox(height: context.dynamicHeight(0.005)),
          AspectRatio(
            aspectRatio: ImageAspectRatioEnum.questionImage.ratioCrop.ratioX /
                ImageAspectRatioEnum.questionImage.ratioCrop.ratioY,
            child: Container(
              decoration: CustomBoxDecoration.customBoxDecorationForImage(
                context,
              ),
              child: image != null
                  ? Image.memory(
                      image!,
                    )
                  : const SizedBox.shrink(),
            ),
          ),
        ],
      ),
    );
  }
}
