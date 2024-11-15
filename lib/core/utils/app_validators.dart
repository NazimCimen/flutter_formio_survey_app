import 'package:flutter/foundation.dart';
import 'package:flutter_survey_app_mobile/config/localization/string_constants.dart';
import 'package:intl/intl.dart';

@immutable
final class AppValidators {
  const AppValidators._();

  static const String emailRegExp =
      r'^[^<>()\[\]\\.,;:\s@\"]+(\.[^<>()\[\]\\.,;:\s@\"]+)*|(\".+\")@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
  static const String passwordRegExp =
      r'^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{6,}$';
  static const String usernameRegExp = r'^[a-zA-Z0-9_]{3,10}$';

  static String? emailValidator(String? value) {
    if (value == null || value.isEmpty) {
      return StringConstants.valid_mail1;
    }
    final validateEmail = RegExp(emailRegExp);
    if (!validateEmail.hasMatch(value)) {
      return StringConstants.valid_mail2;
    }
    return null;
  }

  static String? passwordValidator(String? value) {
    if (value == null || value.isEmpty) {
      return StringConstants.valid_password1;
    } else if (value.length < 6) {
      return StringConstants.valid_password2;
    } else {
      final validatePassword = RegExp(passwordRegExp);
      if (!validatePassword.hasMatch(value)) {
        return StringConstants.valid_password3;
      }
    }
    return null;
  }

  static String? usernameValidator(String? value) {
    if (value == null || value.isEmpty) {
      return StringConstants.valid_username1;
    } else if (value.length < 3 || value.length > 10) {
      return StringConstants.valid_username2;
    } else {
      final validateUsername = RegExp(usernameRegExp);
      if (!validateUsername.hasMatch(value)) {
        return StringConstants.valid_username3;
      }
    }
    return null;
  }

  static String? surveyTitleValidator(String? value) {
    if (value == null || value.isEmpty) {
      return StringConstants.valid_survey_title1;
    } else if (value.length > 50) {
      return StringConstants.valid_survey_title2;
    }
    return null;
  }

  static String? surveyDescriptionValidator(String? value) {
    if (value == null || value.isEmpty) {
      return StringConstants.valid_survey_desc1;
    } else if (value.length > 200) {
      return StringConstants.valid_survey_desc2;
    }
    return null;
  }

  static String? startDateValidator(String? value) {
    if (value == null || value.isEmpty) {
      return StringConstants.valid_survey_startdate1;
    }
    if (!_isValidDateFormat(value, 'yyyy-MM-dd')) {
      return StringConstants.valid_survey_startdate2;
    }
    return null;
  }

  static String? endDateValidator(String? value) {
    if (value == null || value.isEmpty) {
      return StringConstants.valid_survey_enddate1;
    }
    if (!_isValidDateFormat(value, 'yyyy-MM-dd')) {
      return StringConstants.valid_survey_enddate2;
    }
    return null;
  }

  static bool _isValidDateFormat(String value, String format) {
    try {
      DateFormat(format).parseStrict(value);
      return true;
    } catch (e) {
      return false;
    }
  }

  static String? durationInMinuteValidator(String? value) {
    if (value == null || value.isEmpty) {
      return null;
    }
    final minutes = int.tryParse(value);
    if (minutes == null) {
      return StringConstants.valid_survey_minute;
    }
    return null;
  }
}
