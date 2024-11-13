import 'package:flutter/material.dart';
import 'package:flutter_survey_app_mobile/core/base/state.dart';
import 'package:flutter_survey_app_mobile/feature/home/domain/usecase/get_published_survey_ids_usecase.dart';
import 'package:flutter_survey_app_mobile/feature/home/domain/usecase/get_published_surveys_usecase.dart';
import 'package:flutter_survey_app_mobile/feature/shared_layers/domain/entity/survey_entity.dart';

class HomeViewModel extends ChangeNotifier {
  final GetPublishedSurveysUsecase getSurveysUseCase;
  final GetPublishedSurveyIdsUsecase getSurveyIdsUsecase;
  HomeViewModel({
    required this.getSurveyIdsUsecase,
    required this.getSurveysUseCase,
  });
  List<SurveyEntity> publishedSurveys = [];
  ViewState _state = ViewState.inActive;
  ViewState get state => _state;

  /// SETS THE CURRENT STATE OF THE VIEW MODEL AND NOTIFIES LISTENERS
  void setState(ViewState state) {
    _state = state;
    notifyListeners();
  }

  /// USED TO GET PUBLISHED SURVEY IDS
  Future<void> getSurveyIds({
    required String userId,
  }) async {
    final result = await getSurveyIdsUsecase.call(userId: userId);
    await result.fold(
      (fail) {},
      (succes) async {
        await getSurveys(surveyIds: succes);
      },
    );
    setState(ViewState.success);
  }

  /// USED TO GET PUBLISHED SURVEYS FROM  IDS
  Future<void> getSurveys({required List<String>? surveyIds}) async {
    final result = await getSurveysUseCase.call(surveyIds: surveyIds);
    result.fold(
      (fail) {},
      (succes) {
        publishedSurveys = succes;
        notifyListeners();
      },
    );
  }
}
