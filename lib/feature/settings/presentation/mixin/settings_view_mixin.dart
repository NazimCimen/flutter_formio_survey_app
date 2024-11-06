import 'package:flutter/material.dart';
import 'package:flutter_survey_app_mobile/config/theme/theme_manager.dart';
import 'package:flutter_survey_app_mobile/core/base/base_stateful.dart';
import 'package:flutter_survey_app_mobile/feature/settings/presentation/view/settings_view.dart';

mixin SettingsViewMixin on BaseStateful<SettingsView, ThemeManager> {
  ///THIS METHOD IS OVERRIDED IN SETTINGS VIEW
  void showLanguageModalBottomSheet(BuildContext context);
}
