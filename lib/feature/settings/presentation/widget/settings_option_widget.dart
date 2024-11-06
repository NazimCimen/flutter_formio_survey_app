import 'package:flutter/material.dart';
import 'package:flutter_survey_app_mobile/core/base/base_stateless.dart';

class SettingsOptionWidget extends BaseStateless<void> {
  final IconData icon;
  final String text;
  final VoidCallback onTap;

  const SettingsOptionWidget({
    required this.icon,
    required this.text,
    required this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: Icon(icon, color: iconThemeData(context).color),
        title: Text(text, style: textTheme(context).bodyMedium),
        trailing: Icon(
          Icons.arrow_forward_ios,
          color: themeData(context).iconTheme.color,
        ),
        onTap: onTap,
      ),
    );
  }
}
