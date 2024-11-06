import 'package:flutter/material.dart';
import 'package:flutter_survey_app_mobile/core/base/base_stateful.dart';
import 'package:flutter_survey_app_mobile/core/utils/size/app_size/dynamic_size.dart';
import 'package:flutter_survey_app_mobile/core/utils/image_enum.dart';
import 'package:flutter_survey_app_mobile/feature/splash/presentation/mixin/splash_mixin.dart';
import 'package:flutter_survey_app_mobile/product/widgets/custom_text_widgets.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends BaseStateful<SplashView, void> with SplashMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: themeData.scaffoldBackgroundColor,
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                ImageEnums.appLogo.toPathPng,
                fit: BoxFit.cover,
                height: context.dynamicHeight(0.15),
              ),
              SizedBox(height: context.dynamicHeight(0.05)),
              const CustomTextHeadlineTitleWidget(title: 'FORMIO'),
            ],
          ),
        ),
      ),
    );
  }
}
