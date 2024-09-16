import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_survey_app/config/localization/string_constanrs.dart';

@immutable
class CustomDialogs {
  const CustomDialogs._();
  static void showMyDialog(
          {required BuildContext context, required bool condition}) =>
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
  }) {
    showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            title,
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          content: Text(
            description,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          actions: <Widget>[
            TextButton(
              child: Text(
                'Bir Sorun Oluştu Daha Sonra Tekrar Deneyin',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      color: Theme.of(context).colorScheme.primary,
                      fontWeight: FontWeight.bold,
                    ),
              ),
              onPressed: () {
                SystemNavigator.pop();
              },
            ),
          ],
        );
      },
    );
  }
}
