// Доменные исключения
// AUTO-GENERATED STUB. Реализуйте логику позже.

/// Базовое исключение уровня приложения.
class AppException implements Exception {
  const AppException(this.message, {this.cause});

  final String message;
  final Object? cause;

  @override
  String toString() => 'AppException: $message';
}

class NetworkException extends AppException {
  const NetworkException(super.message, {super.cause});
}

class AuthException extends AppException {
  const AuthException(super.message, {super.cause});
}

class ValidationException extends AppException {
  const ValidationException(super.message, {super.cause});
}
