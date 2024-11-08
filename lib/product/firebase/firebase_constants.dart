class FirebaseConstants {
  FirebaseConstants._();
  static const String defaultSurveyImageUrl =
      'https://firebasestorage.googleapis.com/v0/b/flutter-recipe-app-af800.appspot.com/o/YUMMY.png?alt=media&token=d151d7da-aa1b-48d7-a25b-92089075b3cc';
  static const String defaultSurveyStepImageUrl =
      'https://firebasestorage.googleapis.com/v0/b/flutter-recipe-app-af800.appspot.com/o/YUMMY.png?alt=media&token=d151d7da-aa1b-48d7-a25b-92089075b3cc';
}

enum FirebasePaths {
  userSurvey;

  String getPath({required String userId, required String surveyId}) {
    switch (this) {
      case FirebasePaths.userSurvey:
        return 'user/$userId/survey/$surveyId/';
    }
  }
}
