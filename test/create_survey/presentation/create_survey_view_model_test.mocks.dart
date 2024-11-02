// Mocks generated by Mockito 5.4.4 from annotations
// in flutter_survey_app/test/create_survey/presentation/create_survey_view_model_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i13;
import 'dart:convert' as _i25;
import 'dart:typed_data' as _i16;

import 'package:dartz/dartz.dart' as _i6;
import 'package:flutter_survey_app_mobile/core/connection/network_info.dart'
    as _i20;
import 'package:flutter_survey_app_mobile/core/error/failure.dart' as _i14;
import 'package:flutter_survey_app_mobile/feature/create_survey/domain/repository/create_survey_repository.dart'
    as _i11;
import 'package:flutter_survey_app_mobile/feature/create_survey/domain/usecase/cache_datas_no_internet_use_case.dart'
    as _i24;
import 'package:flutter_survey_app_mobile/feature/create_survey/domain/usecase/remove_survey_use_case.dart'
    as _i3;
import 'package:flutter_survey_app_mobile/feature/create_survey/domain/usecase/share_questions_use_case.dart'
    as _i5;
import 'package:flutter_survey_app_mobile/feature/create_survey/domain/usecase/share_survey_info_use_case.dart'
    as _i4;
import 'package:flutter_survey_app_mobile/feature/create_survey/presentation/viewmodel/survey_logic.dart'
    as _i12;
import 'package:flutter_survey_app_mobile/feature/image_process/domain/usecase/crop_image_use_case.dart'
    as _i9;
import 'package:flutter_survey_app_mobile/feature/image_process/domain/usecase/get_image_file_use_case.dart'
    as _i8;
import 'package:flutter_survey_app_mobile/feature/image_process/domain/usecase/get_image_url_use_case.dart'
    as _i7;
import 'package:flutter_survey_app_mobile/feature/image_process/domain/usecase/remove_survey_images_use_case.dart'
    as _i10;
import 'package:flutter_survey_app_mobile/feature/image_process/helper/image_helper.dart'
    as _i2;
import 'package:flutter_survey_app_mobile/feature/shared_layers/domain/entity/question_entity.dart'
    as _i17;
import 'package:flutter_survey_app_mobile/feature/shared_layers/domain/entity/survey_entity.dart'
    as _i15;
import 'package:flutter_survey_app_mobile/product/helper/link_sharing_helper.dart'
    as _i18;
import 'package:image_cropper/image_cropper.dart' as _i23;
import 'package:image_picker/image_picker.dart' as _i22;
import 'package:mockito/mockito.dart' as _i1;
import 'package:mockito/src/dummies.dart' as _i19;
import 'package:share_plus/share_plus.dart' as _i21;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: deprecated_member_use
// ignore_for_file: deprecated_member_use_from_same_package
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types
// ignore_for_file: subtype_of_sealed_class

