import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_survey_app_mobile/config/routes/app_routes.dart';
import 'package:flutter_survey_app_mobile/config/routes/navigator_service.dart';
import 'package:flutter_survey_app_mobile/core/base/base_stateless.dart';
import 'package:flutter_survey_app_mobile/core/utils/size/app_size/dynamic_size.dart';
import 'package:flutter_survey_app_mobile/core/utils/size/padding/dynamic_padding.dart';
import 'package:flutter_survey_app_mobile/core/utils/image_enum.dart';
import 'package:flutter_survey_app_mobile/feature/create_survey/presentation/viewmodel/create_survey_view_model.dart';
import 'package:flutter_survey_app_mobile/product/componets/custom_snack_bars.dart';
import 'package:flutter_survey_app_mobile/product/widgets/custom_text_widgets.dart';

class SurveySharedSuccessView extends StatelessWidget {
  final String surveyLink;
  const SurveySharedSuccessView({
    required this.surveyLink,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const _AppBar(),
      body: Padding(
        padding: context.paddingAllMedium,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              ImageEnums.success.toPathPng,
              height: context.dynamicHeight(0.1),
            ),
            SizedBox(height: context.dynamicHeight(0.02)),
            const CustomTextSubTitleWidget(
              subTitle: 'Anketiniz Başarılı bir şekilde oluşturuldu.',
            ),
            SizedBox(height: context.dynamicHeight(0.02)),
            const _ShareSurvey(),
          ],
        ),
      ),
    );
  }
}

class _ShareSurvey extends BaseStateless<CreateSurveyViewModel> {
  const _ShareSurvey();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _TextButton(
          iconData: Icons.share,
          text: 'Paylaş',
          onPressed: () {
            readViewModel(context).shareSurveyLink();
          },
        ),
        _TextButton(
          iconData: Icons.copy,
          text: 'Copy Link',
          onPressed: () {
            Clipboard.setData(
              ClipboardData(
                text: readViewModel(context).getSurveyLink(),
              ),
            );

            CustomSnackBars.showCustomScaffoldSnackBar(
              context: context,
              text: 'Link kopyalandı!',
            );
          },
        ),
      ],
    );
  }
}

class _TextButton extends BaseStateless<void> {
  final IconData iconData;
  final VoidCallback onPressed;
  final String text;
  const _TextButton({
    required this.iconData,
    required this.onPressed,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
      onPressed: onPressed,
      icon: Icon(
        iconData,
        color: Theme.of(context).colorScheme.tertiaryFixed,
      ),
      label: Text(
        text,
        overflow: TextOverflow.ellipsis,
        style: textTheme(context).bodySmall?.copyWith(
              fontWeight: FontWeight.bold,
            ),
      ),
    );
  }
}

class _AppBar extends BaseStateless<CreateSurveyViewModel>
    implements PreferredSizeWidget {
  const _AppBar();

  @override
  Widget build(BuildContext context) {
    return AppBar(
      forceMaterialTransparency: true,
      elevation: 0,
      backgroundColor: Colors.transparent,
      actions: [
        TextButton(
          onPressed: () {
            readViewModel(context).resetViewModel();
            NavigatorService.pushNamedAndRemoveUntil(AppRoutes.homeView);
          },
          child: Text(
            'Ana Sayfa',
            style: textTheme(context).titleLarge?.copyWith(
                  color: colorScheme(context).primary,
                  fontWeight: FontWeight.bold,
                ),
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
