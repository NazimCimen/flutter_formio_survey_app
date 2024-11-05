import 'package:flutter/material.dart';
import 'package:flutter_survey_app_mobile/config/localization/string_constanrs.dart';
import 'package:flutter_survey_app_mobile/config/routes/app_routes.dart';
import 'package:flutter_survey_app_mobile/config/routes/navigator_service.dart';
import 'package:flutter_survey_app_mobile/core/utils/app_border_radius_extensions.dart';
import 'package:flutter_survey_app_mobile/core/utils/app_size_extensions.dart';
import 'package:flutter_survey_app_mobile/core/utils/image_enum.dart';
import 'package:flutter_survey_app_mobile/feature/create_survey/presentation/widgets/custom_text_headline_title_widget.dart';
import 'package:flutter_survey_app_mobile/feature/home/presentation/mixin/home_view_mixin.dart';
import 'package:flutter_survey_app_mobile/feature/home/presentation/widget/published_survey_list_widget.dart';
import 'package:flutter_survey_app_mobile/product/widgets/custom_text_widgets.dart';

part 'home_sub_view.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> with HomeViewMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const _AppBar(),
      drawer: const _DrawerWidget(),
      floatingActionButton: const _FloatActionButton(),
      body: Padding(
        padding: context.paddingHorizAllMedium,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: context.dynamicHeight(0.01)),
            const CustomTextTitleWidget(
              title: 'Capture Voices,\nUncover Trends',
            ),
            SizedBox(height: context.dynamicHeight(0.01)),
            Text(
              'Formio ile anketlerin oluştur yanıtları analiz et ve trendleri yakala.',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.tertiary,
                  ),
            ),
            const Expanded(
              child: PublishedSurveyListWidget(),
            ),
            SizedBox(height: context.dynamicHeight(0.02)),
          ],
        ),
      ),
    );
  }
}
