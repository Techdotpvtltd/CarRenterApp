// ignore: dangling_library_doc_comments
import 'package:beasy/exceptions/exception_parsing.dart';
import 'package:beasy/models/booking_model.dart';
import 'package:beasy/models/query_model.dart';
import 'package:beasy/models/user_model.dart';
import 'package:beasy/repositories/repos/user_repo.dart';
import 'package:beasy/utilities/constants/constants.dart';
import 'package:beasy/web_services/firestore_services.dart';

/// Project: 	   CarRenterApp
/// File:    	   immutable_booking_repo
/// Path:    	   lib/repositories/repos/immutable_booking_repo.dart
/// Author:       Ali Akbar
/// Date:        29-02-24 14:26:41 -- Thursday
/// Description:

class ImmutableBookingRepo {
  // ===========================Signleton Instance================================

  /// Fetching Bookings For Service Provider
  Future<List<BookingModel>> fetchForServiceProvider() async {
    try {
      final UserModel user = UserRepo().currentUser;
      final List<Map<String, dynamic>> data =
          await FirestoreService().fetchWithMultipleConditions(
        collection: FIREBASE_COLLECTION_BOOKING,
        queries: [
          QueryModel(
              field: "serviceProviderId",
              value: user.uid,
              type: QueryType.isEqual),
          QueryModel(
              field: "status",
              value: BookingStatus.rejected.name.toLowerCase(),
              type: QueryType.isNotEqual),
        ],
      );
      return data.map((e) => BookingModel.fromMap(e)).toList();
    } catch (e) {
      throw thrownAppException(e: e);
    }
  }

  /// Fetching Bookings for Individual Services
  Future<List<BookingModel>> fetchForIndividualServices(
      {required String serviceId}) async {
    try {
      final List<Map<String, dynamic>> data = await FirestoreService()
          .fetchWithMultipleConditions(
              collection: FIREBASE_COLLECTION_BOOKING,
              queries: [
            QueryModel(
              field: "status",
              value: [
                BookingStatus.accepted.name.toString(),
                BookingStatus.pending.name.toString(),
                BookingStatus.paid.name.toString(),
              ],
              type: QueryType.whereIn,
            ),
            QueryModel(
                field: "serviceId", value: serviceId, type: QueryType.isEqual),
          ]);
      return data.map((e) => BookingModel.fromMap(e)).toList();
    } catch (e) {
      throw thrownAppException(e: e);
    }
  }

  /// Fetching Bookings for Rental User
  Future<List<BookingModel>> fetchForRentalUser() async {
    try {
      final String userId = UserRepo().currentUser.uid;
      final List<Map<String, dynamic>> data = await FirestoreService()
          .fetchWithMultipleConditions(
              collection: FIREBASE_COLLECTION_BOOKING,
              queries: [
            QueryModel(
                field: "bookingUserId", value: userId, type: QueryType.isEqual),
          ]);
      return data.map((e) => BookingModel.fromMap(e)).toList();
    } catch (e) {
      throw thrownAppException(e: e);
    }
  }
}
