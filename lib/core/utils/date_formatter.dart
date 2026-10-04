// Форматирование дат
// AUTO-GENERATED STUB. Реализуйте логику позже.

import 'package:intl/intl.dart';

/// Утилиты форматирования дат.
class DateFormatter {
  DateFormatter._();

  static final DateFormat _date = DateFormat('dd.MM.yyyy');
  static final DateFormat _dateTime = DateFormat('dd.MM.yyyy HH:mm');

  static String date(DateTime? dt) => dt == null ? '—' : _date.format(dt);

  static String dateTime(DateTime? dt) => dt == null ? '—' : _dateTime.format(dt);
}
