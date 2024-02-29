// ignore: dangling_library_doc_comments
import 'package:beasy/exceptions/app_exceptions.dart';

/// Project: 	   CarRenterApp
/// File:    	   notification_state
/// Path:    	   lib/blocs/notification/notification_state.dart
/// Author:       Ali Akbar
/// Date:        29-02-24 18:56:57 -- Thursday
/// Description:

abstract class NotificationState {
  final bool isLoading;
  final String loadingText;

  NotificationState({this.isLoading = false, this.loadingText = ""});
}

// ===========================Initial States================================
class NotificationStateInitial extends NotificationState {}

// ===========================Fetching Notification States================================
class NotificationStateFetching extends NotificationState {
  NotificationStateFetching(
      {super.isLoading = true, super.loadingText = "Fetching Notifications"});
}

// Failure State
class NotificationStateFetchFailure extends NotificationState {
  final AppException exception;

  NotificationStateFetchFailure({required this.exception});
}

// Success State
class NotificationStateFetched extends NotificationState {}
