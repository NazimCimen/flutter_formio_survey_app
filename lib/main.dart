import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_survey_app_mobile/config/localization/string_constants.dart';
import 'package:flutter_survey_app_mobile/config/routes/app_routes.dart';
import 'package:flutter_survey_app_mobile/config/routes/navigator_service.dart';
import 'package:flutter_survey_app_mobile/config/theme/theme_manager.dart';
import 'package:flutter_survey_app_mobile/core/init/app_init.dart';
import 'package:provider/provider.dart';

void main() async {
  final appInit = AppInitImpl();
  await appInit.run();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeManager>(
      builder: (context, themeManager, child) => MaterialApp(
        title: StringConstants.appName,
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        locale: context.locale,
        theme: themeManager.currentTheme,
        themeMode: themeManager.themeMode,
        debugShowCheckedModeBanner: false,
        navigatorKey: NavigatorService.navigatorKey,
        routes: AppRoutes.routes,
        initialRoute: AppRoutes.initialRoute,
      ),
    );
  }
}
