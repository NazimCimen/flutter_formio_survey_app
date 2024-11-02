import 'package:flutter/material.dart';
import 'package:flutter_survey_app_mobile/config/localization/string_constanrs.dart';
import 'package:flutter_survey_app_mobile/config/routes/app_routes.dart';
import 'package:flutter_survey_app_mobile/config/routes/navigator_service.dart';
import 'package:flutter_survey_app_mobile/core/utils/app_border_radius_extensions.dart';
import 'package:flutter_survey_app_mobile/core/utils/app_size_extensions.dart';
import 'package:flutter_survey_app_mobile/core/utils/image_enum.dart';
import 'package:flutter_survey_app_mobile/feature/create_survey/presentation/widgets/custom_text_headline_title_widget.dart';
import 'package:flutter_survey_app_mobile/product/widgets/custom_text_widgets.dart';

part 'home_sub_view.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      appBar: _AppBar(),
      drawer: _DrawerWidget(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: context.dynamicHeight(0.05)),
          Padding(
            padding: context.paddingHorizAllMedium,
            child: const CustomTextTitleWidget(
              title: 'Capture Voices,\nUncover Trends',
            ),
          ),
          SizedBox(height: context.dynamicHeight(0.02)),
          _TabBarSection(),
          SizedBox(height: context.dynamicHeight(0.02)),
          const Expanded(
            child: _SurveyList(),
          ),
          SizedBox(height: context.dynamicHeight(0.02)),
        ],
      ),
    );
  }
}
