// Расширения BuildContext
// AUTO-GENERATED STUB. Реализуйте логику позже.

import 'package:flutter/material.dart';

/// Удобные шорткаты для BuildContext.
extension ContextX on BuildContext {
  ThemeData get theme => Theme.of(this);

  TextTheme get textTheme => Theme.of(this).textTheme;

  MediaQueryData get mq => MediaQuery.of(this);

  void showSnack(String message) =>
      ScaffoldMessenger.of(this).showSnackBar(SnackBar(content: Text(message)));
}
