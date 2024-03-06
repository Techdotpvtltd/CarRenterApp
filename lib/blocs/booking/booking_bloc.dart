// ignore: dangling_library_doc_comments
import 'package:beasy/blocs/booking/booking_event.dart';
import 'package:beasy/blocs/booking/booking_state.dart';
import 'package:beasy/exceptions/app_exceptions.dart';
import 'package:beasy/models/booking_model.dart';
import 'package:beasy/models/product_model.dart';
import 'package:beasy/models/user_model.dart';
import 'package:beasy/repositories/repos/mutable_booking_repo.dart';
import 'package:beasy/repositories/repos/user_repo.dart';
import 'package:flutter/foundation.dart';
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

    on<BookingEventInitial>(
      (event, emit) => emit(BookingStateInitial()),
    );
    on<BookingEventCreateBooking>(
      (event, emit) async {
        try {
          final ProductModel product = event.product;
          final UserModel user = UserRepo().currentUser;
          final BookingModel model = BookingModel(
            id: "",
            serviceId: product.id,
            serviceProviderId: product.ownerId,
            rentalUserId: user.uid,
            bookingDate: event.selectedDate,
            createdAt: DateTime.now(),
            status: BookingStatus.pending,
            car: product.name,
          );
          emit(BookingStateBookingCreating());
          await MutableBookingRepo().create(model: model);
          emit(BookingStateBooked());
        } on AppException catch (e) {
          emit(BookingStateBookingFailure(exception: e));
        }
      },
    );

    /// Update Booking Event
    on<BookingEventUpdateBooking>(
      (event, emit) async {
        try {
          final BookingModel model = event.bookingModel.copyWith(
            bookingDate: event.selectedDate,
            updatedDate: DateTime.now(),
          );
          emit(BookingStateBookingUpdating());
          final BookingModel updatedModel =
              await MutableBookingRepo().update(model: model);
          emit(BookingStateBookingUpdated(booking: updatedModel));
        } on AppException catch (e) {
          emit(BookingStateUpdateBookingFailure(exception: e));
        }
      },
    );
    // /// on Service Provider Booking Fetching
    // on<BookingEventFetchForServiceProvider>(
    //   (event, emit) async {
    //     try {
    //       emit(BookingStateFetchingBookings());
    //       final List<BookingModel> bookings =
    //           await ImmutableBookingRepo().fetchForServiceProvider();
    //       emit(BookingStateFetchBookingSuccess(bookings: bookings));
    //     } on AppException catch (e) {
    //       debugPrint(e.message);
    //       emit(BookingStateFetchBookingsFailure(exception: e));
    //     }
    //   },
    // );

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

    /// on rental user Booking Fetching
    on<BookingEventFetchCurrentUserBookings>(
      (event, emit) async {
        try {
          emit(BookingStateFetchingBookings());
          final List<BookingModel> bookings =
              await ImmutableBookingRepo().fetchForRentalUserAndSP();
          emit(BookingStateFetchBookingSuccess(bookings: bookings));
        } on AppException catch (e) {
          emit(BookingStateFetchBookingsFailure(exception: e));
        }
      },
    );

    /// OnUser Profile Fetch
    on<BookingEventFetchUserProfile>(
      (event, emit) async {
        try {
          final UserModel user =
              await UserRepo().fetchUser(profileId: event.profileId);
          emit(BookingStateUserProfileFetched(user: user));
        } on AppException catch (e) {
          debugPrint(e.message);
        }
      },
    );
  }
}
