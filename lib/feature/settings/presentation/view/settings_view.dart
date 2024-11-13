import 'package:flutter/material.dart';
import 'package:flutter_survey_app_mobile/config/localization/string_constanrs.dart';
import 'package:flutter_survey_app_mobile/config/theme/theme_manager.dart';
import 'package:flutter_survey_app_mobile/core/base/base_stateful.dart';
import 'package:flutter_survey_app_mobile/core/utils/size/padding/dynamic_padding.dart';
import 'package:flutter_survey_app_mobile/feature/settings/presentation/widget/settings_option_widget.dart';
import 'package:flutter_survey_app_mobile/feature/settings/presentation/widget/language_sheet_widget.dart';
import 'package:flutter_survey_app_mobile/feature/settings/presentation/widget/theme_card_widget.dart';
import 'package:flutter_survey_app_mobile/feature/settings/presentation/mixin/settings_view_mixin.dart';
import 'package:flutter_survey_app_mobile/product/widgets/custom_text_widgets.dart';
part 'settings_sub_view.dart';

class SettingsView extends StatefulWidget {
  const SettingsView({super.key});

  @override
  SettingsViewState createState() => SettingsViewState();
}

class SettingsViewState extends BaseStateful<SettingsView, ThemeManager>
    with SettingsViewMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const _AppBar(),
      body: ListView(
        padding: context.paddingAllLow,
        children: [
          if (watchViewModel.isLoadingTheme)
            LinearProgressIndicator(
              color: colorScheme.secondary,
            ),
          const ThemeCardWidget(),
          SettingsOptionWidget(
            icon: Icons.language,
            text: StringConstants.language,
            onTap: () {
              showLanguageModalBottomSheet(context);
            },
          ),
        ],
      ),
    );
  }

  @override
  void showLanguageModalBottomSheet(BuildContext context) {
    showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) {
        return const LanguageSheetWidget();
      },
    );
  }
}
