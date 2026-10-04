// Failures для Result-подхода
// AUTO-GENERATED STUB. Реализуйте логику позже.

/// Абстрактный failure для функционального Result-подхода.
abstract class Failure {
  const Failure(this.message);

  final String message;
}

class ServerFailure extends Failure {
  const ServerFailure(super.message);
}

class CacheFailure extends Failure {
  const CacheFailure(super.message);
}

class AuthFailure extends Failure {
  const AuthFailure(super.message);
}
