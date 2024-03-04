// ignore: dangling_library_doc_comments
import 'dart:math';
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
  // final int seconds = remainingTime.inSeconds % 60;
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

String remainingTime({required DateTime atTime}) {
  const int secondsInDay = 24 * 3600;
  const int secondsInHours = 3600;
  const int secondsInMinutes = 60;
  int remainingSeconds =
      (atTime.millisecondsSinceEpoch - DateTime.now().millisecondsSinceEpoch) ~/
          1000;
  final int days = remainingSeconds ~/ secondsInDay;
  remainingSeconds = remainingSeconds % secondsInDay;
  final int hours = remainingSeconds ~/ secondsInHours;
  remainingSeconds = remainingSeconds % secondsInHours;

  final int minutes = remainingSeconds ~/ secondsInMinutes;
  remainingSeconds = remainingSeconds % secondsInMinutes;
  final int seconds = remainingSeconds;
  String timeAgo = "";

  if (days > 0) {
    timeAgo = "$days ${days < 2 ? "day" : "days"}";
  }

  if (days == 0 && hours > 0 && hours < 24) {
    timeAgo = "$timeAgo $hours ${hours < 2 ? "hour" : "hours"}";
  }

  if (days == 0 && hours == 0 && minutes > 0 && minutes < 60) {
    timeAgo = "$timeAgo $minutes ${minutes < 2 ? "minute" : "minutes "}";
  }

  if (days == 0 && hours == 0 && minutes > 0 && seconds > 0 && seconds < 60) {
    timeAgo = "$timeAgo $seconds ${seconds < 2 ? "second" : "seconds "}";
  } else if (days == 0 &&
      hours == 0 &&
      minutes == 0 &&
      seconds > 0 &&
      seconds < 60) {
    timeAgo = "$timeAgo $seconds ${seconds < 2 ? "second" : "seconds "}";
  }
  return timeAgo != "" ? "$timeAgo left" : "Expired";
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

/// Calculate Distance between two objects
double calculateDistance(double startLatitude, double startLongitude,
    double endLatitude, double endLongitude) {
  double p = 0.017453292519943295;
  double a = 0.5 -
      cos((endLatitude - startLatitude) * p) / 2 +
      cos(startLatitude * p) *
          cos(endLatitude * p) *
          (1 - cos((endLongitude - startLongitude) * p)) /
          2;
  return (12742 * asin(sqrt(a))); // 2 * R; R = 6371 km
}
