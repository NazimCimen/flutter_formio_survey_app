import 'package:flutter/material.dart';
import 'package:flutter_survey_app_mobile/config/routes/app_routes.dart';
import 'package:flutter_survey_app_mobile/config/routes/navigator_service.dart';
import 'package:flutter_survey_app_mobile/feature/splash/presentation/view/splash_view.dart';
import 'package:flutter_survey_app_mobile/feature/splash/presentation/viewmodel/splash_view_model.dart';
import 'package:flutter_survey_app_mobile/product/componets/custom_dialogs.dart';
import 'package:get_it/get_it.dart';

mixin SplashMixin on State<SplashView> {
  late final SplashViewModel _viewModel;

  @override
  void initState() {
    super.initState();
    _viewModel = GetIt.instance<SplashViewModel>();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final onboardVisibility = await _viewModel.checkOnboardShown();
      final devicePlatform = _viewModel.getDevicePlatform();
      final appDatabaseVersionNumber = await _viewModel.getAppDatabaseVersion(
        devicePlatform: devicePlatform,
      );
      final appDeviceVersionNumber =
          await _viewModel.getDeviceAppVersionNumber();
      final isForceUpdate = await _viewModel.checkForceUpdate(
        appDatabaseVersionNumber,
        appDeviceVersionNumber,
      );
      _navigateFromSplash(
        isForceUpdate: isForceUpdate,
        onboardScreenVisible: onboardVisibility,
      );
    });
  }

  void _navigateFromSplash({
    required bool onboardScreenVisible,
    required bool isForceUpdate,
  }) {
    if (isForceUpdate) {
      CustomDialogs.showCustomDialog(
        context: context,
        title: 'Yeni Bir Güncelleme Sizi Bekliyor!',
        description:
            'En yeni özellikler ve iyileştirmelerle deneyiminizi bir üst seviyeye taşıdık. Devam edebilmek için lütfen uygulamanızı güncelleyin.',
        refresh: null,
        imagePath: null,
      );
    } else {
      onboardScreenVisible
          ? NavigatorService.pushNamedAndRemoveUntil(AppRoutes.homeView)
          : NavigatorService.pushNamedAndRemoveUntil(AppRoutes.homeView);
    }
  }
}
