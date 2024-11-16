import 'package:flutter/material.dart';
import 'package:flutter_survey_app_mobile/config/localization/string_constants.dart';
import 'package:flutter_survey_app_mobile/config/routes/app_routes.dart';
import 'package:flutter_survey_app_mobile/config/routes/navigator_service.dart';
import 'package:flutter_survey_app_mobile/core/base/base_stateful.dart';
import 'package:flutter_survey_app_mobile/core/utils/size/app_size/dynamic_size.dart';
import 'package:flutter_survey_app_mobile/core/utils/size/border_radius/dynamic_border_radius.dart';
import 'package:flutter_survey_app_mobile/core/utils/size/padding/dynamic_padding.dart';
import 'package:flutter_survey_app_mobile/core/utils/enum/image_enum.dart';
import 'package:flutter_survey_app_mobile/feature/home/presentation/mixin/home_view_mixin.dart';
import 'package:flutter_survey_app_mobile/feature/home/presentation/viewmodel/home_view_model.dart';
import 'package:flutter_survey_app_mobile/feature/home/presentation/widget/published_survey_list_widget.dart';
import 'package:flutter_survey_app_mobile/product/widgets/custom_text_widgets.dart';

part 'home_sub_view.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends BaseStateful<HomeView, HomeViewModel>
    with HomeViewMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const _AppBar(),
      drawer: const _DrawerWidget(),
      floatingActionButton:
          isVisibleFloatActionButton() ? const _FloatActionButton() : null,
      body: Padding(
        padding: context.paddingHorizAllMedium,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: context.dynamicHeight(0.01)),
            CustomTextTitleWidget(
              title: StringConstants.home_title,
            ),
            SizedBox(height: context.dynamicHeight(0.01)),
            Text(
              StringConstants.home_title_desc,
              style: textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.tertiary,
              ),
            ),
            SizedBox(
              height: isVisibleFloatActionButton()
                  ? context.dynamicHeight(0.03)
                  : context.dynamicHeight(0.1),
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
