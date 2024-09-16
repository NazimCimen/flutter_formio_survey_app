import 'package:flutter/material.dart';
import 'package:flutter_survey_app/config/localization/string_constanrs.dart';
import 'package:flutter_survey_app/config/routes/app_routes.dart';
import 'package:flutter_survey_app/config/routes/navigator_service.dart';
import 'package:flutter_survey_app/core/utils/app_border_radius_extensions.dart';
import 'package:flutter_survey_app/core/utils/app_size_extensions.dart';
import 'package:flutter_survey_app/core/utils/image_enum.dart';
import 'package:flutter_survey_app/feature/create_survey/presentation/widgets/custom_text_headline_title_widget.dart';
import 'package:flutter_survey_app/product/widgets/custom_text_widgets.dart';
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
      appBar: const _AppBar(),
      drawer: const _DrawerWidget(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: context.dynamicHeight(0.02)),
          Padding(
            padding: context.paddingHorizAllMedium,
            child: const CustomTextTitleWidget(
              title: 'Capture Voices, Uncover Trends',
            ),
          ),
          SizedBox(height: context.dynamicHeight(0.02)),
          _TabBarSection(),
          SizedBox(height: context.dynamicHeight(0.02)),
          /*  const Expanded(
            child: _SurveyList(),
          ),*/
          SizedBox(height: context.dynamicHeight(0.02)),
        ],
      ),
    );
  }
}
