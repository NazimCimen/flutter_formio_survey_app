import 'package:flutter/material.dart';
import 'package:flutter_survey_app_mobile/core/utils/app_size_extensions.dart';
import 'package:flutter_survey_app_mobile/core/utils/image_enum.dart';
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
            ImageEnums.noInternet.toPathPng,
            height: context.dynamicHeight(0.1),
          ),
          SizedBox(height: context.dynamicHeight(0.01)),
          const CustomTextSubTitleWidget(
            subTitle: 'Bağlantı Hatası',
          ),
          SizedBox(height: context.dynamicHeight(0.01)),
          const CustomTextGreySubTitleWidget(
            maxLine: 3,
            subTitle:
                'İnternet Bağlantınız yok. Bağlantınızı kontrol edip tekrar deneyin',
          ),
          SizedBox(height: context.dynamicHeight(0.01)),
          TextButton(
            onPressed: refresh,
            child: Text(
              'Yeniden Dene',
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
