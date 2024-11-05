import 'package:flutter/material.dart';
import 'package:flutter_survey_app_mobile/core/utils/app_border_radius_extensions.dart';
import 'package:flutter_survey_app_mobile/core/utils/app_size_extensions.dart';
import 'package:flutter_survey_app_mobile/core/utils/image_enum.dart';
import 'package:flutter_survey_app_mobile/feature/create_survey/presentation/viewmodel/create_survey_view_model.dart';
import 'package:flutter_survey_app_mobile/feature/create_survey/presentation/widgets/custom_text_headline_title_widget.dart';
import 'package:flutter_survey_app_mobile/feature/home/presentation/viewmodel/home_view_model.dart';
import 'package:flutter_survey_app_mobile/feature/shared_layers/domain/entity/survey_entity.dart';
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
        if (viewModel.state == ViewState.loading) {
          return const CustomProgressIndicator();
        } else if (viewModel.publishedSurveys.isNotEmpty) {
          return _PublishedSurveys(
            publishedSurveys: viewModel.publishedSurveys,
          );
        } else {
          return const _NoPublishedSurvey();
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
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        childAspectRatio: 1.2,
      ),
      itemCount: publishedSurveys.length,
      itemBuilder: (context, index) {
        return _SurveyCard(
          title: publishedSurveys[index].surveyTitle ?? '',
          subtitle: publishedSurveys[index].answeringCount != null
              ? '${publishedSurveys[index].answeringCount} answered'
              : '',
          imageUrl: 'https://a.d-cd.net/J3aZtvdAfEzaArEuyR0d17Z_o1s-1920.jpg',
        );
      },
    );
  }
}

class _SurveyCard extends StatelessWidget {
  const _SurveyCard({
    required this.title,
    required this.subtitle,
    required this.imageUrl,
  });
  final String title;
  final String subtitle;
  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Theme.of(context).colorScheme.onPrimaryContainer,
      shape:
          RoundedRectangleBorder(borderRadius: context.borderRadiusAllMedium),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius: context.borderRadiusTopMedium,
              child: Image.network(
                imageUrl,
                fit: BoxFit.cover,
                width: double.infinity,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) {
                    return child;
                  }
                  return Center(
                    child: CircularProgressIndicator(
                      value: loadingProgress.expectedTotalBytes != null
                          ? loadingProgress.cumulativeBytesLoaded /
                              loadingProgress.expectedTotalBytes!
                          : null,
                    ),
                  );
                },
                errorBuilder: (context, error, stackTrace) {
                  return Center(
                    child: Icon(
                      Icons.error,
                      color: Theme.of(context).colorScheme.error,
                    ),
                  );
                },
              ),
            ),
          ),
          Padding(
            padding: context.paddingAllLow,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomTextSubTitleWidget(subTitle: title),
                CustomTextGreySubTitleWidget(
                  subTitle: subtitle,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _NoPublishedSurvey extends StatelessWidget {
  const _NoPublishedSurvey();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Image.asset(
            ImageEnums.webtest8.toPathPng,
            fit: BoxFit.cover,
            height: context.dynamicHeight(0.25),
          ),
          SizedBox(height: context.dynamicHeight(0.03)),
          Text(
            textAlign: TextAlign.center,
            'Henüz bir anketiniz yok, haydi hemen bir tane oluşturalım!',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          SizedBox(height: context.dynamicHeight(0.01)),
          OutlinedButton(
            style: OutlinedButton.styleFrom(
              shape: ContinuousRectangleBorder(
                borderRadius: context.borderRadiusAllLow,
              ),
            ),
            onPressed: () {},
            child: const CustomTextHeadlineTitleWidget(
              title: 'Hemen Oluştur',
            ),
          ),
        ],
      ),
    );
  }
}
