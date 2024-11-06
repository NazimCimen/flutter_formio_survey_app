import 'package:flutter/material.dart';
import 'package:flutter_survey_app_mobile/config/localization/string_constanrs.dart';
import 'package:flutter_survey_app_mobile/config/theme/theme_manager.dart';
import 'package:flutter_survey_app_mobile/core/base/base_stateful.dart';
import 'package:flutter_survey_app_mobile/core/base/base_stateless.dart';
import 'package:flutter_survey_app_mobile/core/size/app_size/constant_size.dart';
import 'package:flutter_survey_app_mobile/core/size/border_radius/dynamic_border_radius.dart';
import 'package:flutter_survey_app_mobile/core/size/padding/dynamic_padding.dart';
import 'package:provider/provider.dart';

class ThemeCardWidget extends StatefulWidget {
  const ThemeCardWidget({super.key});

  @override
  State<ThemeCardWidget> createState() => _ThemeCardWidgetState();
}

class _ThemeCardWidgetState extends BaseStateful<ThemeCardWidget, void> {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Consumer<ThemeManager>(
        builder: (context, themeManager, child) {
          return Padding(
            padding: context.paddingAllLarge,
            child: Column(
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.palette_outlined,
                      color: Theme.of(context).iconTheme.color,
                    ),
                    Text(
                      '  ${StringConstants.theme}',
                      style: textTheme.bodyMedium,
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: context.paddingAllMedium,
                        child: _ThemeOptionWidget(
                          selectedThemeIcon: Icons.light_mode,
                          unSelectedThemeIcon: Icons.light_mode_outlined,
                          text: StringConstants.light_mode,
                          onChanged: (bool? value) {
                            themeManager.changeTheme(ThemeEnum.light);
                          },
                          value:
                              themeManager.currentThemeEnum == ThemeEnum.light,
                          groupValue: true,
                          borderColor: colorScheme.primary,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: context.paddingAllMedium,
                        child: _ThemeOptionWidget(
                          selectedThemeIcon: Icons.dark_mode,
                          unSelectedThemeIcon: Icons.dark_mode_outlined,
                          text: StringConstants.dark_mode,
                          onChanged: (bool? value) {
                            themeManager.changeTheme(ThemeEnum.dark);
                          },
                          value:
                              themeManager.currentThemeEnum == ThemeEnum.dark,
                          groupValue: true,
                          borderColor: colorScheme.primary,
                        ),
                      ),
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

class _ThemeOptionWidget extends BaseStateless<void> {
  final IconData selectedThemeIcon;
  final IconData unSelectedThemeIcon;
  final String text;
  final bool value;
  final bool groupValue;
  final Color borderColor;
  final void Function(bool?)? onChanged;

  const _ThemeOptionWidget({
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
          color: value ? borderColor : Colors.transparent,
          width: 2,
        ),
        borderRadius: context.borderRadiusAllMedium,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: context.cMediumValue),
          if (value == false)
            Icon(
              unSelectedThemeIcon,
              size: context.cXLargeValue,
            ),
          if (value == true)
            Icon(
              selectedThemeIcon,
              size: context.cXLargeValue,
              color: borderColor,
            ),
          SizedBox(
            height: context.cLowValue,
          ),
          Text(
            text,
            maxLines: 1,
            style: textTheme(context).bodyMedium?.copyWith(
                  color: colorScheme(context).onSurface,
                ),
          ),
          Radio<bool>(
            activeColor: colorScheme(context).onSurface,
            value: value,
            groupValue: groupValue,
            onChanged: onChanged,
          ),
          SizedBox(height: context.cMediumValue),
        ],
      ),
    );
  }
}
