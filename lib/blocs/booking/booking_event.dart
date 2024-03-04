// ignore: dangling_library_doc_comments
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
  final List<String> bookingTime;
  final ProductModel product;

  BookingEventCreateBooking(
      {required this.selectedDate,
      required this.bookingTime,
      required this.product});
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
class BookingEventFetchForRentalUser extends BookingEvent {}

// ===========================User Profile Fetching Events================================
class BookingEventFetchSPProfile extends BookingEvent {
  final String profileId;

  BookingEventFetchSPProfile({required this.profileId});
}
