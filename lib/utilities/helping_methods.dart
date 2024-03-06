// ignore: dangling_library_doc_comments
import 'dart:math';
import 'package:beasy/utilities/extensions/date_extension.dart';
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
  final Duration diff = atTime.difference(DateTime.now().onlyDate());
  final int days = diff.inDays;
  final int hours = diff.inHours;

  String timeAgo = "";

  if (days > 0) {
    timeAgo = days < 2 ? "Tomorrow" : "$days days left";
  }

  if (hours < 24) {
    timeAgo = "Today";
  }
  return timeAgo != "" ? timeAgo : "Expired";
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

// calculate total hours
int calculateTotalHours(DateTime startTime, DateTime endTime) {
  final diff = endTime.difference(startTime);
  return diff.inSeconds;
}

String parseTotalHours(DateTime startTime, DateTime endTime) {
  int timeInSeconds = calculateTotalHours(startTime, endTime);
  final int hours = timeInSeconds ~/ (60 * 60);
  timeInSeconds %= (60 * 60);
  final int minutes = timeInSeconds ~/ 60;
  return "$hours:$minutes";
}

// Calculate Total price
double calculateTotalPrice(
    DateTime startTime, DateTime endTime, double pricePerHour) {
  final int timeInSeconds = calculateTotalHours(startTime, endTime);
  double hours = timeInSeconds / (60 * 60);
  return (hours * pricePerHour).ceilToDouble();
}
