enum ImageEnums {
  bg_home_no_survey,
  success,
  app_logo,
  no_internet,
  add_image,
  bg_default_survey,
  flag_turkey,
  flag_saudi_arabia,
  flag_usa,
  flag_spain,
  flag_germany,
  flag_france,
  flag_japan,
  flag_china,
  flag_russia,
  flag_brazil,
  flag_italy,
}

extension AssetExtension on ImageEnums {
  String get toPathPng => 'assets/images/$name.png';
}
