import 'package:flutter/material.dart';
import 'package:flutter_survey_app_mobile/core/size/app_size/constant_size.dart';

/// CONSTANT PADDING VALUES
extension ConstantPaddingExtension on BuildContext {
  EdgeInsets get cPaddingSmall => EdgeInsets.all(cLowValue);
  EdgeInsets get cPaddingMedium => EdgeInsets.all(cMediumValue);
  EdgeInsets get cPaddingLarge => EdgeInsets.all(cLargeValue);
  EdgeInsets get cPaddingxLarge => EdgeInsets.all(cXLargeValue);
  EdgeInsets get cPaddingxxLarge => EdgeInsets.all(cXxLargeValue);
}
