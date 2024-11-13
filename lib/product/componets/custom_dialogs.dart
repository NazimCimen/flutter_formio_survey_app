import 'package:flutter/material.dart';
import 'package:flutter_survey_app_mobile/config/localization/string_constants.dart';
import 'package:flutter_survey_app_mobile/core/utils/size/app_size/dynamic_size.dart';
import 'package:flutter_survey_app_mobile/core/utils/size/border_radius/dynamic_border_radius.dart';

@immutable
class CustomDialogs {
  const CustomDialogs._();
  static void showMyDialog({
    required BuildContext context,
    required bool condition,
  }) =>
      showDialog<void>(
        context: context,
        barrierColor: Colors.transparent,
        barrierDismissible: false,
        builder: (BuildContext context) {
          if (condition == true) {}

          return const AlertDialog();
        },
      );

  static void showCustomDialog({
    required BuildContext context,
    required String title,
    required String description,
    required VoidCallback? refresh,
    required String? imagePath,
  }) {
    showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          actionsAlignment: MainAxisAlignment.spaceBetween,
          shape: ContinuousRectangleBorder(
            borderRadius: context.borderRadiusAllLarge,
          ),
          title: Text(
            textAlign: TextAlign.start,
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
            title,
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          content: Text(
            textAlign: TextAlign.start,
            overflow: TextOverflow.ellipsis,
            maxLines: 3,
            description,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          icon: imagePath != null
              ? Image.asset(
                  imagePath,
                  height: context.dynamicHeight(0.25),
                )
              : null,
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text(
                StringConstants.close,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Theme.of(context).colorScheme.tertiaryFixed,
                      fontWeight: FontWeight.bold,
                    ),
              ),
            ),
            if (refresh != null)
              TextButton(
                onPressed: refresh,
                child: Text(
                  StringConstants.refresh,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Theme.of(context).colorScheme.tertiaryFixed,
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ),
          ],
        );
      },
    );
  }
}
