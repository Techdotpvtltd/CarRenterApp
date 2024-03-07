// ignore: dangling_library_doc_comments
import 'package:beasy/models/booking_model.dart';
import 'package:beasy/models/product_model.dart';

/// Project: 	   CarRenterApp
/// File:    	   booking_event
/// Path:    	   lib/blocs/booking/booking_event.dart
/// Author:       Ali Akbar
/// Date:        29-02-24 14:21:25 -- Thursday
/// Description:

abstract class BookingEvent {}

// ===========================Initial Booking Event ================================
class BookingEventInitial extends BookingEvent {}

// =========================== Create Booking Event ================================
class BookingEventCreateBooking extends BookingEvent {
  final DateTime selectedDate;
  final ProductModel product;

  BookingEventCreateBooking(
      {required this.selectedDate, required this.product});
}

// =========================== Create Booking Event ================================
class BookingEventUpdateBooking extends BookingEvent {
  final BookingModel bookingModel;
  final DateTime selectedDate;

  BookingEventUpdateBooking({
    required this.selectedDate,
    required this.bookingModel,
  });
}

// ===========================Fetch Booking Events ================================
// For Service Providers
class BookingEventFetchForServiceProvider extends BookingEvent {}

// For Individual Services
class BookingEventFetchForIndividualService extends BookingEvent {
  final String serviceId;
  BookingEventFetchForIndividualService({required this.serviceId});
}

// For Rental User
class BookingEventFetchCurrentUserBookings extends BookingEvent {}

// ===========================User Profile Fetching Events================================
class BookingEventFetchUserProfile extends BookingEvent {
  final String profileId;

  BookingEventFetchUserProfile({required this.profileId});
}

// ===========================Update Status Event================================
class BookingEventUpdateStatus extends BookingEvent {
  final String bookingId;
  final BookingStatus status;

  BookingEventUpdateStatus({required this.bookingId, required this.status});
}
