import 'package:flutter/material.dart';
import 'package:flutter_survey_app/core/utils/app_size_extensions.dart';

extension BorderRadiusExtension on BuildContext {
  double get xLowRadius => dynamicHeight(0.005);
  double get lowRadius => dynamicHeight(0.01);
  double get mediumRadius => dynamicHeight(0.02);
  double get largeRadius => dynamicHeight(0.025);
  double get xLargeRadius => dynamicHeight(0.03);

  BorderRadius get borderRadiusAllXLow => BorderRadius.circular(xLowRadius);
  BorderRadius get borderRadiusAllLow => BorderRadius.circular(lowRadius);
  BorderRadius get borderRadiusAllMedium => BorderRadius.circular(mediumRadius);
  BorderRadius get borderRadiusAllLarge => BorderRadius.circular(largeRadius);
  BorderRadius get borderRadiusAllXLarge => BorderRadius.circular(xLargeRadius);

  BorderRadius get borderRadiusTopXLow =>
      BorderRadius.vertical(top: Radius.circular(xLowRadius));
  BorderRadius get borderRadiusTopLow =>
      BorderRadius.vertical(top: Radius.circular(lowRadius));
  BorderRadius get borderRadiusTopMedium =>
      BorderRadius.vertical(top: Radius.circular(mediumRadius));
  BorderRadius get borderRadiusTopLarge =>
      BorderRadius.vertical(top: Radius.circular(largeRadius));
  BorderRadius get borderRadiusTopXLarge =>
      BorderRadius.vertical(top: Radius.circular(xLargeRadius));

  BorderRadius get borderRadiusBottomXLow =>
      BorderRadius.vertical(bottom: Radius.circular(xLowRadius));
  BorderRadius get borderRadiusBottomLow =>
      BorderRadius.vertical(bottom: Radius.circular(lowRadius));
  BorderRadius get borderRadiusBottomMedium =>
      BorderRadius.vertical(bottom: Radius.circular(mediumRadius));
  BorderRadius get borderRadiusBottomLarge =>
      BorderRadius.vertical(bottom: Radius.circular(largeRadius));
  BorderRadius get borderRadiusBottomXLarge =>
      BorderRadius.vertical(bottom: Radius.circular(xLargeRadius));

  BorderRadius get borderRadiusLeftXLow =>
      BorderRadius.horizontal(left: Radius.circular(xLowRadius));
  BorderRadius get borderRadiusLeftLow =>
      BorderRadius.horizontal(left: Radius.circular(lowRadius));
  BorderRadius get borderRadiusLeftMedium =>
      BorderRadius.horizontal(left: Radius.circular(mediumRadius));
  BorderRadius get borderRadiusLeftLarge =>
      BorderRadius.horizontal(left: Radius.circular(largeRadius));
  BorderRadius get borderRadiusLeftXLarge =>
      BorderRadius.horizontal(left: Radius.circular(xLargeRadius));

  BorderRadius get borderRadiusRightXLow =>
      BorderRadius.horizontal(right: Radius.circular(xLowRadius));
  BorderRadius get borderRadiusRightLow =>
      BorderRadius.horizontal(right: Radius.circular(lowRadius));
  BorderRadius get borderRadiusRightMedium =>
      BorderRadius.horizontal(right: Radius.circular(mediumRadius));
  BorderRadius get borderRadiusRightLarge =>
      BorderRadius.horizontal(right: Radius.circular(largeRadius));
  BorderRadius get borderRadiusRightXLarge =>
      BorderRadius.horizontal(right: Radius.circular(xLargeRadius));
}
