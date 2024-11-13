import 'package:flutter/material.dart';
import 'package:flutter_survey_app_mobile/core/utils/size/app_size/constant_size.dart';

/// CONSTANT PADDING VALUES
extension ConstantBorderRaiusExtension on BuildContext {
  BorderRadius get cBorderRadiusSmall => BorderRadius.circular(cLowValue);
  BorderRadius get cBorderRadiusMedium => BorderRadius.circular(cMediumValue);
  BorderRadius get cBorderRadiusLarge => BorderRadius.circular(cLargeValue);
  BorderRadius get cBorderRadiusXLarge => BorderRadius.circular(cXLargeValue);
  BorderRadius get cBorderRadiusXxLarge => BorderRadius.circular(cXxLargeValue);
}
