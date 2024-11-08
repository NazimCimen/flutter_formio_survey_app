import 'package:flutter/material.dart';
import 'package:flutter_survey_app_mobile/config/routes/app_routes.dart';
import 'package:flutter_survey_app_mobile/feature/create_survey/presentation/view/create_questions_view.dart';

@immutable
final class NavigatorService {
  const NavigatorService._();
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  static Future<dynamic> pushNamed(
    String routeName, {
    dynamic arguments,
    bool withAnimation = false,
  }) async {
    if (withAnimation) {
      return navigatorKey.currentState
          ?.push(_createRoute(routeName, arguments));
    } else {
      return navigatorKey.currentState
          ?.pushNamed(routeName, arguments: arguments);
    }
  }

  static void goBack() {
    return navigatorKey.currentState?.pop();
  }

  static Future<dynamic> pushNamedAndRemoveUntil(
    String routeName, {
    bool routePredicate = false,
    dynamic arguments,
  }) async {
    return navigatorKey.currentState?.pushNamedAndRemoveUntil(
      routeName,
      (route) => routePredicate,
      arguments: arguments,
    );
  }

  static Future<dynamic> popAndPushNamed(
    String routeName, {
    dynamic arguments,
  }) async {
    return navigatorKey.currentState
        ?.popAndPushNamed(routeName, arguments: arguments);
  }

  static PageRouteBuilder<dynamic> _createRoute(
    String routeName,
    dynamic arguments,
  ) {
    return PageRouteBuilder(
      settings: RouteSettings(name: routeName, arguments: arguments),
      pageBuilder: (context, animation, secondaryAnimation) {
        Widget page;
        switch (routeName) {
          case AppRoutes.createQuestionsView:
            page = const CreateQuestionsView();
          default:
            page = const Scaffold();
        }
        return page;
      },
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(1, 0);
        const end = Offset.zero;
        const curve = Curves.easeInOut;

        final tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
        final offsetAnimation = animation.drive(tween);

        return SlideTransition(
          position: offsetAnimation,
          child: child,
        );
      },
    );
  }

  static void handleDeepLink(String url) {
    final uri = Uri.parse(url);
    final surveyId = uri.queryParameters['surveyId'];

    if (surveyId != null) {
      navigatorKey.currentState?.pushNamed(
        AppRoutes.answerSurveyView,
        arguments: surveyId,
      );
    } else {
      navigatorKey.currentState?.pushNamed(AppRoutes.homeView);
    }
  }
}
