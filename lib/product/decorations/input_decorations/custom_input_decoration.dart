import 'package:flutter/material.dart';
import 'package:flutter_survey_app/core/utils/app_border_radius_extensions.dart';

class CustomInputDecoration {
  CustomInputDecoration._();
  static InputDecoration inputDecoration({
    required BuildContext context,
    required String hintText,
  }) =>
      InputDecoration(
        fillColor: Theme.of(context).colorScheme.onPrimaryContainer,
        filled: true,
        hintText: hintText,
        hintStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: Theme.of(context).colorScheme.tertiary,
              fontWeight: FontWeight.w500,
            ),
        errorStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: Theme.of(context).colorScheme.error,
            ),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(
            width: 2,
            color: Theme.of(context).colorScheme.error,
          ),
          borderRadius: context.borderRadiusAllLow,
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            width: 2,
            color: Theme.of(context).colorScheme.tertiary,
          ),
          borderRadius: context.borderRadiusAllLow,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: context.borderRadiusAllLow,
          borderSide: BorderSide(
            width: 2,
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
      );
}
