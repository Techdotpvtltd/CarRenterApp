import 'package:intl/intl.dart';

extension DateTimeExt on DateTime {
  DateTime onlyDate() {
    return DateTime(year, month, day);
  }

  String dateToString(String pattern) {
    return DateFormat(pattern).format(this);
  }
}
