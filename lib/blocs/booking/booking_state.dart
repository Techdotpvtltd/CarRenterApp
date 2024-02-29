// ignore: dangling_library_doc_comments
import 'package:beasy/exceptions/app_exceptions.dart';

/// Project: 	   CarRenterApp
/// File:    	   booking_state
/// Path:    	   lib/blocs/booking/booking_state.dart
/// Author:       Ali Akbar
/// Date:        29-02-24 14:16:08 -- Thursday
/// Description:

abstract class BookingState {
  final bool isLoading;
  final String loadingText;

  BookingState({this.isLoading = false, this.loadingText = ""});
}

/// Initial State
class BookingStateInitial extends BookingState {}

// =========================== Create Booking States ================================
class BookingStateBookingCreating extends BookingState {
  BookingStateBookingCreating(
      {super.isLoading = true, super.loadingText = "Requesting..."});
}

/// Failure
class BookingStateBookingFailure extends BookingState {
  final AppException exception;

  BookingStateBookingFailure({required this.exception});
}

/// Success
class BookingStateBooked extends BookingState {}
