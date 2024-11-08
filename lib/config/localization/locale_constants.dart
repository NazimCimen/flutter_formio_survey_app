import 'dart:ui';
import 'package:flutter/foundation.dart';
import 'package:flutter_survey_app_mobile/config/localization/app_languages.dart';
import 'package:flutter_survey_app_mobile/core/utils/image_enum.dart';

@immutable
final class LocaleConstants {
  const LocaleConstants._();
  static const trLocale = Locale('tr', 'TR');
  static const enLocale = Locale('en', 'US');
  static const frLocale = Locale('fr', 'FR');
  static const arLocale = Locale('ar', 'AR');
  static const esLocale = Locale('es', 'ES');
  static const deLocale = Locale('de', 'DE');
  static const itLocale = Locale('it', 'IT');
  static const ptLocale = Locale('pt', 'BR');
  static const zhLocale = Locale('zh', 'CN');
  static const jaLocale = Locale('ja', 'JP');
  static const ruLocale = Locale('ru', 'RU');
  static const localePath = 'assets/lang';

  static final List<AppLanguages> languageList = [
    AppLanguages(
      name: 'Türkçe',
      locale: trLocale,
      flagName: ImageEnums.flag_turkey.toPathPng,
    ),
    AppLanguages(
      name: 'English',
      locale: enLocale,
      flagName: ImageEnums.flag_usa.toPathPng,
    ),
    AppLanguages(
      name: 'العربية',
      locale: arLocale,
      flagName: ImageEnums.flag_saudi_arabia.toPathPng,
    ),
    AppLanguages(
      name: 'Español',
      locale: esLocale,
      flagName: ImageEnums.flag_spain.toPathPng,
    ),
    AppLanguages(
      name: 'Français',
      locale: frLocale,
      flagName: ImageEnums.flag_france.toPathPng,
    ),
    AppLanguages(
        name: 'Deutsch',
        locale: deLocale,
        flagName: ImageEnums.flag_germany.toPathPng),
    AppLanguages(
      name: 'Italiano',
      locale: itLocale,
      flagName: ImageEnums.flag_italy.toPathPng,
    ),
    AppLanguages(
      name: 'Português',
      locale: ptLocale,
      flagName: ImageEnums.flag_brazil.toPathPng,
    ),
    AppLanguages(
      name: 'русский',
      locale: ruLocale,
      flagName: ImageEnums.flag_russia.toPathPng,
    ),
    AppLanguages(
      name: '中文',
      locale: zhLocale,
      flagName: ImageEnums.flag_china.toPathPng,
    ),
    AppLanguages(
      name: '日本語',
      locale: jaLocale,
      flagName: ImageEnums.flag_japan.toPathPng,
    ),
  ];
}
