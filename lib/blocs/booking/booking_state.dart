// ignore: dangling_library_doc_comments
import 'package:beasy/exceptions/app_exceptions.dart';
import 'package:beasy/models/booking_model.dart';
import 'package:beasy/models/user_model.dart';

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

// =========================== Create Booking States ================================
class BookingStateBookingUpdating extends BookingState {
  BookingStateBookingUpdating(
      {super.isLoading = true, super.loadingText = "Requesting..."});
}

/// Failure
class BookingStateUpdateBookingFailure extends BookingState {
  final AppException exception;

  BookingStateUpdateBookingFailure({required this.exception});
}

/// Success
class BookingStateBookingUpdated extends BookingState {
  final BookingModel? booking;

  BookingStateBookingUpdated({this.booking});
}

// ===========================Fetching Booking States================================
class BookingStateFetchingBookings extends BookingState {
  BookingStateFetchingBookings(
      {super.isLoading = true, super.loadingText = "Fetching..."});
}

// Failure
class BookingStateFetchBookingsFailure extends BookingState {
  final AppException exception;

  BookingStateFetchBookingsFailure({required this.exception});
}

// Success
class BookingStateFetchBookingSuccess extends BookingState {
  final List<BookingModel> bookings;

  BookingStateFetchBookingSuccess({required this.bookings});
}

// ===========================Fetching User Profiles================================

class BookingStateUserProfileFetched extends BookingState {
  final UserModel user;

  BookingStateUserProfileFetched(
      {super.isLoading, super.loadingText, required this.user});
}

// =========================== Udate Status States ================================
class BookingStateUpdatingStatus extends BookingState {
  BookingStateUpdatingStatus({super.isLoading = true});
}

// Failure Case
class BookingStateUpdateStatusFailure extends BookingState {
  final AppException exception;

  BookingStateUpdateStatusFailure({required this.exception});
}

// Success Case
class BookingStateStatusUpdated extends BookingState {
  final BookingStatus status;
  final String id;
  BookingStateStatusUpdated(this.id,
      {super.isLoading, super.loadingText, required this.status});
}
