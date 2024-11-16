import 'package:flutter/material.dart';
import 'package:flutter_survey_app_mobile/config/localization/string_constants.dart';
import 'package:flutter_survey_app_mobile/config/routes/app_routes.dart';
import 'package:flutter_survey_app_mobile/config/routes/navigator_service.dart';
import 'package:flutter_survey_app_mobile/core/base/base_stateless.dart';
import 'package:flutter_survey_app_mobile/core/base/state.dart';
import 'package:flutter_survey_app_mobile/core/utils/size/app_size/dynamic_size.dart';
import 'package:flutter_survey_app_mobile/core/utils/size/border_radius/dynamic_border_radius.dart';
import 'package:flutter_survey_app_mobile/core/utils/size/padding/dynamic_padding.dart';
import 'package:flutter_survey_app_mobile/core/utils/enum/image_enum.dart';
import 'package:flutter_survey_app_mobile/feature/home/presentation/viewmodel/home_view_model.dart';
import 'package:flutter_survey_app_mobile/feature/shared_layers/domain/entity/survey_entity.dart';
import 'package:flutter_survey_app_mobile/product/widgets/custom_image_widget.dart';
import 'package:flutter_survey_app_mobile/product/widgets/custom_progress_indicator.dart';
import 'package:flutter_survey_app_mobile/product/widgets/custom_text_widgets.dart';
import 'package:provider/provider.dart';

class PublishedSurveyListWidget extends StatelessWidget {
  const PublishedSurveyListWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeViewModel>(
      builder: (context, viewModel, child) {
        if (viewModel.state == ViewState.success) {
          return viewModel.publishedSurveys.isNotEmpty
              ? _PublishedSurveys(
                  publishedSurveys: viewModel.publishedSurveys,
                )
              : const _NoPublishedSurvey();
        } else {
          return const CustomProgressIndicator();
        }
      },
    );
  }
}

class _PublishedSurveys extends StatelessWidget {
  final List<SurveyEntity> publishedSurveys;
  const _PublishedSurveys({required this.publishedSurveys});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomTextHeadlineTitleWidget(
          title: StringConstants.published_surveys,
        ),
        SizedBox(height: context.dynamicHeight(0.03)),
        Expanded(
          child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              childAspectRatio: 1.2,
            ),
            itemCount: publishedSurveys.length,
            itemBuilder: (context, index) {
              return _SurveyCard(
                title: publishedSurveys[index].surveyTitle,
                answeredCount: publishedSurveys[index].answeringCount,
                imageUrl: publishedSurveys[index].surveyImageUrl,
              );
            },
          ),
        ),
      ],
    );
  }
}

class _SurveyCard extends BaseStateless<void> {
  const _SurveyCard({
    required this.title,
    required this.answeredCount,
    required this.imageUrl,
  });
  final String? title;
  final int? answeredCount;
  final String? imageUrl;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: colorScheme(context).onPrimaryContainer,
      shape:
          RoundedRectangleBorder(borderRadius: context.borderRadiusAllMedium),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: CustomImageWidget(
              imageUrl: imageUrl,
              placeholderImagePath: ImageEnums.bg_default_survey.toPathPng,
            ),
          ),
          Padding(
            padding: context.paddingAllLow,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomTextSubTitleWidget(subTitle: title ?? ''),
                CustomTextGreySubTitleWidget(
                  subTitle: answeredCount != null
                      ? '$answeredCount ${StringConstants.answered}'
                      : '',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _NoPublishedSurvey extends BaseStateless<void> {
  const _NoPublishedSurvey();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Image.asset(
            ImageEnums.bg_home_no_survey.toPathPng,
            fit: BoxFit.cover,
            height: context.dynamicHeight(0.25),
          ),
          SizedBox(height: context.dynamicHeight(0.03)),
          Text(
            textAlign: TextAlign.center,
            StringConstants.no_survey_lets_do,
            style: textTheme(context).bodyMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          SizedBox(height: context.dynamicHeight(0.015)),
          OutlinedButton(
            style: OutlinedButton.styleFrom(
              shape: ContinuousRectangleBorder(
                borderRadius: context.borderRadiusAllLow,
              ),
            ),
            onPressed: () {
              NavigatorService.pushNamed(AppRoutes.createSurveyInfoView);
            },
            child: CustomTextHeadlineTitleWidget(
              title: StringConstants.create_now,
            ),
          ),
        ],
      ),
    );
  }
}
