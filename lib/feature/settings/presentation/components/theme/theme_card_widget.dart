import 'package:flutter/material.dart';
import 'package:flutter_survey_app_mobile/config/localization/string_constanrs.dart';
import 'package:flutter_survey_app_mobile/config/theme/theme_manager.dart';
import 'package:flutter_survey_app_mobile/core/utils/app_border_radius_extensions.dart';
import 'package:flutter_survey_app_mobile/core/utils/app_size_extensions.dart';
import 'package:flutter_survey_app_mobile/feature/settings/presentation/view/settings_view.dart';
import 'package:provider/provider.dart';

class ThemeCardWidget extends StatefulWidget {
  const ThemeCardWidget({super.key});

  @override
  State<ThemeCardWidget> createState() => _ThemeCardWidgetState();
}

class _ThemeCardWidgetState extends SettingsBase<ThemeCardWidget> {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Consumer<ThemeManager>(
        builder: (context, provider, child) {
          return Padding(
            padding: context.paddingAllLarge,
            child: Column(
              children: [
                Expanded(
                    child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Icon(Icons.palette_outlined,
                        color: Theme.of(context).iconTheme.color),
                    Text('  ${StringConstants.theme}',
                        style: Theme.of(context).textTheme.bodyMedium),
                  ],
                )),
                Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: context.paddingAllMedium,
                        child: ThemeOptionWidget(
                          selectedThemeIcon: Icons.light_mode,
                          unSelectedThemeIcon: Icons.light_mode_outlined,
                          text: StringConstants.light_mode,
                          onChanged: (bool? value) {
                            value != null
                                ? changeTheme(
                                    value,
                                    provider,
                                    ThemeEnum.light,
                                  )
                                : null;
                          },
                          value: false,
                          groupValue: provider.currentTheme == ThemeEnum.light
                              ? false
                              : true,
                          borderColor: Theme.of(context).colorScheme.secondary,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                          padding: context.paddingAllMedium,
                          child: ThemeOptionWidget(
                            selectedThemeIcon: Icons.dark_mode,
                            unSelectedThemeIcon: Icons.dark_mode_outlined,
                            text: StringConstants.dark_mode,
                            onChanged: (bool? value) {
                              value != null
                                  ? changeTheme(value, provider, ThemeEnum.dark)
                                  : null;
                            },
                            value: true,
                            groupValue: provider.currentTheme == ThemeEnum.light
                                ? false
                                : true,
                            borderColor:
                                Theme.of(context).colorScheme.secondary,
                          )),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class ThemeOptionWidget extends StatelessWidget {
  final IconData selectedThemeIcon;
  final IconData unSelectedThemeIcon;
  final String text;
  final bool value;
  final bool groupValue;
  final Color borderColor;
  final Function(bool?)? onChanged;

  const ThemeOptionWidget({
    super.key,
    required this.selectedThemeIcon,
    required this.unSelectedThemeIcon,
    required this.text,
    required this.value,
    required this.groupValue,
    required this.onChanged,
    required this.borderColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
            color: (value == false && groupValue == false) ||
                    (value == true && groupValue == true)
                ? borderColor
                : Colors.transparent,
            width: 2),
        borderRadius: context.borderRadiusAllMedium,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 20),
          (value == false && groupValue == false) ||
                  (value == true && groupValue == true)
              ? Icon(
                  selectedThemeIcon,
                  size: 30,
                  color: borderColor,
                )
              : Icon(
                  unSelectedThemeIcon,
                  size: 30,
                ),
          SizedBox(height: 8),
          Text(text,
              maxLines: 1,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: (value == false && groupValue == false) ||
                            (value == true && groupValue == true)
                        ? Theme.of(context).colorScheme.secondary
                        : null,
                  )),
          Radio<bool>(
            activeColor: Theme.of(context).colorScheme.secondary,
            value: value,
            groupValue: groupValue,
            onChanged: onChanged,
          ),
          SizedBox(height: 20),
        ],
      ),
    );
  }
}
