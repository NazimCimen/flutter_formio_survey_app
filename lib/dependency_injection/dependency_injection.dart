import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_survey_app/core/cache/cache_enum.dart';
import 'package:flutter_survey_app/core/cache/cache_manager/base_cache_manager.dart';
import 'package:flutter_survey_app/core/cache/cache_manager/encrypted_cache_manager.dart';
import 'package:flutter_survey_app/core/cache/cache_manager/standart_cache_manager.dart';
import 'package:flutter_survey_app/core/cache/encryption/encryption_service.dart';
import 'package:flutter_survey_app/core/cache/encryption/secure_encryption_key_manager.dart';
import 'package:flutter_survey_app/core/connection/network_info.dart';
import 'package:flutter_survey_app/feature/create_survey/domain/usecase/cache_datas_no_internet_use_case.dart';
import 'package:flutter_survey_app/feature/create_survey/domain/usecase/remove_survey_use_case.dart';
import 'package:flutter_survey_app/feature/create_survey/presentation/viewmodel/survey_logic.dart';
import 'package:flutter_survey_app/feature/image_process/data/data_source/image_process_local_source.dart';
import 'package:flutter_survey_app/feature/image_process/data/data_source/image_process_remote_source.dart';
import 'package:flutter_survey_app/feature/image_process/data/repository/image_process_repository_impl.dart';
import 'package:flutter_survey_app/feature/image_process/domain/repository/image_process_repository.dart';
import 'package:flutter_survey_app/feature/image_process/helper/image_helper.dart';
import 'package:flutter_survey_app/feature/shared_layers/data/model/question_model.dart';
import 'package:flutter_survey_app/feature/shared_layers/data/model/survey_model.dart';
import 'package:flutter_survey_app/feature/create_survey/data/data_source/create_survey_local_data_source.dart';
import 'package:flutter_survey_app/feature/create_survey/data/data_source/create_survey_remote_data_source.dart';
import 'package:flutter_survey_app/feature/create_survey/data/repository/create_survey_repository_impl.dart';
import 'package:flutter_survey_app/feature/create_survey/domain/repository/create_survey_repository.dart';
import 'package:flutter_survey_app/feature/image_process/domain/usecase/crop_image_use_case.dart';
import 'package:flutter_survey_app/feature/image_process/domain/usecase/get_image_file_use_case.dart';
import 'package:flutter_survey_app/feature/image_process/domain/usecase/get_image_url_use_case.dart';
import 'package:flutter_survey_app/feature/image_process/domain/usecase/remove_survey_images_use_case.dart';
import 'package:flutter_survey_app/feature/create_survey/domain/usecase/share_questions_use_case.dart';
import 'package:flutter_survey_app/feature/create_survey/domain/usecase/share_survey_info_use_case.dart';
import 'package:flutter_survey_app/feature/create_survey/presentation/viewmodel/create_survey_view_model.dart';
import 'package:flutter_survey_app/product/firebase/firebase_converter.dart';

import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';

