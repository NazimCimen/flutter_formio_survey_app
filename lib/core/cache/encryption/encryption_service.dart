import 'dart:convert';
import 'package:encrypt/encrypt.dart';
import 'package:flutter_survey_app_mobile/core/cache/encryption/secure_encryption_key_manager.dart';

/// THIS IS A CLASS THAT DEFINES ENCRYPTION AND DECRYPTION OPERATIONS
abstract class BaseEncryptionService {
  /// ENCRYPTS DATA.
  Future<String?> encrypt(String data);

  /// DECRYPTS DATA
  Future<String?> decrypt(String data);
}

///ENCRYPTION SERVICE THAT PERFORMS USING THE AES ENCRYPTION ALGORITHM.
class AESEncryptionService implements BaseEncryptionService {
  final SecureEncryptionKeyManager encryptionKeyManager;
  AESEncryptionService(this.encryptionKeyManager);

  @override
  Future<String?> encrypt(String data) async {
    final iv = IV.fromSecureRandom(16);
    final encryptionKey =
        await encryptionKeyManager.fetchEncryptedKeyUint8List();
    if (encryptionKey == null) {
      return null;
    }
    final key = Key(encryptionKey);
    final encrypter = Encrypter(AES(key, mode: AESMode.cbc));
    final encryptedData = encrypter.encrypt(data, iv: iv);
    final model = {
      'data': encryptedData.base64,
      'iv': iv.base64,
    };
    return jsonEncode(model);
  }

  @override
  Future<String?> decrypt(String data) async {
    final decodedJson = jsonDecode(data);
    final encryptedData = decodedJson['data'] as String;
    final iv = IV.fromBase64(decodedJson['iv'] as String);
    final encryptionKey =
        await encryptionKeyManager.fetchEncryptedKeyUint8List();
    if (encryptionKey == null) {
      return null;
    }
    final key = Key(encryptionKey);
    final encrypter = Encrypter(AES(key, mode: AESMode.cbc));
    return encrypter.decrypt64(encryptedData, iv: iv);
  }
}
