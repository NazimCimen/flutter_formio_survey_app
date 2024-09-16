import 'package:flutter/material.dart';

class CustomTextHeadlineTitleWidget extends StatelessWidget {
  final String title;
  const CustomTextHeadlineTitleWidget({
    required this.title,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Text(title, style: Theme.of(context).textTheme.titleLarge);
  }
}