final serviceLocator = GetIt.instance;
void setupLocator() {
  serviceLocator
    ..registerLazySingleton<FirebaseFirestore>(
      () => FirebaseFirestore.instance,
    )
    ..registerLazySingleton<FirebaseStorage>(
      () => FirebaseStorage.instance,
    )
    ..registerSingletonAsync<SharedPreferences>(
      () async => SharedPreferences.getInstance(),
    )
    ..registerLazySingleton<SecureEncryptionKeyManager>(
      () => SecureEncryptionKeyManager(),
    )
    ..registerLazySingleton<BaseEncryptionService>(
      () => AESEncryptionService(
        serviceLocator<SecureEncryptionKeyManager>(),
      ),
    )
    ..registerLazySingleton<StandartCacheManager<String>>(
      () => StandartCacheManager<String>(
        boxName: CacheHiveBoxEnum.removeSurvey.name,
      ),
    )
    ..registerLazySingleton<InternetConnectionChecker>(
        () => InternetConnectionChecker())
    ..registerLazySingleton<INetworkInfo>(
      () => NetworkInfo(serviceLocator<InternetConnectionChecker>()),
    )
    ..registerLazySingleton<CreateSurveyLocalDataSource>(
      () => CreateSurveyLocalDataSourceImpl(
        cacheManager: serviceLocator<StandartCacheManager<String>>(),
      ),
    )
    ..registerLazySingleton<SurveyModel>(
      () => const SurveyModel(),
    )
    ..registerLazySingleton<QuestionModel>(
      () => const QuestionModel(),
    )
    ..registerLazySingleton<FirebaseConverter<SurveyModel>>(
      () => FirebaseConverter<SurveyModel>(
        model: serviceLocator<SurveyModel>(),
        firestore: serviceLocator<FirebaseFirestore>(),
      ),
    )
    ..registerLazySingleton<FirebaseConverter<QuestionModel>>(
      () => FirebaseConverter<QuestionModel>(
        model: serviceLocator<QuestionModel>(),
        firestore: serviceLocator<FirebaseFirestore>(),
      ),
    )
    ..registerLazySingleton<CreateSurveyRemoteDataSource>(
      () => CreateSurveyRemoteDataSourceImpl(
        storage: serviceLocator<FirebaseStorage>(),
        surveyFirebaseConverter:
            serviceLocator<FirebaseConverter<SurveyModel>>(),
        questionFirebaseConverter:
            serviceLocator<FirebaseConverter<QuestionModel>>(),
        connectivity: serviceLocator<INetworkInfo>(),
      ),
    )
    ..registerLazySingleton<CreateSurveyRepository>(
      () => CreateSurveyRepositoryImpl(
        connectivity: serviceLocator<INetworkInfo>(),
        localDataSource: serviceLocator<CreateSurveyLocalDataSource>(),
        remoteDataSource: serviceLocator<CreateSurveyRemoteDataSource>(),
      ),
    )
    ..registerLazySingleton<ShareQuestionsUseCase>(
      () => ShareQuestionsUseCase(
        repository: serviceLocator<CreateSurveyRepository>(),
      ),
    )
    ..registerLazySingleton<ShareSurveyInfoUseCase>(
      () => ShareSurveyInfoUseCase(
        repository: serviceLocator<CreateSurveyRepository>(),
      ),
    )
    ..registerLazySingleton<RemoveSurveyImagesUseCase>(
      () => RemoveSurveyImagesUseCase(
        repository: serviceLocator<ImageProcessRepository>(),
      ),
    )
    ..registerLazySingleton<RemoveSurveyUseCase>(
      () => RemoveSurveyUseCase(
        repository: serviceLocator<CreateSurveyRepository>(),
      ),
    )
    ..registerLazySingleton<CacheDatasNoInternetUseCase>(
      () => CacheDatasNoInternetUseCase(
        repository: serviceLocator<CreateSurveyRepository>(),
      ),
    )
    ..registerLazySingleton<SurveyLogic>(
      () => SurveyLogic(
        imageHelper: serviceLocator<ImageHelper>(),
        removeSurveyUseCase: serviceLocator<RemoveSurveyUseCase>(),
        shareSurveyInfoUseCase: serviceLocator<ShareSurveyInfoUseCase>(),
        shareQuestionsUseCase: serviceLocator<ShareQuestionsUseCase>(),
      ),
    )
    ..registerLazySingleton<CreateSurveyViewModel>(
      () => CreateSurveyViewModel(
        cacheDatasNoInternetUseCase:
            serviceLocator<CacheDatasNoInternetUseCase>(),
        connectivity: serviceLocator<INetworkInfo>(),
        imageHelper: serviceLocator<ImageHelper>(),
        surveyLogic: serviceLocator<SurveyLogic>(),
      ),
    ) //////////////////////////////////////////////////////////////////////////
    ..registerLazySingleton<ImageProcessRemoteSource>(
      () => ImageProcessRemoteSourceImpl(
        storage: serviceLocator<FirebaseStorage>(),
        connectivity: serviceLocator<INetworkInfo>(),
      ),
    )
    ..registerLazySingleton<ImageProcessLocalSource>(
      () => ImageProcessLocalSourceImpl(),
    )
    ..registerLazySingleton<ImageProcessRepository>(
      () => ImageProcessRepositoryImpl(
        localDataSource: serviceLocator<ImageProcessLocalSource>(),
        remoteDataSource: serviceLocator<ImageProcessRemoteSource>(),
      ),
    )
    ..registerLazySingleton<GetImageUrlUseCase>(
      () => GetImageUrlUseCase(
          repository: serviceLocator<ImageProcessRepository>()),
    )
    ..registerLazySingleton<GetImageFileUseCase>(
      () => GetImageFileUseCase(
          repository: serviceLocator<ImageProcessRepository>()),
    )
    ..registerLazySingleton<CropImageUseCase>(
      () => CropImageUseCase(
        repository: serviceLocator<ImageProcessRepository>(),
      ),
    )
    ..registerLazySingleton<ImageHelper>(
      () => ImageHelper(
        cropImageUseCase: serviceLocator<CropImageUseCase>(),
        getImageUrlUseCase: serviceLocator<GetImageUrlUseCase>(),
        getImageUseCase: serviceLocator<GetImageFileUseCase>(),
        removeSurveyImagesUseCase: serviceLocator<RemoveSurveyImagesUseCase>(),
      ),
    );
  //////////////////////////////////////////////////////////////////////////;
}
