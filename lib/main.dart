import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_survey_app_mobile/config/localization/locale_constants.dart';
import 'package:flutter_survey_app_mobile/config/localization/string_constanrs.dart';
import 'package:flutter_survey_app_mobile/config/routes/app_routes.dart';
import 'package:flutter_survey_app_mobile/config/routes/navigator_service.dart';
import 'package:flutter_survey_app_mobile/config/theme/application_theme.dart';
import 'package:flutter_survey_app_mobile/config/theme/theme_manager.dart';
import 'package:flutter_survey_app_mobile/dependency_injection/dependency_injection.dart';
import 'package:flutter_survey_app_mobile/feature/create_survey/presentation/viewmodel/create_survey_view_model.dart';
import 'package:flutter_survey_app_mobile/firebase_options.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';

//371
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await Hive.initFlutter();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  setupLocator();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<ThemeManager>(
          create: (context) => ThemeManager(),
        ),
        ChangeNotifierProvider<CreateSurveyViewModel>(
          create: (_) => serviceLocator<CreateSurveyViewModel>(),
        ),
      ],
      child: EasyLocalization(
        supportedLocales: const [
          LocaleConstants.enLocale,
          LocaleConstants.trLocale,
          LocaleConstants.frLocale,
          LocaleConstants.arLocale,
          LocaleConstants.esLocale,
          LocaleConstants.deLocale,
          LocaleConstants.itLocale,
          LocaleConstants.ptLocale,
          LocaleConstants.zhLocale,
          LocaleConstants.jaLocale,
          LocaleConstants.ruLocale,
        ],
        path: LocaleConstants.localePath,
        fallbackLocale: LocaleConstants.trLocale,
        child: const MyApp(),
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeManager>(
      builder: (context, provider, child) => MaterialApp(
        title: StringConstants.appName,
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        locale: context.locale,
        theme: CustomDarkTheme().themeData,
        debugShowCheckedModeBanner: false,
        navigatorKey: NavigatorService.navigatorKey,
        routes: AppRoutes.routes,
        initialRoute: AppRoutes.initialRoute,
      ),
    );
  }
}
