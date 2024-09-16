/// THIS IS A BASE CACHE MANAGEMENT CLASS THAT DEFINES ALL CACHE OPERATIONS.
abstract class BaseCacheManager<T> {
  ///SAVE METHOD FOR T TYPE DATA
  Future<void> saveData({required T data, required String keyName});

  ///GET METHOD FOR T TYPE DATA
  Future<T?> getData({required String keyName});

  ///CLEAR METHOD
  Future<void> clearData({required String keyName});
}
