import 'package:flutter/material.dart';
import 'package:flutter_survey_app_mobile/config/localization/locale_constants.dart';
import 'package:flutter_survey_app_mobile/config/localization/string_constanrs.dart';
import 'package:flutter_survey_app_mobile/core/utils/app_size_extensions.dart';
import 'package:flutter_survey_app_mobile/feature/settings/presentation/view/settings_view.dart';

class LanguageSheetWidget extends StatefulWidget {
  const LanguageSheetWidget({super.key});

  @override
  State<LanguageSheetWidget> createState() => _LanguageSheetWidgetState();
}

class _LanguageSheetWidgetState extends SettingsBase<LanguageSheetWidget> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.6,
      child: Column(
        children: [
          SizedBox(height: context.dynamicHeight(0.02)),
          Center(
            child: Container(
              width: 40.0,
              height: 5.0,
              decoration: BoxDecoration(
                color: Colors.grey.withOpacity(0.5),
                borderRadius: BorderRadius.circular(2.5),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              StringConstants.select_language,
              style: TextStyle(
                fontSize: 20,
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
                  title: Text(language.name),
                  trailing: Padding(
                    padding: context.paddingAllLow,
                    child: Image.asset(language.flagName),
                  ),
                  onTap: () {
                    changeLanguage(language.locale);
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
