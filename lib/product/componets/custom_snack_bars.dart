import 'package:flutter/material.dart';

@immutable
class CustomSnackBars {
  const CustomSnackBars._();
  static void showCustomScaffoldSnackBar({
    required BuildContext context,
    required String text,
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Theme.of(context).colorScheme.surface,
        content: Text(
          text,
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: Theme.of(context).colorScheme.primary,
              ),
        ),
        duration: const Duration(seconds: 2),
      ),
    );
  }
}
