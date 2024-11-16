import 'package:flutter/material.dart';
import 'package:flutter_survey_app_mobile/config/localization/string_constants.dart';
import 'package:flutter_survey_app_mobile/core/utils/size/app_size/dynamic_size.dart';
import 'package:flutter_survey_app_mobile/core/utils/size/padding/dynamic_padding.dart';
import 'package:flutter_survey_app_mobile/core/utils/enum/image_enum.dart';
import 'package:flutter_survey_app_mobile/product/widgets/custom_text_widgets.dart';

class NoInternetWidget extends StatelessWidget {
  final VoidCallback refresh;
  const NoInternetWidget({
    required this.refresh,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: context.paddingAllMedium,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            ImageEnums.no_internet.toPathPng,
            height: context.dynamicHeight(0.1),
          ),
          SizedBox(height: context.dynamicHeight(0.01)),
          CustomTextSubTitleWidget(
            subTitle: StringConstants.error_connection,
          ),
          SizedBox(height: context.dynamicHeight(0.01)),
          CustomTextGreySubTitleWidget(
            maxLine: 3,
            subTitle: StringConstants.error_connection_msg_try,
          ),
          SizedBox(height: context.dynamicHeight(0.01)),
          TextButton(
            onPressed: refresh,
            child: Text(
              StringConstants.refresh,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Theme.of(context).colorScheme.tertiaryFixed,
                    fontWeight: FontWeight.bold,
                  ),
            ),
          ),
        ],
      ),
    );
  }
}
