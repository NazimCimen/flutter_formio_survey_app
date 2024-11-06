import 'package:flutter/material.dart';
import 'package:flutter_survey_app_mobile/core/size/border_radius/dynamic_border_radius.dart';

class CustomBoxDecoration {
  CustomBoxDecoration._();
  static BoxDecoration customBoxDecorationForImage(BuildContext context) {
    return BoxDecoration(
      borderRadius: context.borderRadiusAllLow,
      color: Theme.of(context).colorScheme.onPrimaryContainer,
      border: Border.all(
        color: Theme.of(context).colorScheme.tertiary,
        width: 2,
      ),
    );
  }

  static BoxDecoration customBoxDecoration(BuildContext context) {
    return BoxDecoration(
      color: Theme.of(context).colorScheme.surface,
      borderRadius: context.borderRadiusAllLow,
    );
  }
}
