// Переменные окружения
// AUTO-GENERATED STUB. Реализуйте логику позже.

/// Централизованное хранилище конфигурации окружения.
///
/// Значения должны подставляться через --dart-define при сборке.
class Env {
  Env._();

  static const String pocketBaseUrl = String.fromEnvironment(
    'POCKETBASE_URL',
    defaultValue: 'http://127.0.0.1:8090',
  );

  static const String liveKitUrl = String.fromEnvironment(
    'LIVEKIT_URL',
    defaultValue: 'ws://127.0.0.1:7880',
  );

  static const String liveKitApiKey = String.fromEnvironment(
    'LIVEKIT_API_KEY',
    defaultValue: '',
  );
}
