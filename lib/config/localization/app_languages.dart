import 'package:flutter/material.dart';
@immutable
final class AppLanguages {
  final String name;
  final String flagName;
  final Locale locale;

  const AppLanguages({
    required this.name,
    required this.flagName,
    required this.locale,
  });
}
