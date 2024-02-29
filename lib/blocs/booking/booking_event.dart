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
