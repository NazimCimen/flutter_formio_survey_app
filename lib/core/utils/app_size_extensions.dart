import 'package:flutter/material.dart';

extension ContextExtension on BuildContext {
  double dynamicWidht(double val) => MediaQuery.of(this).size.width * val;
  double dynamicHeight(double val) => MediaQuery.of(this).size.height * val;
}

extension NumberExtension on BuildContext {
  double get xLowValue => dynamicHeight(0.005);
  double get lowValue => dynamicHeight(0.01);
  double get mediumValue => dynamicHeight(0.02);
  double get largeValue => dynamicHeight(0.025);
  double get xLargeValue => dynamicHeight(0.03);
  double get xxLargeValue => dynamicHeight(0.1);
}

extension PaddingExtension on BuildContext {
  EdgeInsets get paddingAllXLow => EdgeInsets.all(xLowValue);
  EdgeInsets get paddingAllLow => EdgeInsets.all(lowValue);
  EdgeInsets get paddingAllMedium => EdgeInsets.all(mediumValue);
  EdgeInsets get paddingAllLarge => EdgeInsets.all(largeValue);
  EdgeInsets get paddingAllXlarge => EdgeInsets.all(xLargeValue);

  EdgeInsets get paddingHorizAllXLow =>
      EdgeInsets.only(left: xLowValue, right: xLowValue);
  EdgeInsets get paddingHorizAllLow =>
      EdgeInsets.only(left: lowValue, right: lowValue);
  EdgeInsets get paddingHorizAllMedium =>
      EdgeInsets.only(left: mediumValue, right: mediumValue);
  EdgeInsets get paddingHorizAllLarge =>
      EdgeInsets.only(left: largeValue, right: largeValue);
  EdgeInsets get paddingHorizAllXlarge =>
      EdgeInsets.only(left: xLargeValue, right: xLargeValue);

  EdgeInsets get paddingHorizLeftLow => EdgeInsets.only(left: lowValue);
  EdgeInsets get paddingHorizLeftMedium => EdgeInsets.only(left: mediumValue);
  EdgeInsets get paddingHorizLeftLarge => EdgeInsets.only(left: largeValue);
  EdgeInsets get paddingHorizLeftXlarge => EdgeInsets.only(left: xLargeValue);

  EdgeInsets get paddingHorizRightLow => EdgeInsets.only(right: lowValue);
  EdgeInsets get paddingHorizRightMedium => EdgeInsets.only(right: mediumValue);
  EdgeInsets get paddingHorizRightLarge => EdgeInsets.only(right: largeValue);
  EdgeInsets get paddingHorizRightXlarge => EdgeInsets.only(right: xLargeValue);

  EdgeInsets get paddingVertAllLow =>
      EdgeInsets.only(top: lowValue, bottom: lowValue);
  EdgeInsets get paddingVertAllMedium =>
      EdgeInsets.only(top: mediumValue, bottom: mediumValue);
  EdgeInsets get paddingVertAllLarge =>
      EdgeInsets.only(top: largeValue, bottom: largeValue);
  EdgeInsets get paddingVertAllXlarge =>
      EdgeInsets.only(top: xLargeValue, bottom: xLargeValue);

  EdgeInsets get paddingVertTopLow => EdgeInsets.only(top: lowValue);
  EdgeInsets get paddingVertTopMedium => EdgeInsets.only(top: mediumValue);
  EdgeInsets get paddingVertTopLarge => EdgeInsets.only(top: largeValue);
  EdgeInsets get paddingVertTopXlarge => EdgeInsets.only(top: xLargeValue);

  EdgeInsets get paddingVertBottomLow => EdgeInsets.only(bottom: lowValue);
  EdgeInsets get paddingVertBottomMedium =>
      EdgeInsets.only(bottom: mediumValue);
  EdgeInsets get paddingVertBottomLarge => EdgeInsets.only(bottom: largeValue);
  EdgeInsets get paddingVertBottomXlarge =>
      EdgeInsets.only(bottom: xLargeValue);
  EdgeInsets get paddingVertBottomXXlarge =>
      EdgeInsets.only(bottom: xxLargeValue);
}
