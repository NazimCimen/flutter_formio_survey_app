import 'package:flutter/material.dart';
import 'package:flutter_survey_app/feature/settings/presentation/view/settings_view.dart';
import 'package:flutter_survey_app/feature/shared_layers/domain/entity/question_entity.dart';
import 'package:flutter_survey_app/feature/create_survey/presentation/view/add_question_view.dart';
import 'package:flutter_survey_app/feature/create_survey/presentation/view/create_questions_view.dart';
import 'package:flutter_survey_app/feature/create_survey/presentation/view/create_survey_info_view.dart';
import 'package:flutter_survey_app/feature/home/presentation/view/home_view.dart';
import 'package:flutter_survey_app/feature/nav_bar/view/nav_bar_view.dart';
import 'package:flutter_survey_app/feature/profile/presentation/view/profile_view.dart';

class AppRoutes {
  static const String initialRoute = '/navBarView';
  static const String homeView = '/homeView';
  static const String navBarView = '/navBarView';
  static const String profileView = '/profileView';
  static const String createSurveyInfoView = '/createSurveyInfoView';
  static const String createQuestionsView = '/createQuestionsView';
  static const String addQuestionView = '/addQuestionView';
  static const String settingsView = '/settingsView';

  static Map<String, WidgetBuilder> get routes => {
        initialRoute: (context) => const NavBarView(),
        createSurveyInfoView: (context) => const CreateSurveyInfoView(),
        createQuestionsView: (context) => const CreateQuestionsView(),
        addQuestionView: (context) {
          final questionEntity =
              ModalRoute.of(context)!.settings.arguments! as QuestionEntity;
          return AddQuestionView(entity: questionEntity);
        },
        homeView: (context) => const HomeView(),
        profileView: (context) => const ProfileView(),
        settingsView: (context) => const SettingsView(),
      };
}
