enum FirebaseCollectionEnum {
  version,
  surveys,
  questions,
  deneme,
  test,
  user;

  String getQuestionsPath({required String surveyId}) {
    if (this == FirebaseCollectionEnum.surveys) {
      return '$name/$surveyId/${FirebaseCollectionEnum.questions.name}';
    }
    throw Exception(
      "Questions path can only be accessed from the 'surveys' collection.",
    );
  }
}
