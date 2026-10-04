// Валидаторы форм
// AUTO-GENERATED STUB. Реализуйте логику позже.

/// Набор статических валидаторов для форм.
class Validators {
  Validators._();

  static String? email(String? value) {
    if (value == null || value.trim().isEmpty) return 'Введите email';
    final RegExp re = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$');
    return re.hasMatch(value.trim()) ? null : 'Некорректный email';
  }

  static String? password(String? value) {
    if (value == null || value.isEmpty) return 'Введите пароль';
    if (value.length < 6) return 'Минимум 6 символов';
    return null;
  }

  static String? notEmpty(String? value, {String field = 'поле'}) {
    if (value == null || value.trim().isEmpty) return 'Заполните $field';
    return null;
  }
}
