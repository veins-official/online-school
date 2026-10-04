// Базовый интерфейс модели
// AUTO-GENERATED STUB. Реализуйте логику позже.

/// Контракт для всех доменных моделей.
abstract class BaseModel {
  const BaseModel();

  String get id;

  Map<String, dynamic> toJson();

  @override
  String toString() => '$runtimeType(id: $id)';
}
