import 'package:flutter_survey_app_mobile/core/cache/cache_manager/base_cache_manager.dart';
import 'package:flutter_survey_app_mobile/core/cache/encryption/encryption_service.dart';
import 'package:hive_flutter/hive_flutter.dart';

///IT IS A CACHE MANAGEMENT CLASS THAT INCLUDES ENCRYPTION OPERATIONS BY EXTENDING BaseCacheManager<String>
class EncryptedCacheManager extends BaseCacheManager<String> {
  final String boxName;
  final String keyName;
  final BaseEncryptionService encryptionService;

  EncryptedCacheManager({
    required this.boxName,
    required this.keyName,
    required this.encryptionService,
  });

  Future<Box<String>> _openBox() async {
    return Hive.openBox<String>(boxName);
  }

  /// ENCRYPT AND SAVE
  @override
  Future<void> saveData({
    required String data,
    required String keyName,
  }) async {
    final box = await _openBox();
    final encryptedData = await encryptionService.encrypt(data);
    if (encryptedData == null) {
      return;
    }
    await box.put(keyName, encryptedData);
    await box.close();
  }

  /// GET AND DECRYPT
  @override
  Future<String?> getData({
    required String keyName,
  }) async {
    final box = await _openBox();
    final data = box.get(keyName);
    await box.close();
    if (data == null) return null;
    return await encryptionService.decrypt(data);
  }

  /// DELETE
  @override
  Future<void> clearData({
    required String keyName,
  }) async {
    final box = await _openBox();
    await box.delete(keyName);
    await box.close();
  }
}