class _FakeImageHelper_0 extends _i1.SmartFake implements _i2.ImageHelper {
  _FakeImageHelper_0(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeRemoveSurveyUseCase_1 extends _i1.SmartFake
    implements _i3.RemoveSurveyUseCase {
  _FakeRemoveSurveyUseCase_1(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeShareSurveyInfoUseCase_2 extends _i1.SmartFake
    implements _i4.ShareSurveyInfoUseCase {
  _FakeShareSurveyInfoUseCase_2(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeShareQuestionsUseCase_3 extends _i1.SmartFake
    implements _i5.ShareQuestionsUseCase {
  _FakeShareQuestionsUseCase_3(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeEither_4<L, R> extends _i1.SmartFake implements _i6.Either<L, R> {
  _FakeEither_4(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeGetImageUrlUseCase_5 extends _i1.SmartFake
    implements _i7.GetImageUrlUseCase {
  _FakeGetImageUrlUseCase_5(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeGetImageFileUseCase_6 extends _i1.SmartFake
    implements _i8.GetImageFileUseCase {
  _FakeGetImageFileUseCase_6(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeCropImageUseCase_7 extends _i1.SmartFake
    implements _i9.CropImageUseCase {
  _FakeCropImageUseCase_7(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeRemoveSurveyImagesUseCase_8 extends _i1.SmartFake
    implements _i10.RemoveSurveyImagesUseCase {
  _FakeRemoveSurveyImagesUseCase_8(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeCreateSurveyRepository_9 extends _i1.SmartFake
    implements _i11.CreateSurveyRepository {
  _FakeCreateSurveyRepository_9(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeDateTime_10 extends _i1.SmartFake implements DateTime {
  _FakeDateTime_10(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

/// A class which mocks [SurveyLogic].
///
/// See the documentation for Mockito's code generation for more information.
class MockSurveyLogic extends _i1.Mock implements _i12.SurveyLogic {
  MockSurveyLogic() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.ImageHelper get imageHelper => (super.noSuchMethod(
        Invocation.getter(#imageHelper),
        returnValue: _FakeImageHelper_0(
          this,
          Invocation.getter(#imageHelper),
        ),
      ) as _i2.ImageHelper);

  @override
  _i3.RemoveSurveyUseCase get removeSurveyUseCase => (super.noSuchMethod(
        Invocation.getter(#removeSurveyUseCase),
        returnValue: _FakeRemoveSurveyUseCase_1(
          this,
          Invocation.getter(#removeSurveyUseCase),
        ),
      ) as _i3.RemoveSurveyUseCase);

  @override
  _i4.ShareSurveyInfoUseCase get shareSurveyInfoUseCase => (super.noSuchMethod(
        Invocation.getter(#shareSurveyInfoUseCase),
        returnValue: _FakeShareSurveyInfoUseCase_2(
          this,
          Invocation.getter(#shareSurveyInfoUseCase),
        ),
      ) as _i4.ShareSurveyInfoUseCase);

  @override
  _i5.ShareQuestionsUseCase get shareQuestionsUseCase => (super.noSuchMethod(
        Invocation.getter(#shareQuestionsUseCase),
        returnValue: _FakeShareQuestionsUseCase_3(
          this,
          Invocation.getter(#shareQuestionsUseCase),
        ),
      ) as _i5.ShareQuestionsUseCase);

  @override
  _i13.Future<_i6.Either<_i14.Failure, bool>> shareSurvey({
    required _i15.SurveyEntity? surveyEntity,
    required _i16.Uint8List? selectedSurveyImageBytes,
    required Map<_i17.QuestionEntity, _i16.Uint8List?>? questionEntityMap,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #shareSurvey,
          [],
          {
            #surveyEntity: surveyEntity,
            #selectedSurveyImageBytes: selectedSurveyImageBytes,
            #questionEntityMap: questionEntityMap,
          },
        ),
        returnValue: _i13.Future<_i6.Either<_i14.Failure, bool>>.value(
            _FakeEither_4<_i14.Failure, bool>(
          this,
          Invocation.method(
            #shareSurvey,
            [],
            {
              #surveyEntity: surveyEntity,
              #selectedSurveyImageBytes: selectedSurveyImageBytes,
              #questionEntityMap: questionEntityMap,
            },
          ),
        )),
      ) as _i13.Future<_i6.Either<_i14.Failure, bool>>);

  @override
  _i13.Future<void> removeSurvey({required String? surveyId}) =>
      (super.noSuchMethod(
        Invocation.method(
          #removeSurvey,
          [],
          {#surveyId: surveyId},
        ),
        returnValue: _i13.Future<void>.value(),
        returnValueForMissingStub: _i13.Future<void>.value(),
      ) as _i13.Future<void>);
}

/// A class which mocks [LinkSharingHelper].
///
/// See the documentation for Mockito's code generation for more information.
class MockLinkSharingHelper extends _i1.Mock implements _i18.LinkSharingHelper {
  MockLinkSharingHelper() {
    _i1.throwOnMissingStub(this);
  }

  @override
  void shareSurveyLink({required String? surveyId}) => super.noSuchMethod(
        Invocation.method(
          #shareSurveyLink,
          [],
          {#surveyId: surveyId},
        ),
        returnValueForMissingStub: null,
      );

  @override
  String generateSurveyLink(String? surveyId) => (super.noSuchMethod(
        Invocation.method(
          #generateSurveyLink,
          [surveyId],
        ),
        returnValue: _i19.dummyValue<String>(
          this,
          Invocation.method(
            #generateSurveyLink,
            [surveyId],
          ),
        ),
      ) as String);
}

/// A class which mocks [INetworkInfo].
///
/// See the documentation for Mockito's code generation for more information.
class MockINetworkInfo extends _i1.Mock implements _i20.INetworkInfo {
  MockINetworkInfo() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i13.Future<bool> get currentConnectivityResult => (super.noSuchMethod(
        Invocation.getter(#currentConnectivityResult),
        returnValue: _i13.Future<bool>.value(false),
      ) as _i13.Future<bool>);
}

/// A class which mocks [ImageHelper].
///
/// See the documentation for Mockito's code generation for more information.
class MockImageHelper extends _i1.Mock implements _i2.ImageHelper {
  MockImageHelper() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i7.GetImageUrlUseCase get getImageUrlUseCase => (super.noSuchMethod(
        Invocation.getter(#getImageUrlUseCase),
        returnValue: _FakeGetImageUrlUseCase_5(
          this,
          Invocation.getter(#getImageUrlUseCase),
        ),
      ) as _i7.GetImageUrlUseCase);

  @override
  _i8.GetImageFileUseCase get getImageUseCase => (super.noSuchMethod(
        Invocation.getter(#getImageUseCase),
        returnValue: _FakeGetImageFileUseCase_6(
          this,
          Invocation.getter(#getImageUseCase),
        ),
      ) as _i8.GetImageFileUseCase);

  @override
  _i9.CropImageUseCase get cropImageUseCase => (super.noSuchMethod(
        Invocation.getter(#cropImageUseCase),
        returnValue: _FakeCropImageUseCase_7(
          this,
          Invocation.getter(#cropImageUseCase),
        ),
      ) as _i9.CropImageUseCase);

  @override
  _i10.RemoveSurveyImagesUseCase get removeSurveyImagesUseCase =>
      (super.noSuchMethod(
        Invocation.getter(#removeSurveyImagesUseCase),
        returnValue: _FakeRemoveSurveyImagesUseCase_8(
          this,
          Invocation.getter(#removeSurveyImagesUseCase),
        ),
      ) as _i10.RemoveSurveyImagesUseCase);

  @override
  _i13.Future<_i21.XFile?> getImage({
    required _i22.ImageSource? selectedSource,
    required _i23.CropAspectRatio? cropRatio,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #getImage,
          [],
          {
            #selectedSource: selectedSource,
            #cropRatio: cropRatio,
          },
        ),
        returnValue: _i13.Future<_i21.XFile?>.value(),
      ) as _i13.Future<_i21.XFile?>);

  @override
  _i13.Future<_i6.Either<_i14.Failure, String>> getImageUrl({
    required _i16.Uint8List? imageByte,
    required String? path,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #getImageUrl,
          [],
          {
            #imageByte: imageByte,
            #path: path,
          },
        ),
        returnValue: _i13.Future<_i6.Either<_i14.Failure, String>>.value(
            _FakeEither_4<_i14.Failure, String>(
          this,
          Invocation.method(
            #getImageUrl,
            [],
            {
              #imageByte: imageByte,
              #path: path,
            },
          ),
        )),
      ) as _i13.Future<_i6.Either<_i14.Failure, String>>);

  @override
  _i13.Future<void> removeSurveyImages({
    required String? surveyId,
    required String? userId,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #removeSurveyImages,
          [],
          {
            #surveyId: surveyId,
            #userId: userId,
          },
        ),
        returnValue: _i13.Future<void>.value(),
        returnValueForMissingStub: _i13.Future<void>.value(),
      ) as _i13.Future<void>);
}

/// A class which mocks [CacheDatasNoInternetUseCase].
///
/// See the documentation for Mockito's code generation for more information.
class MockCacheDatasNoInternetUseCase extends _i1.Mock
    implements _i24.CacheDatasNoInternetUseCase {
  MockCacheDatasNoInternetUseCase() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i11.CreateSurveyRepository get repository => (super.noSuchMethod(
        Invocation.getter(#repository),
        returnValue: _FakeCreateSurveyRepository_9(
          this,
          Invocation.getter(#repository),
        ),
      ) as _i11.CreateSurveyRepository);

  @override
  _i13.Future<void> call({
    required String? path,
    required String? surveyId,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #call,
          [],
          {
            #path: path,
            #surveyId: surveyId,
          },
        ),
        returnValue: _i13.Future<void>.value(),
        returnValueForMissingStub: _i13.Future<void>.value(),
      ) as _i13.Future<void>);
}

/// A class which mocks [XFile].
///
/// See the documentation for Mockito's code generation for more information.
class MockXFile extends _i1.Mock implements _i21.XFile {
  MockXFile() {
    _i1.throwOnMissingStub(this);
  }

  @override
  String get path => (super.noSuchMethod(
        Invocation.getter(#path),
        returnValue: _i19.dummyValue<String>(
          this,
          Invocation.getter(#path),
        ),
      ) as String);

  @override
  String get name => (super.noSuchMethod(
        Invocation.getter(#name),
        returnValue: _i19.dummyValue<String>(
          this,
          Invocation.getter(#name),
        ),
      ) as String);

  @override
  _i13.Future<void> saveTo(String? path) => (super.noSuchMethod(
        Invocation.method(
          #saveTo,
          [path],
        ),
        returnValue: _i13.Future<void>.value(),
        returnValueForMissingStub: _i13.Future<void>.value(),
      ) as _i13.Future<void>);

  @override
  _i13.Future<int> length() => (super.noSuchMethod(
        Invocation.method(
          #length,
          [],
        ),
        returnValue: _i13.Future<int>.value(0),
      ) as _i13.Future<int>);

  @override
  _i13.Future<String> readAsString(
          {_i25.Encoding? encoding = const _i25.Utf8Codec()}) =>
      (super.noSuchMethod(
        Invocation.method(
          #readAsString,
          [],
          {#encoding: encoding},
        ),
        returnValue: _i13.Future<String>.value(_i19.dummyValue<String>(
          this,
          Invocation.method(
            #readAsString,
            [],
            {#encoding: encoding},
          ),
        )),
      ) as _i13.Future<String>);

  @override
  _i13.Future<_i16.Uint8List> readAsBytes() => (super.noSuchMethod(
        Invocation.method(
          #readAsBytes,
          [],
        ),
        returnValue: _i13.Future<_i16.Uint8List>.value(_i16.Uint8List(0)),
      ) as _i13.Future<_i16.Uint8List>);

  @override
  _i13.Stream<_i16.Uint8List> openRead([
    int? start,
    int? end,
  ]) =>
      (super.noSuchMethod(
        Invocation.method(
          #openRead,
          [
            start,
            end,
          ],
        ),
        returnValue: _i13.Stream<_i16.Uint8List>.empty(),
      ) as _i13.Stream<_i16.Uint8List>);

  @override
  _i13.Future<DateTime> lastModified() => (super.noSuchMethod(
        Invocation.method(
          #lastModified,
          [],
        ),
        returnValue: _i13.Future<DateTime>.value(_FakeDateTime_10(
          this,
          Invocation.method(
            #lastModified,
            [],
          ),
        )),
      ) as _i13.Future<DateTime>);
}
