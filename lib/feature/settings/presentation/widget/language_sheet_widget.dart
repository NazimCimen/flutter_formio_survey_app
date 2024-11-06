import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_survey_app_mobile/config/localization/locale_constants.dart';
import 'package:flutter_survey_app_mobile/config/localization/string_constanrs.dart';
import 'package:flutter_survey_app_mobile/core/base/base_stateful.dart';
import 'package:flutter_survey_app_mobile/core/utils/size/app_size/constant_size.dart';
import 'package:flutter_survey_app_mobile/core/utils/size/app_size/dynamic_size.dart';
import 'package:flutter_survey_app_mobile/core/utils/size/border_radius/constant_border_radius.dart';
import 'package:flutter_survey_app_mobile/core/utils/size/padding/constant_padding.dart';
import 'package:flutter_survey_app_mobile/core/utils/size/padding/dynamic_padding.dart';

class LanguageSheetWidget extends StatefulWidget {
  const LanguageSheetWidget({super.key});

  @override
  State<LanguageSheetWidget> createState() => _LanguageSheetWidgetState();
}

class _LanguageSheetWidgetState
    extends BaseStateful<LanguageSheetWidget, void> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: context.dynamicHeight(0.6),
      child: Column(
        children: [
          SizedBox(height: context.dynamicHeight(0.02)),
          Center(
            child: Container(
              width: context.cLowValue * 5,
              height: context.cLowValue / 2,
              decoration: BoxDecoration(
                color: colorScheme.tertiary.withOpacity(0.5),
                borderRadius: context.cBorderRadiusSmall / 4,
              ),
            ),
          ),
          Padding(
            padding: context.cPaddingMedium,
            child: Text(
              StringConstants.select_language,
              style: textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: LocaleConstants.languageList.length,
              itemBuilder: (BuildContext context, int index) {
                final language = LocaleConstants.languageList[index];
                return ListTile(
                  title: Text(language.name, style: textTheme.titleMedium),
                  trailing: Padding(
                    padding: context.paddingAllLow,
                    child: Image.asset(language.flagName),
                  ),
                  onTap: () {
                    context.setLocale(language.locale);
                    Navigator.pop(context);
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
