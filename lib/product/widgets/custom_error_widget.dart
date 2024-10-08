import 'package:flutter/material.dart';
import 'package:flutter_survey_app/core/utils/app_size_extensions.dart';
import 'package:flutter_survey_app/product/widgets/custom_text_widgets.dart';

class CustomErrorWidget extends StatelessWidget {
  final String title;
  const CustomErrorWidget({
    required this.title,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: context.paddingHorizAllXlarge,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.error_outline,
              size: context.dynamicWidht(0.28),
              color: Theme.of(context).colorScheme.tertiary,
            ),
            SizedBox(height: context.dynamicHeight(0.02)),
            CustomTextGreySubTitleWidget(
              maxLine: 3,
              subTitle: title,
            ),
            SizedBox(height: context.dynamicHeight(0.02)),
          ],
        ),
      ),
    );
  }
}
