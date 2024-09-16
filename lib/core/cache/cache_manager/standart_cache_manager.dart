import 'package:flutter_survey_app/core/cache/cache_manager/base_cache_manager.dart';
import 'package:hive_flutter/hive_flutter.dart';

/// IT IS A STANDART CACHE MANAGEMENT CLASS THAT DOES NOT PERFORM ENCRYPTION.IT EXTENDS BaseCacheManager<T>,
class StandartCacheManager<T> extends BaseCacheManager<T> {
  final String boxName;

  StandartCacheManager({
    required this.boxName,
  });

  Future<Box<T>> _openBox() async {
    return Hive.openBox<T>(boxName);
  }

  ///SAVE
  @override
  Future<void> saveData({
    required T data,
    required String keyName,
    bool encrypt = false,
  }) async {
    final box = await _openBox();
    await box.put(keyName, data);
    await box.close();
  }

  ///GET
  @override
  Future<T?> getData({
    required String keyName,
    bool decrypt = false,
  }) async {
    final box = await _openBox();
    final data = box.get(keyName);
    await box.close();
    return data;
  }

  ///CLEAR
  @override
  Future<void> clearData({required String keyName}) async {
    final box = await _openBox();
    await box.delete(keyName);
    await box.close();
  }
}
