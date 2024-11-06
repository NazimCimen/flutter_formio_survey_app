import 'package:flutter/material.dart';
import 'package:flutter_survey_app_mobile/core/size/app_size/dynamic_size.dart';
import 'package:flutter_survey_app_mobile/core/size/padding/dynamic_padding.dart';
import 'package:flutter_survey_app_mobile/product/widgets/custom_text_widgets.dart';

class CustomErrorWidget extends StatelessWidget {
  final String title;
  final IconData iconData;
  const CustomErrorWidget({
    required this.title,
    required this.iconData,
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
              iconData,
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
