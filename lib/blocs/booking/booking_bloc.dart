// ignore: dangling_library_doc_comments
import 'package:beasy/blocs/booking/booking_event.dart';
import 'package:beasy/blocs/booking/booking_state.dart';
import 'package:beasy/exceptions/app_exceptions.dart';
import 'package:beasy/models/booking_model.dart';
import 'package:beasy/models/product_model.dart';
import 'package:beasy/models/user_model.dart';
import 'package:beasy/repositories/repos/user_repo.dart';
import 'package:beasy/utilities/extensions/extensions.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../repositories/repos/immutable_booking_repo.dart';

/// Project: 	   CarRenterApp
/// File:    	   booking_bloc
/// Path:    	   lib/blocs/booking/booking_bloc.dart
/// Author:       Ali Akbar
/// Date:        29-02-24 14:23:56 -- Thursday
/// Description:

class BookingBloc extends Bloc<BookingEvent, BookingState> {
  BookingBloc() : super(BookingStateInitial()) {
    /// Create booking event
    on<BookingEventCreateBooking>(
      (event, emit) async {
        try {
          final ProductModel product = event.product;
          final UserModel user = UserRepo().currentUser;
          final BookingModel model = BookingModel(
            id: "",
            serviceId: product.id,
            serviceProviderId: product.ownerId,
            bookingUserName: "${user.firstName} ${user.lastName}",
            bookingUserProfile: user.imageUrl ?? "",
            bookingUserId: user.uid,
            bookingDate: event.selectedDate,
            createdAt: DateTime.now(),
            bookingTime: event.bookingTime
                .map((e) => event.selectedDate.mergeTimeFrom(e))
                .toList(),
            status: BookingStatus.pending,
            car: product.name,
          );
          emit(BookingStateBookingCreating());
          await ImmutableBookingRepo().create(model: model);
          emit(BookingStateBooked());
        } on AppException catch (e) {
          emit(BookingStateBookingFailure(exception: e));
        }
      },
    );

    /// on Service Provider Booking Fetching
    on<BookingEventFetchForServiceProvider>(
      (event, emit) async {
        try {
          emit(BookingStateFetchingBookings());
          final List<BookingModel> bookings =
              await ImmutableBookingRepo().fetchForServiceProvider();
          emit(BookingStateFetchBookingSuccess(bookings: bookings));
        } on AppException catch (e) {
          emit(BookingStateFetchBookingsFailure(exception: e));
        }
      },
    );

    /// on Service Provider Booking Fetching
    on<BookingEventFetchForIndividualService>(
      (event, emit) async {
        try {
          emit(BookingStateFetchingBookings());
          final List<BookingModel> bookings = await ImmutableBookingRepo()
              .fetchForIndividualServices(serviceId: event.serviceId);
          emit(BookingStateFetchBookingSuccess(bookings: bookings));
        } on AppException catch (e) {
          emit(BookingStateFetchBookingsFailure(exception: e));
        }
      },
    );
  }
}
