import 'package:flutter/material.dart';
import 'package:flutter_survey_app_mobile/config/localization/string_constants.dart';
import 'package:image_cropper/image_cropper.dart';

class CropperUiSettings {
  static AndroidUiSettings getAndroidUiSettings() {
    return AndroidUiSettings(
      toolbarTitle: StringConstants.crop_bar_title,
      toolbarColor: const Color(
        0xFF202E3B,
      ),
      statusBarColor: const Color(
        0xFF202E3B,
      ),
      toolbarWidgetColor: const Color(0xff00C9FF),
      backgroundColor: Colors.black,
      activeControlsWidgetColor: const Color(0xff00C9FF),
      cropFrameColor: const Color(0xff00C9FF),
      cropGridColor: Colors.white70,
      initAspectRatio: CropAspectRatioPreset.square,
      lockAspectRatio: true,
      showCropGrid: true,
      aspectRatioPresets: [
        CropAspectRatioPreset.ratio5x4,
        CropAspectRatioPreset.ratio16x9,
      ],
    );
  }

  // iOS UI ayarları
  static IOSUiSettings getIosUiSettings() {
    return IOSUiSettings(
      title: StringConstants.crop_bar_title,
      aspectRatioLockEnabled: true,
      aspectRatioPresets: [
        CropAspectRatioPreset.ratio5x4,
        CropAspectRatioPreset.ratio16x9,
      ],
    );
  }
}
