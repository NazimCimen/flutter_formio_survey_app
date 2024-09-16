import 'package:flutter/material.dart';

class SettingsOptionWidget extends StatelessWidget {
  final IconData icon;
  final String text;
  final VoidCallback onTap;

  const SettingsOptionWidget(
      {super.key, required this.icon, required this.text, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8.0),
      child: ListTile(
        leading: Icon(icon, color: Theme.of(context).iconTheme.color),
        title: Text(text, style: Theme.of(context).textTheme.bodyMedium),
        trailing: Icon(Icons.arrow_forward_ios,
            color: Theme.of(context).iconTheme.color),
        onTap: onTap,
      ),
    );
  }
}
