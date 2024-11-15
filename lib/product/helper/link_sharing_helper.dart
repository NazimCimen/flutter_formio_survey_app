import 'package:flutter_survey_app_mobile/config/localization/string_constants.dart';
import 'package:share_plus/share_plus.dart';

abstract class LinkSharingHelper {
  void shareSurveyLink({required String surveyId});
  String generateSurveyLink(String surveyId);
}

class LinkSharingHelperImpl extends LinkSharingHelper {
  @override
  void shareSurveyLink({required String surveyId}) {
    final link = generateSurveyLink(surveyId);
    Share.share(
      '${StringConstants.survey_share_menu_title}: $link',
    );
  }

  @override
  String generateSurveyLink(String surveyId) {
    return 'https://formio-90f75.web.app/answer-survey?surveyId=$surveyId';
  }
}
