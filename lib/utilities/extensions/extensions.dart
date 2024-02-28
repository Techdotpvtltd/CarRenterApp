// ignore: dangling_library_doc_comments
/// Project: 	   burns_construction_admin
/// File:    	   extensions
/// Path:    	   lib/utils/extenions/extensions.dart
/// Author:       Ali Akbar
/// Date:        19-02-24 12:23:51 -- Monday
/// Description:

extension DateTimeExtensions on DateTime {
  /// Creates a new date time with the given date but with the time
  /// specified from [time]
  DateTime withTime([int hour = 0, int minute = 0]) =>
      DateTime(year, month, day, hour, minute);
}
