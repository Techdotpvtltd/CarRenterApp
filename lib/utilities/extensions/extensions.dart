// ignore: dangling_library_doc_comments
import 'package:intl/intl.dart';

/// Project: 	   burns_construction_admin
/// File:    	   extensions
/// Path:    	   lib/utils/extenions/extensions.dart
/// Author:       Ali Akbar
/// Date:        19-02-24 12:23:51 -- Monday
/// Description:

extension DateTimeExtensions on DateTime {
  /// Creates a new date time with the given date but with the time
  /// specified from [time]
  DateTime mergeTime([int hour = 0, int minute = 0]) =>
      DateTime(year, month, day, hour, minute);
  DateTime mergeTimeFrom(String hm) {
    final DateTime time = DateFormat.Hm().parse(hm);
    return DateTime(year, month, day, time.hour, time.minute);
  }
}
