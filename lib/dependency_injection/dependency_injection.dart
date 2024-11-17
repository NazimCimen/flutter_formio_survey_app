import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_survey_app_mobile/config/theme/theme_manager.dart';
import 'package:flutter_survey_app_mobile/core/app/app_version_manager.dart';
import 'package:flutter_survey_app_mobile/core/cache/cache_enum.dart';
import 'package:flutter_survey_app_mobile/core/cache/cache_manager/standart_cache_manager.dart';
import 'package:flutter_survey_app_mobile/core/cache/encryption/encryption_service.dart';
import 'package:flutter_survey_app_mobile/core/cache/encryption/secure_encryption_key_manager.dart';
import 'package:flutter_survey_app_mobile/core/connection/network_info.dart';
import 'package:flutter_survey_app_mobile/feature/create_survey/domain/usecase/cache_datas_no_internet_use_case.dart';
import 'package:flutter_survey_app_mobile/feature/create_survey/domain/usecase/remove_survey_use_case.dart';
import 'package:flutter_survey_app_mobile/feature/create_survey/presentation/viewmodel/survey_logic.dart';
import 'package:flutter_survey_app_mobile/feature/home/data/data_source/home_remote_data_source.dart';
import 'package:flutter_survey_app_mobile/feature/home/data/repository/home_repository_impl.dart';
import 'package:flutter_survey_app_mobile/feature/home/domain/repository/home_repository.dart';
import 'package:flutter_survey_app_mobile/feature/home/domain/usecase/get_published_survey_ids_usecase.dart';
import 'package:flutter_survey_app_mobile/feature/home/domain/usecase/get_published_surveys_usecase.dart';
import 'package:flutter_survey_app_mobile/feature/home/presentation/viewmodel/home_view_model.dart';
import 'package:flutter_survey_app_mobile/feature/image_process/data/data_source/image_process_local_source.dart';
import 'package:flutter_survey_app_mobile/feature/image_process/data/data_source/image_process_remote_source.dart';
import 'package:flutter_survey_app_mobile/feature/image_process/data/repository/image_process_repository_impl.dart';
import 'package:flutter_survey_app_mobile/feature/image_process/domain/repository/image_process_repository.dart';
import 'package:flutter_survey_app_mobile/feature/image_process/helper/image_helper.dart';
import 'package:flutter_survey_app_mobile/feature/shared_layers/data/model/question_model.dart';
import 'package:flutter_survey_app_mobile/feature/shared_layers/data/model/survey_model.dart';
import 'package:flutter_survey_app_mobile/feature/create_survey/data/data_source/create_survey_local_data_source.dart';
import 'package:flutter_survey_app_mobile/feature/create_survey/data/data_source/create_survey_remote_data_source.dart';
import 'package:flutter_survey_app_mobile/feature/create_survey/data/repository/create_survey_repository_impl.dart';
import 'package:flutter_survey_app_mobile/feature/create_survey/domain/repository/create_survey_repository.dart';
import 'package:flutter_survey_app_mobile/feature/image_process/domain/usecase/crop_image_use_case.dart';
import 'package:flutter_survey_app_mobile/feature/image_process/domain/usecase/get_image_file_use_case.dart';
import 'package:flutter_survey_app_mobile/feature/image_process/domain/usecase/get_image_url_use_case.dart';
import 'package:flutter_survey_app_mobile/feature/image_process/domain/usecase/remove_survey_images_use_case.dart';
import 'package:flutter_survey_app_mobile/feature/create_survey/domain/usecase/share_questions_use_case.dart';
import 'package:flutter_survey_app_mobile/feature/create_survey/domain/usecase/share_survey_info_use_case.dart';
import 'package:flutter_survey_app_mobile/feature/create_survey/presentation/viewmodel/create_survey_view_model.dart';
import 'package:flutter_survey_app_mobile/feature/shared_layers/data/model/user_model.dart';
import 'package:flutter_survey_app_mobile/feature/splash/data/data_source/splash_local_data_source.dart';
import 'package:flutter_survey_app_mobile/feature/splash/data/data_source/splash_remote_data_source.dart';
import 'package:flutter_survey_app_mobile/feature/splash/data/model/app_version_model.dart';
import 'package:flutter_survey_app_mobile/feature/splash/data/repository/splash_repository_impl.dart';
import 'package:flutter_survey_app_mobile/feature/splash/domain/repository/splash_repository.dart';
import 'package:flutter_survey_app_mobile/feature/splash/domain/usecase/check_cache_onboard_shown_use_case.dart';
import 'package:flutter_survey_app_mobile/feature/splash/domain/usecase/get_app_database_version_number_use_case.dart';
import 'package:flutter_survey_app_mobile/feature/splash/presentation/viewmodel/splash_view_model.dart';
import 'package:flutter_survey_app_mobile/product/firebase/service/base_firebase_service.dart';
import 'package:flutter_survey_app_mobile/product/firebase/service/firebase_service_impl.dart';
import 'package:flutter_survey_app_mobile/product/helper/link_sharing_helper.dart';

import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';

