// ignore: dangling_library_doc_comments
import 'package:intl/intl.dart';

/// Project: 	   CarRenterApp
/// File:    	   helping_methods
/// Path:    	   lib/utilities/helping_methods.dart
/// Author:       Ali Akbar
/// Date:        29-02-24 18:39:38 -- Thursday
/// Description:

String parseTimePeriod({required DateTime atTime}) {
  final Duration remainingTime = DateTime.now().difference(atTime);
  final int days = remainingTime.inDays;
  final int minutes = remainingTime.inMinutes;
  final int hours = remainingTime.inHours;
  final int weeks = days % 7;
  final int months = days % 30;

  String timeAgo = "now";
  if (months > 0) {
    timeAgo = "$months ${months < 2 ? "month" : "months"} ago";
  }

  if (weeks > 0 && weeks < 4) {
    timeAgo = "$weeks ${weeks < 2 ? "week" : "weeks"} ago";
  }

  if (days > 0 && days < 31) {
    timeAgo = "$days ${days < 2 ? "day" : "days"} ago";
  }

  if (hours > 0 && hours < 24) {
    timeAgo = "$hours ${hours < 2 ? "hour" : "hours"} ago";
  }

  if (minutes > 0 && minutes < 60) {
    timeAgo = "$minutes ${minutes < 2 ? "minute" : "minutes"} ago";
  }
  return timeAgo;
}

/// Format Date
DateTime formatDate({required DateTime dateTime, required String format}) {
  final parsedDate = DateFormat(format).format(dateTime);
  return DateFormat(format).parse(parsedDate);
}

/// Only Date in Seconds
int dateInMilliSeconds({required DateTime date}) {
  return formatDate(dateTime: date, format: "YY/MM/dd").millisecondsSinceEpoch;
}

/// Convert Str Time Into Miliseconds
int timeInMilliSecondsFrom({required String value}) {
  return DateFormat("HH:mm").parse(value).millisecondsSinceEpoch;
}
