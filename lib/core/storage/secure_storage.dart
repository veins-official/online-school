// Безопасное хранилище токенов
// AUTO-GENERATED STUB. Реализуйте логику позже.

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

/// Обёртка над flutter_secure_storage.
class SecureStorage {
  SecureStorage._();

  static final SecureStorage instance = SecureStorage._();

  static const String _tokenKey = 'pb_auth_token';

  final FlutterSecureStorage _storage = const FlutterSecureStorage();

  Future<void> saveToken(String token) => _storage.write(key: _tokenKey, value: token);

  Future<String?> readToken() => _storage.read(key: _tokenKey);

  Future<void> clear() => _storage.delete(key: _tokenKey);
}