final serviceLocator = GetIt.instance;
void setupLocator() {
  serviceLocator
    ..registerLazySingleton<ThemeManager>(() => ThemeManager())
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
      () => InternetConnectionChecker(),
    )
    ..registerLazySingleton<INetworkInfo>(
      () => NetworkInfo(serviceLocator<InternetConnectionChecker>()),
    )
    ..registerLazySingleton<AppVersionManager>(
      () => AppVersionManagerImpl(),
    )
    ..registerLazySingleton<BaseFirebaseService<AppVersionModel>>(
      () => FirebaseServiceImpl(
        firestore: serviceLocator<FirebaseFirestore>(),
      ),
    )
    ..registerLazySingleton<GetAppDatabaseVersionNumberUseCase>(
      () => GetAppDatabaseVersionNumberUseCase(
        serviceLocator<SplashRepository>(),
      ),
    )
    ..registerLazySingleton<SplashLocalDataSource>(
      () => SplashLocalDataSourceImpl(serviceLocator<SharedPreferences>()),
    )
    ..registerLazySingleton<SplashRemoteDataSource>(
      () => SplashRemoteDataSourceImpl(
        serviceLocator<FirebaseFirestore>(),
        serviceLocator<INetworkInfo>(),
        serviceLocator<BaseFirebaseService<AppVersionModel>>(),
      ),
    )
    ..registerLazySingleton<SplashRepository>(
      () => SplashRepositoryImpl(
        serviceLocator<SplashLocalDataSource>(),
        serviceLocator<SplashRemoteDataSource>(),
      ),
    )
    ..registerLazySingleton<CheckCacheOnboardShownUseCase>(
      () => CheckCacheOnboardShownUseCase(serviceLocator<SplashRepository>()),
    )
    ..registerLazySingleton<SplashViewModel>(
      () => SplashViewModel(
        serviceLocator<CheckCacheOnboardShownUseCase>(),
        serviceLocator<GetAppDatabaseVersionNumberUseCase>(),
        serviceLocator<AppVersionManager>(),
      ),
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
    ..registerLazySingleton<BaseFirebaseService<SurveyModel>>(
      () => FirebaseServiceImpl(
        firestore: serviceLocator<FirebaseFirestore>(),
      ),
    )
    ..registerLazySingleton<BaseFirebaseService<QuestionModel>>(
      () => FirebaseServiceImpl(
        firestore: serviceLocator<FirebaseFirestore>(),
      ),
    )
    ..registerLazySingleton<CreateSurveyRemoteDataSource>(
      () => CreateSurveyRemoteDataSourceImpl(
        surveyFirebaseService:
            serviceLocator<BaseFirebaseService<SurveyModel>>(),
        questionFirebaseService:
            serviceLocator<BaseFirebaseService<QuestionModel>>(),
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
    ..registerLazySingleton<LinkSharingHelper>(
      () => LinkSharingHelperImpl(),
    )
    ..registerLazySingleton<CreateSurveyViewModel>(
      () => CreateSurveyViewModel(
        cacheDatasNoInternetUseCase:
            serviceLocator<CacheDatasNoInternetUseCase>(),
        connectivity: serviceLocator<INetworkInfo>(),
        imageHelper: serviceLocator<ImageHelper>(),
        surveyLogic: serviceLocator<SurveyLogic>(),
        shareLink: serviceLocator<LinkSharingHelper>(),
      ),
    )
    ..registerLazySingleton<BaseFirebaseService<UserModel>>(
      () => FirebaseServiceImpl(
        firestore: serviceLocator<FirebaseFirestore>(),
      ),
    )
    ..registerLazySingleton<HomeRemoteDataSource>(
      () => HomeRemoteDataSourceImpl(
        userService: serviceLocator<BaseFirebaseService<UserModel>>(),
        surveyService: serviceLocator<BaseFirebaseService<SurveyModel>>(),
      ),
    )
    ..registerLazySingleton<HomeRepository>(
      () => HomeRepositoryImpl(
        remoteDataSource: serviceLocator<HomeRemoteDataSource>(),
      ),
    )
    ..registerLazySingleton<GetPublishedSurveyIdsUsecase>(
      () => GetPublishedSurveyIdsUsecase(
        repository: serviceLocator<HomeRepository>(),
      ),
    )
    ..registerLazySingleton<GetPublishedSurveysUsecase>(
      () => GetPublishedSurveysUsecase(
        repository: serviceLocator<HomeRepository>(),
      ),
    )
    ..registerLazySingleton<HomeViewModel>(
      () => HomeViewModel(
        getSurveyIdsUsecase: serviceLocator<GetPublishedSurveyIdsUsecase>(),
        getSurveysUseCase: serviceLocator<GetPublishedSurveysUsecase>(),
      ),
    )
    ..registerLazySingleton<RemoveSurveyImagesUseCase>(
      () => RemoveSurveyImagesUseCase(
        repository: serviceLocator<ImageProcessRepository>(),
      ),
    )
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
        repository: serviceLocator<ImageProcessRepository>(),
      ),
    )
    ..registerLazySingleton<GetImageFileUseCase>(
      () => GetImageFileUseCase(
        repository: serviceLocator<ImageProcessRepository>(),
      ),
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
}
