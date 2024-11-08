import 'package:flutter/foundation.dart';
import 'package:flutter_survey_app_mobile/core/base/state.dart';
import 'package:flutter_survey_app_mobile/core/connection/network_info.dart';
import 'package:flutter_survey_app_mobile/core/error/failure.dart';
import 'package:flutter_survey_app_mobile/feature/create_survey/domain/usecase/cache_datas_no_internet_use_case.dart';
import 'package:flutter_survey_app_mobile/feature/create_survey/presentation/viewmodel/survey_logic.dart';
import 'package:flutter_survey_app_mobile/feature/image_process/helper/image_helper.dart';
import 'package:flutter_survey_app_mobile/feature/shared_layers/domain/entity/question_entity.dart';
import 'package:flutter_survey_app_mobile/feature/shared_layers/domain/entity/survey_entity.dart';
import 'package:flutter_survey_app_mobile/feature/shared_layers/domain/entity/survey_entity_extension.dart';
import 'package:flutter_survey_app_mobile/product/constants/image_aspect_ratio.dart';
import 'package:flutter_survey_app_mobile/product/helper/link_sharing_helper.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';

class CreateSurveyViewModel extends ChangeNotifier {
  final CacheDatasNoInternetUseCase cacheDatasNoInternetUseCase;
  final INetworkInfo connectivity;
  final ImageHelper imageHelper;
  final SurveyLogic surveyLogic;
  final LinkSharingHelper shareLink;

  CreateSurveyViewModel({
    required this.cacheDatasNoInternetUseCase,
    required this.connectivity,
    required this.imageHelper,
    required this.surveyLogic,
    required this.shareLink,
  });

  ViewState _state = ViewState.inActive;
  ViewState get state => _state;

  SurveyEntity _surveyEntity = SurveyEntity(
    userId: '1234567',
    surveyId: const Uuid().v1(),
  );
  SurveyEntity get surveyEntity => _surveyEntity;

  Uint8List? selectedSurveyImageBytes;
  Map<QuestionEntity, Uint8List?> _questionEntityMap = {};
  Map<QuestionEntity, Uint8List?> get questionEntityMap => _questionEntityMap;
  Uint8List? selectedQuestionFileBytes;
  bool isSnackBarShown = false;

  /// Sets the current state of the view model and notifies listeners.
  void setState(ViewState state) {
    _state = state;
    notifyListeners();
  }

  /// Resets the ViewModel state and survey data for a fresh start.
  void resetViewModel() {
    _surveyEntity = SurveyEntity(
      userId: const Uuid().v1(),
      surveyId: const Uuid().v1(),
    );
    _questionEntityMap = {};
    selectedSurveyImageBytes = null;
    setState(ViewState.inActive);
    notifyListeners();
  }

  /// Sets survey information such as title, description, and dates.
  void setSurveyInfos({
    required String surveyTitle,
    required String surveyDescription,
    required DateTime? startDate,
    required DateTime? endDate,
    required int? surveyTimeInMinute,
  }) {
    _surveyEntity = surveyEntity.copyWith(
      surveyTitle: surveyTitle,
      surveyDescription: surveyDescription,
      startDate: startDate,
      endDate: endDate,
      surveyTimeInMinute: surveyTimeInMinute,
    );
    notifyListeners();
  }

  /// Resets the selected survey image, removing it from memory.
  void resetSurveyImage() {
    selectedSurveyImageBytes = null;
    notifyListeners();
  }

  /// Selects and crops an image for the survey or question, based on provided aspect ratio.
  Future<void> getImage({
    required ImageSource selectedSource,
    required CropAspectRatio cropRatio,
  }) async {
    final result = await imageHelper.getImage(
      selectedSource: selectedSource,
      cropRatio: cropRatio,
    );
    if (result != null) {
      if (cropRatio == ImageAspectRatioEnum.surveyImage.ratioCrop) {
        selectedSurveyImageBytes = await result.readAsBytes();
        notifyListeners();
      } else {
        selectedQuestionFileBytes = await result.readAsBytes();
        notifyListeners();
      }
    }
  }

  /// Adds a new question with an optional image.
  void addNewQuestion({
    required QuestionEntity entity,
    required Uint8List? selectedQuestionFileBytes,
  }) {
    _questionEntityMap[entity] = selectedQuestionFileBytes;
    notifyListeners();
  }

  /// Resets the selected question image, removing it from memory.
  void resetQuestionImage() {
    selectedQuestionFileBytes = null;
    notifyListeners();
  }

  /// Deletes a question from the survey.
  void deleteQuestionEntity(QuestionEntity entity) {
    if (_questionEntityMap.containsKey(entity)) {
      _questionEntityMap.remove(entity);
      notifyListeners();
    }
  }

  /// Initiates the survey sharing process; if successful, updates the state accordingly.
  Future<void> shareSurvey() async {
    if (_questionEntityMap.isNotEmpty && state != ViewState.error) {
      setState(ViewState.loading);
      Failure? fail;
      final result = await surveyLogic.shareSurvey(
        surveyEntity: _surveyEntity,
        selectedSurveyImageBytes: selectedSurveyImageBytes,
        questionEntityMap: _questionEntityMap,
      );
      result.fold(
        (failure) {
          fail = failure;
        },
        (success) {
          setState(ViewState.success);
        },
      );
      if (fail != null) {
        await _rollbackSurvey(fail: fail!);
      }
    } else {
      if (state != ViewState.error) {
        isSnackBarShown = true;
        setState(ViewState.noAddedQuestion);
      }
    }
  }

  /// Shares the survey link via the selected link sharing helper.
  void shareSurveyLink() {
    if (_surveyEntity.surveyId != null) {
      shareLink.shareSurveyLink(surveyId: _surveyEntity.surveyId!);
    } else {
      setState(ViewState.error);
    }
  }

  /// Generates a link for accessing the survey.
  String getSurveyLink() {
    if (_surveyEntity.surveyId != null) {
      return shareLink.generateSurveyLink(_surveyEntity.surveyId!);
    } else {
      setState(ViewState.error);
      return '';
    }
  }

  /// Rolls back survey creation in case of a failure.
  Future<void> _rollbackSurvey({required Failure fail}) async {
    await _cacheSurveyDatas();
    if (fail is ConnectionFailure) {
      setState(ViewState.noInternet);
    } else if (fail is ServerFailure) {
      setState(ViewState.error);
      await imageHelper.removeSurveyImages(
        surveyId: _surveyEntity.surveyId,
        userId: _surveyEntity.userId,
      );
      await surveyLogic.removeSurvey(surveyId: _surveyEntity.surveyId);
    }
  }

  /// Checks the current network connectivity status.
  Future<void> checkConnectivity() async {
    setState(ViewState.loading);
    final result = await connectivity.currentConnectivityResult;
    if (result) {
      setState(ViewState.inActive);
    } else {
      setState(ViewState.noInternet);
    }
  }

  /// Caches survey data for offline access.
  Future<void> _cacheSurveyDatas() async {
    if (_surveyEntity.surveyId == null) return;
    await cacheDatasNoInternetUseCase.call(
      path: _surveyEntity.surveyPath,
      surveyId: _surveyEntity.surveyId!,
    );
  }
}
